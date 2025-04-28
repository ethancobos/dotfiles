return {
    "neovim/nvim-lspconfig",
    event = "User FilePost",
    config = function()
        dofile(vim.g.base46_cache .. "lsp")

        -- Diagnostic config
        require("nvchad.lsp").diagnostic_config()

        -- LspAttach autocmd
        vim.api.nvim_create_autocmd("LspAttach", {
            callback = function(event)
                local map = function(mode, keys, func, desc)
                    mode = mode or "n"
                    vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
                end

                map("n", "gD", vim.lsp.buf.declaration, "Go to declaration")
                map("n", "gd", vim.lsp.buf.definition, "Go to definition")
                map("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, "Add workspace folder")
                map("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, "Remove workspace folder")
                map("n", "<leader>wl", function()
                    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
                end, "List workspace folders")
                map("n", "<leader>D", vim.lsp.buf.type_definition, "Go to type definition")
                map("n", "<leader>ra", require("nvchad.lsp.renamer"), "NvRenamer")
            end,
        })

        -- capabilities
        local capabilities = vim.lsp.protocol.make_client_capabilities()

        capabilities.textDocument.completion.completionItem = {
            documentationFormat = { "markdown", "plaintext" },
            snippetSupport = true,
            preselectSupport = true,
            insertReplaceSupport = true,
            labelDetailsSupport = true,
            deprecatedSupport = true,
            commitCharactersSupport = true,
            tagSupport = { valueSet = { 1 } },
            resolveSupport = {
                properties = {
                    "documentation",
                    "detail",
                    "additionalTextEdits",
                },
            },
        }

        -- on init
        local on_init = function(client, _)
            if client.supports_method("textDocument/semanticTokens") then
                client.server_capabilities.semanticTokensProvider = nil
            end
        end

        vim.lsp.config("*", { capabilities = capabilities, on_init = on_init })
        vim.lsp.enable({
            "lua-language-server",
            "pyright",
            "ruby-lsp",
            -- "jdtls",
        })
    end,
}
