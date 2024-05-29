local plugins = {

  -- tmux integration with nvim
  {
    "christoomey/vim-tmux-navigator",
    lazy = false,
  },

  -- loads my custom lspconfig and the default
  {
    "neovim/nvim-lspconfig",
    config = function ()
      require "plugins.configs.lspconfig"
      require "custom.configs.lspconfig"
    end,
  },

  -- lets me auto format on save for rust code
  {
    "rust-lang/rust.vim",
    ft = "rust",
    init = function ()
      vim.g.rustfmt_autosave = 1
    end,
  },

  -- for trouble package
  {
    'nvim-tree/nvim-web-devicons',
  },

  -- lets me see lsp errors in their own buffer
  {
    "folke/trouble.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {},
    lazy = false,
  },

  -- only highlight 80th column if it exceeds somewhere
  {
    "m4xshen/smartcolumn.nvim",
    opts = {
      disabled_filetypes = {"help", "text", "markdown", "Trouble"   },
    },
    lazy = false
  },
}
return plugins
