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

  -- lets me see lsp errors in their own buffer
  {
    "folke/trouble.nvim",
    opts = {},
    cmd = "Trouble",
    keys = {
      {
        "<leader>xx",
        "<cmd>Trouble diagnostics toggle<cr>",
        desc = "Diagnostics (Trouble)",
      },
    },
    lazy = false,
  },

  -- only highlight 80th column if it exceeds somewhere
  {
    "m4xshen/smartcolumn.nvim",
    opts = {
      disabled_filetypes = {"help", "text", "markdown", "Trouble"},
    },
    lazy = false
  },

  -- python static analysis and linting
  {
    "nvimtools/none-ls.nvim",
    ft = {"python"},
    opts = function()
      return require "custom.configs.null-ls"
    end,
  },
}
return plugins
