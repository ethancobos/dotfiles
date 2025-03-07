local lint = require("lint")
local linters = require("lint").linters

-- indlude linters here
lint.linters_by_ft = {
    python = { "mypy", "ruff" },
}

-- to change args, first add in all of the nvim-lint default args then add/remove your own
-- find defaults here: https://github.com/mfussenegger/nvim-lint/tree/master/lua/lint/linters
linters.mypy.args = {

    -- these 2 lines are specific to how I develop in python, I always use a virtual env called `env`
    -- and I store my global mypy config in my home directory
    "--python-executable",
    ".venv/bin/python3",

    "--show-column-numbers",
    "--show-error-end",
    "--hide-error-context",
    "--no-color-output",
    "--no-error-summary",
    "--no-pretty",
}

linters.ruff.args = {
    "check",
    "--force-exclude",
    "--quiet",
    "--stdin-filename",
    vim.api.nvim_buf_get_name(0),
    "--no-fix",
    "--output-format",
    "json",
    "-",
}

vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
    callback = function()
        lint.try_lint()
    end,
})
