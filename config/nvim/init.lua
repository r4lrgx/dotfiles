-- Basic settings
vim.g.mapleader = " "
vim.o.number = true
vim.o.relativenumber = true
vim.o.termguicolors = true
vim.o.tabstop = 2
vim.o.shiftwidth = 2
vim.o.expandtab = true
vim.o.smartindent = true
vim.o.wrap = false
vim.o.cursorline = true
vim.o.clipboard = "unnamedplus"

-- Auto install packer plugin manager
local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath("data").."/site/pack/packer/start/packer.nvim"
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({"git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path})
    vim.cmd("packadd packer.nvim")
    return true
  end
  return false
end
local packer_bootstrap = ensure_packer()

-- Plugins
require("packer").startup(function(use)
  -- Package manager
  use "wbthomason/packer.nvim"

  -- Utilities
  use "nvim-lua/plenary.nvim"

  -- File explorer
  use "nvim-tree/nvim-tree.lua"
  use "nvim-tree/nvim-web-devicons"

  -- Telescope fuzzy finder
  use "nvim-telescope/telescope.nvim"

  -- Syntax highlighting
  use { "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" }

  -- Statusline
  use "nvim-lualine/lualine.nvim"

  -- Autocompletion
  use "hrsh7th/nvim-cmp"
  use "hrsh7th/cmp-nvim-lsp"
  use "hrsh7th/cmp-buffer"
  use "hrsh7th/cmp-path"
  use "hrsh7th/cmp-cmdline"

  -- LSP
  use "neovim/nvim-lspconfig"

  -- Colorscheme (TokyoNight)
  use "folke/tokyonight.nvim"

  if packer_bootstrap then
    require("packer").sync()
  end
end)

-- Theme
vim.cmd("colorscheme tokyonight")

-- NVIM-TREE
require("nvim-tree").setup()
vim.keymap.set("n", "<C-n>", ":NvimTreeToggle<CR>", { noremap = true, silent = true })

-- Telescope
local builtin = require("telescope.builtin")
vim.keymap.set("n", "<C-p>", builtin.find_files, {})
vim.keymap.set("n", "<leader>fg", builtin.live_grep, {})

-- Treesitter
require("nvim-treesitter.configs").setup {
  highlight = { enable = true },
  indent = { enable = true }
}

-- LSP
local lspconfig = require("lspconfig")
local capabilities = require("cmp_nvim_lsp").default_capabilities()

lspconfig.lua_ls.setup { capabilities = capabilities }
lspconfig.ts_ls.setup { capabilities = capabilities }
lspconfig.pyright.setup { capabilities = capabilities }

-- NVIM-CMP (Autocompletion)
local cmp = require("cmp")
cmp.setup {
  snippet = { expand = function() end },
  mapping = cmp.mapping.preset.insert({
    ["<C-Space>"] = cmp.mapping.complete(),
    ["<CR>"] = cmp.mapping.confirm({ select = true }),
  }),
  sources = cmp.config.sources({
    { name = "nvim_lsp" },
    { name = "buffer" },
    { name = "path" }
  })
}

-- Lualine (Statusline)
require("lualine").setup {
  options = { theme = "tokyonight" }
}
