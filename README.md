# 📂 ~/.dotfiles

<div align="center">
  <a aria-label="License" href="https://github.com/r4lrgx/dotfiles/blob/main/LICENSE.md">
    <img src="https://img.shields.io/github/license/r4lrgx/dotfiles?style=flat-square&logo=github&color=limegreen&label=License">
  </a>
  <a aria-label="Version" href="https://github.com/r4lrgx/dotfiles/releases">
    <img src="https://img.shields.io/github/v/release/r4lrgx/dotfiles?style=flat-square&logo=github&color=limegreen&label=Latest">
  </a>
  <a aria-label="Issues" href="https://github.com/r4lrgx/dotfiles/issues">
    <img src="https://img.shields.io/github/issues/r4lrgx/dotfiles?style=flat-square&logo=github&color=limegreen&label=Issues">
  </a>
</div>

## 📸 Preview

## 🤖 Setup

Clone the repository with all its submodules and launch the installation script:

```bash
# Clone into home directory
git clone --recurse-submodules https://github.com/r4lrgx/dotfiles ~/.dotfiles

# Enter the folder and execute the installer
cd ~/.dotfiles && ./install

# Reload the shell to apply changes
exec zsh
```

## 📦 What’s Inside?

- `config/` – Config folders for different tools:
  - `astro/` – [Astro](https://astro.build/) setup for static site projects.
  - `btop/` – [btop](https://github.com/aristocratos/btop) system monitor settings.
  - `Code/` – [Visual Studio Code](https://code.visualstudio.com/) preferences and extensions list.
  - `fastfetch/` – [fastfetch](https://github.com/fastfetch-cli/fastfetch) system info display tweaks.
  - `gh/` – [GitHub CLI](https://cli.github.com/) configuration.
  - `go/` – [Go](https://go.dev/) environment setup and tooling.
  - `nextjs-nodejs/` – Templates and configs for [Next.js](https://nextjs.org/) + [Node.js](https://nodejs.org/).
  - `nvim/` – [Neovim](https://neovim.io/) with themes, plugins and personal keymaps.
  - `turborepo/` – [Turborepo](https://turbo.build/) workspace configuration.
- `extras/` – Miscellaneous:
  - `fonts/` – Custom fonts collection.
  - `WNDX/` – Windows helper files (non-essential, can be skipped).
- `home/` – Dotfiles for the home directory:
  - `bin/` – Handy scripts to improve productivity.
  - `git/` – [Git](https://git-scm.com/) configuration + aliases (with some extras).
- `zsh/` – [Zsh](https://www.zsh.org/) configured with [Oh My Zsh](https://ohmyz.sh/), featuring custom aliases and tweaks for dev-env like [Go](https://go.dev/), [Node.js](https://nodejs.org/), and more.
  - `plugins/` – Extra Zsh plugins for an improved shell experience:
    - [`zsh-autocomplete/`](https://github.com/marlonrichert/zsh-autocomplete) – Adds real-time and context-aware command autocompletion.
    - [`zsh-autosuggestions/`](https://github.com/zsh-users/zsh-autosuggestions) – Suggests commands as you type based on history and usage.
    - [`zsh-syntax-highlighting/`](https://github.com/zsh-users/zsh-syntax-highlighting) – Highlights commands in the shell for better readability and fewer mistakes.
  - `theme/` – Zsh theme customization:
    - [`powerlevel10k/`](https://github.com/romkatv/powerlevel10k) – A fast and highly customizable prompt theme with icons and advanced UI elements.

## 🎯 Contributing

### 🔩 Reporting Issues

If you encounter any bugs or problems while using the tool, please open a new [issue here](../../issues).
To help us assist you faster, include as much detail as possible, such as:

- What you were trying to do.
- Any error messages or console logs.
- Your environment details (OS, versions, etc.)

The more info you provide, the quicker we can identify and fix the problem.

### 🔀 Pull Requests

Thanks for wanting to contribute! To submit improvements or fixes, please follow these steps:

1. Clone [this repository](https://github.com/r4lrgx/dotfiles.git) using `git clone https://github.com/r4lrgx/dotfiles.git`.
2. Create a new branch from `main` with a clear, descriptive name, for example: `git checkout -b feature/your-feature-name`.
3. Make your changes and commit them with clear, meaningful messages.
4. Open a new [pull request here](../../pulls), explaining what you added or fixed and why.

We’ll carefully review each PR and provide feedback if needed to help you get it merged.

☕ **[Thank you for your support!](https://ko-fi.com/A0A11481X5)**

<!--
## 📞 Contact

If you have any **Questions** or need **Help**, feel free to email me at [tsx@billoneta.xyz](mailto:tsx@billoneta.xyz) or better yet, start a discussion in our **[Github Community](../../discussions)**.
-->

## 📋 License

This repository is distributed under the terms of the **[MIT License](LICENSE.md)**.
