local helpers = require("utils.helpers")

local function set_python_path(path)
    if helpers.file_exists(path) then
        local clients = vim.lsp.get_clients({
            bufnr = vim.api.nvim_get_current_buf(),
            name = "pyright",
        })
        for _, client in ipairs(clients) do
            if client.settings then
                client.settings.python = vim.tbl_deep_extend("force", client.settings.python, { pythonPath = path })
            else
                client.config.settings =
                    vim.tbl_deep_extend("force", client.config.settings, { python = { pythonPath = path } })
            end
            client.notify("workspace/didChangeConfiguration", { settings = nil })
        end
    end
end

return {
    cmd = { "pyright-langserver", "--stdio" },
    filetypes = { "python" },
    root_markers = {
        "pyproject.toml",
        "setup.py",
        "setup.cfg",
        "requirements.txt",
        "Pipfile",
        "pyrightconfig.json",
        ".git",
    },
    settings = {
        pyright = {
            disableOrganizeImports = true, -- Using Ruff
        },
        python = {
            analysis = {
                ignore = { "*" }, -- Using Ruff
                typeCheckingMode = "off", -- Using mypy
            },
        },
    },
    on_attach = function(_, bufnr)
        vim.api.nvim_buf_create_user_command(bufnr, "LspPyrightSetPythonPath", set_python_path, {
            desc = "Reconfigure pyright with the provided python path",
            nargs = 1,
            complete = "file",
        })
    end,
}
