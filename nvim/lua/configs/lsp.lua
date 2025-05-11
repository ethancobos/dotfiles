local amazon = require("utils.amazon")
local helpers = require("utils.helpers")
local x = vim.diagnostic.severity

-- ╭──────────────────────────────────────────────╮
-- │           Language Server Settings           │
-- ╰──────────────────────────────────────────────╯

local enabled_servers = {
    "lua-language-server",
    "pyright",
    "ruby-lsp",
    "jdtls",
    "yaml-language-server",
    "bash-language-server",
}

-- if a language server is supported in bemol and can support a multi-root ws, add it here
local bemol_multi_root_lsp = {
    "jdtls"
}

-- ╭──────────────────────────────────────────────╮
-- │                 User Commands                │
-- ╰──────────────────────────────────────────────╯

vim.api.nvim_create_user_command('LspInfo', ':checkhealth vim.lsp', { desc = 'Alias to `:checkhealth vim.lsp`' })

-- ╭──────────────────────────────────────────────╮
-- │              Diagnostic Config               │
-- ╰──────────────────────────────────────────────╯

vim.diagnostic.config {
    virtual_text = { prefix = "" },
    signs = {
        text = {
            [x.ERROR] = "󰅙",
            [x.WARN] = "",
            [x.INFO] = "󰋼",
            [x.HINT] = "󰌵" }
    },
    underline = true,
    float = { border = "single" },
}

-- ╭──────────────────────────────────────────────╮
-- │                 LspAttach                    │
-- ╰──────────────────────────────────────────────╯

vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(event)
        local map = function(keys, func, desc, mode)
            mode = mode or 'n'
            vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
        end

        local client = vim.lsp.get_client_by_id(event.data.client_id)

        map('grn', vim.lsp.buf.rename, '[R]e[n]ame')
        map('gra', vim.lsp.buf.code_action, '[G]oto Code [A]ction', { 'n', 'x' })
        map('grD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
        map('grr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
        map('gri', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')
        map('grd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')
        map('gO', require('telescope.builtin').lsp_document_symbols, 'Open Document Symbols')
        map('gW', require('telescope.builtin').lsp_dynamic_workspace_symbols, 'Open Workspace Symbols')
        map('grt', require('telescope.builtin').lsp_type_definitions, '[G]oto [T]ype Definition')

        if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_codeLens, event.buf) then
            vim.api.nvim_create_autocmd({ "BufEnter", "TextChanged", "InsertLeave" }, {
                callback = function(args)
                    vim.lsp.codelens.refresh({ bufnr = args.buf })
                end
            })
        end

        -- Add all brazil ws packages as ws roots if lsp/bemol can handle it
        if client and helpers.find(bemol_multi_root_lsp, client.name) then
            amazon.add_all_ws_folder_bemol()
        end
    end,
})

-- ╭──────────────────────────────────────────────╮
-- │                 Capabilities                 │
-- ╰──────────────────────────────────────────────╯

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

-- ╭──────────────────────────────────────────────╮
-- │                   on_init                    │
-- ╰──────────────────────────────────────────────╯

local on_init = function(client, _)
    if client.supports_method("textDocument/semanticTokens") then
        client.server_capabilities.semanticTokensProvider = nil
    end
    -- ruby-lsp currently cannot handle square brackets in directory names which brazil creates
    -- in the build folder so for now we will just get rid of the convenience symlink
    -- amazon.remove_ruby_build_symlink_if_exists(client)
end

-- ╭──────────────────────────────────────────────╮
-- │                   config                     │
-- ╰──────────────────────────────────────────────╯

vim.lsp.config("*", { capabilities = capabilities, on_init = on_init })
vim.lsp.enable(enabled_servers)
