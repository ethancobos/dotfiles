local configs = require("nvchad.configs.lspconfig")

local servers = {
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
}

for name, opts in pairs(servers) do
    opts.on_init = configs.on_init
    opts.on_attach = configs.on_attach
    opts.capabilities = configs.capabilities

    require("lspconfig")[name].setup(opts)
end
