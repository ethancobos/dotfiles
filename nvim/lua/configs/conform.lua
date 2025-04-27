local options = {
    formatters_by_ft = {
        lua = { "stylua" },
        -- python = { "ruff_format", "ruff_organize_imports" },
        -- ruby = { "rubocop" },
    },

    format_on_save = {
        -- These options will be passed to conform.format()
        timeout_ms = 5000,
        lsp_fallback = true,
    },
}

require("conform").setup(options)
