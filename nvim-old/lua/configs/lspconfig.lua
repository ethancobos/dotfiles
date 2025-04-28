require("nvchad.configs.lspconfig").defaults()
local utils = require("configs.utils")

local servers = {
    -- Python
    pyright = {
        settings = {
            pyright = {
                disableOrganizeImports = true, -- Using Ruff
            },
            python = {
                analysis = {
                    ignore = { "*" }, -- Using Ruff
                    typeCheckingMode = "off", -- Using mypy
                },
                pythonPath = ".venv/bin/python3", -- find my virtual environment
            },
        },
    },

    -- Ruby
    ruby_lsp = {
        init_options = {
            enabledFeatures = {
                codeActions = true,
                codeLens = true,
                completion = true,
                definition = true,
                diagnostics = true,
                documentHighlights = true,
                documentLink = true,
                documentSymbols = true,
                foldingRanges = true,
                formatting = false,
                hover = true,
                inlayHint = true,
                onTypeFormatting = true,
                selectionRanges = true,
                semanticHighlighting = true,
                signatureHelp = true,
                typeHierarchy = true,
                workspaceSymbol = true,
            },
            featuresConfiguration = {
                inlayHint = {
                    implicitHashValue = true,
                    implicitRescue = true,
                },
            },
            indexing = {
                includedPatterns = utils.get_bemol_farms_if_exists(".solargraph.yml"),
            },
            -- formatter = "standard",
            -- linters = {
            --     "standard",
            -- },
            experimentalFeaturesEnabled = false,
        },
    },
}

for name, opts in pairs(servers) do
    vim.lsp.enable(name)
    vim.lsp.config(name, opts)
end
