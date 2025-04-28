-- This is where i give lazy all of my plugin configurations
require("lazy").setup({
    "tpope/vim-sleuth", -- Detect tabstop and shiftwidth automatically

    require("kickstart/plugins/gitsigns"),

    require("kickstart/plugins/which-key"),

    require("kickstart/plugins/telescope"),

    require("kickstart/plugins/lspconfig"),

    require("kickstart/plugins/conform"),

    require("kickstart/plugins/blink-cmp"),

    require("kickstart/plugins/tokyonight"),

    require("kickstart/plugins/todo-comments"),

    require("kickstart/plugins/mini"),

    require("kickstart/plugins/treesitter"),

    require("kickstart.plugins.debug"),

    require("kickstart.plugins.indent_line"),

    require("kickstart.plugins.lint"),

    require("kickstart.plugins.autopairs"),

    require("kickstart.plugins.neo-tree"),
})
