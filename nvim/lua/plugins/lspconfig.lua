local amazon = require("utils.amazon")

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
                local map = function(keys, func, desc, mode)
                    mode = mode or 'n'
                    vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
                end

                local client = vim.lsp.get_client_by_id(event.data.client_id)

                -- Rename the variable under your cursor.
                --  Most Language Servers support renaming across files, etc.
                map('grn', vim.lsp.buf.rename, '[R]e[n]ame')

                -- Execute a code action, usually your cursor needs to be on top of an error
                -- or a suggestion from your LSP for this to activate.
                map('gra', vim.lsp.buf.code_action, '[G]oto Code [A]ction', { 'n', 'x' })

                -- Find references for the word under your cursor.
                map('grr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')

                -- Jump to the implementation of the word under your cursor.
                --  Useful when your language has ways of declaring types without an actual implementation.
                map('gri', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')

                -- Jump to the definition of the word under your cursor.
                --  This is where a variable was first declared, or where a function is defined, etc.
                --  To jump back, press <C-t>.
                map('grd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')

                -- WARN: This is not Goto Definition, this is Goto Declaration.
                --  For example, in C this would take you to the header.
                map('grD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')

                -- Fuzzy find all the symbols in your current document.
                --  Symbols are things like variables, functions, types, etc.
                map('gO', require('telescope.builtin').lsp_document_symbols, 'Open Document Symbols')

                -- Fuzzy find all the symbols in your current workspace.
                --  Similar to document symbols, except searches over your entire project.
                map('gW', require('telescope.builtin').lsp_dynamic_workspace_symbols, 'Open Workspace Symbols')

                -- Jump to the type of the word under your cursor.
                --  Useful when you're not sure what type a variable is and you want to see
                --  the definition of its *type*, not where it was *defined*.
                map('grt', require('telescope.builtin').lsp_type_definitions, '[G]oto [T]ype Definition')

                if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_codeLens, event.buf) then
                    vim.api.nvim_create_autocmd({ "BufEnter", "CursorHold", "InsertLeave" }, {
                        callback = function(args)
                            vim.lsp.codelens.refresh({ bufnr = args.buf })
                        end
                    })
                end

                -- Rub-lsp does not support multi-root workspaces
                if client and client.name ~= "ruby-lsp" then
                    amazon.add_all_ws_folder_bemol()
                end
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
            -- ruby-lsp currently cannot handle square brackets in directory names which brazil creates
            -- in the build folder so for now we will just get rid of the convenience symlink
            -- amazon.remove_ruby_build_symlink_if_exists(client)
        end

        vim.lsp.config("*", { capabilities = capabilities, on_init = on_init })
        vim.lsp.config("lua-language-server", require("lsp.lua-language-server"))
        vim.lsp.config("pyright", require("lsp.pyright"))
        vim.lsp.config("ruby-lsp", require("lsp.ruby-lsp"))
        vim.lsp.config("jdtls", require("lsp.jdtls"))
        vim.lsp.enable({
            "lua-language-server",
            "pyright",
            "ruby-lsp",
            "jdtls",
        })
    end,
}
