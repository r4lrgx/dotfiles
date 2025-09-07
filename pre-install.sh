#!/usr/bin/env bash

PURPLE='\033[1;35m'
PINK='\033[1;95m'
CYAN='\033[1;96m'
RESET='\033[0m'
TAG="${PURPLE}[Fedora-Setup]${RESET}"

echo -e "${TAG} ${CYAN}Preparing Fedora environment with required packages...${RESET}"

# Install Languages and compilers
echo -e "${TAG} ${LIGHT_BLUE}Installing programming languages, compilers and frameworks...${RESET}"
sudo dnf install -y python3 python3-pip
echo -e "${TAG} ${CYAN}Python version: $(python3 --version)${RESET}"
echo -e

sudo dnf install -y golang
echo -e "${TAG} ${CYAN}Go version: $(go version)${RESET}"
echo -e

sudo dnf install -y gcc g++ clang
echo -e "${TAG} ${CYAN}GCC version: $(gcc --version | head -n1)${RESET}"
echo -e

curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
export PATH="$HOME/.cargo/bin:$PATH"
echo -e "${TAG} ${CYAN}Rust version: $(rustc --version)${RESET}"
echo -e

curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/master/install.sh | bash
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
nvm install --lts
nvm use --lts
nvm alias default node
echo -e "${TAG} ${CYAN}Node.js version: $(node -v)${RESET}"
echo -e "${TAG} ${CYAN}NPM version: $(npm -v)${RESET}"

# Install Core dev tools
echo -e "${TAG} ${PINK}Installing essential CLI dev tools...${RESET}"
sudo dnf install 'dnf-command(config-manager)' -y
sudo dnf install -y git gh zsh curl unzip btop bat fastfetch atuin neovim tmux fzf
$HOME/.cargo/bin/cargo install eza --locked
$HOME/.cargo/bin/cargo install zoxide --locked
echo -e

# Backup existing configuration files
backup_file() {
    local file=$1
    local local_backup=$2
    if [ -f "$file" ]; then
        if [ ! -f "$local_backup" ]; then
            echo -e "${TAG} ${PURPLE}Backing up $file to $local_backup...${RESET}"
            if cp "$file" "$local_backup"; then
                rm "$file"
            else
                echo -e "${TAG} ${PINK}Failed to backup $file${RESET}"
            fi
        else
            echo -e "${TAG} ${CYAN}$local_backup already exists${RESET}"
        fi
    else
        echo -e "${TAG} ${CYAN}No $file found${RESET}"
    fi
}

backup_file "$HOME/.gitconfig" "$HOME/.gitconfig.local"
backup_file "$HOME/.zshrc" "$HOME/.zshrc.local"
echo -e

# Change default shell to Zsh
ZSH_PATH=$(which zsh)

if ! grep -qx "$ZSH_PATH" /etc/shells; then
    echo -e "${TAG} ${PINK}Zsh path ($ZSH_PATH) is not in /etc/shells. Adding it...${RESET}"
    echo "$ZSH_PATH" | sudo tee -a /etc/shells >/dev/null
fi

if [ "$SHELL" != "$ZSH_PATH" ]; then
    echo -e "${TAG} ${PURPLE}Updating default shell to Zsh...${RESET}"
    sudo chsh -s "$ZSH_PATH" "$USER"
    if [ $? -eq 0 ]; then
        echo -e "${TAG} ${CYAN}Default shell changed to Zsh successfully!${RESET}"
    else
        echo -e "${TAG} ${PINK}Failed to change default shell.${RESET}"
    fi
else
    echo -e "${TAG} ${CYAN}Default shell is already Zsh${RESET}"
fi
echo -e

# Install Oh-My-Zsh
if [ ! -d "$HOME/.oh-my-zsh" ]; then
  echo -e "${TAG} ${PURPLE}Installing Oh-My-Zsh for improved shell features...${RESET}"
  bash -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
else
  echo -e "${TAG} ${CYAN}Oh-My-Zsh is already present${RESET}"
fi
echo -e

# Install Atuin
if [ ! -d "$HOME/.config/atuin" ]; then
  echo -e "${TAG} ${PURPLE}Installing Atuin to enhance terminal history management...${RESET}"
  curl --proto '=https' --tlsv1.2 -LsSf https://setup.atuin.sh | sh
else
  echo -e "${TAG} ${CYAN}Atuin is already present${RESET}"
fi
echo -e

# Link home/bin/ from home/bin/ to ~/.local/bin
mkdir -p "$HOME/.local/bin"
for file in home/bin/*; do
  if [ -f "$file" ]; then
    target="$HOME/.local/bin/$(basename $file)"
    if [ ! -f "$target" ]; then
      echo -e "${TAG} ${PURPLE}Creating symlink for $file -> ~/.local/bin...${RESET}"
      ln -s "$(pwd)/$file" "$target"
      chmod +x "$target"
    else
      echo -e "${TAG} ${CYAN}$(basename $file) is already present linked${RESET}"
    fi
  fi
done

echo -e
echo -e
echo -e "${TAG} ${CYAN}Fedora setup complete! Enjoy your new shell environment.${RESET}"
