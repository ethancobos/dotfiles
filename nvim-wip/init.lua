vim.g.base46_cache = vim.fn.stdpath("data") .. "/base46_cache/"
-- Set <space> as the leader key
--  NOTE: Must happen before plugins are loaded (otherwise wrong leader will be used)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Always use a nerd font
vim.g.have_nerd_font = true

-- Setting options
require("options")

-- Setting autocommands
require("autocmds")

-- Basic Keymaps
require("keymaps")

-- Install `lazy.nvim` plugin manager
require("lazy-bootstrap")

-- Configure and install plugins
require("lazy-plugins")

-- Configure LSPs
require("configs.lsp")

dofile(vim.g.base46_cache .. "defaults")
dofile(vim.g.base46_cache .. "statusline")
