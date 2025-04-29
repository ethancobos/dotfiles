return {
    "mfussenegger/nvim-lint",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
        local lint = require("lint")
        local linters = require("lint").linters

        -- include linters here
        lint.linters_by_ft = {
            python = { "mypy", "ruff" },
            ruby = { "rubocop" },
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

        linters.rubocop.parser = function(output)
            local severity_map = {
                ['fatal'] = vim.diagnostic.severity.ERROR,
                ['error'] = vim.diagnostic.severity.ERROR,
                ['warning'] = vim.diagnostic.severity.WARN,
                ['convention'] = vim.diagnostic.severity.HINT,
                ['refactor'] = vim.diagnostic.severity.INFO,
                ['info'] = vim.diagnostic.severity.INFO,
            }
            local diagnostics = {}
            local decoded = vim.json.decode(output)

            if not decoded.files[1] then
                return diagnostics
            end

            local offences = decoded.files[1].offenses

            for _, off in pairs(offences) do
                local start_line = off.location.start_line - 1
                local start_col = off.location.start_column - 1

                -- If the offense spans multiple lines, limit it to the first line
                local is_multiline = off.location.last_line ~= off.location.start_line
                local end_line = start_line
                local end_col = is_multiline and -1 or off.location.last_column

                table.insert(diagnostics, {
                    source = 'rubocop',
                    lnum = start_line,
                    col = start_col,
                    end_lnum = end_line,
                    end_col = end_col,
                    severity = severity_map[off.severity],
                    message = off.message,
                    code = off.cop_name
                })
            end

            return diagnostics
        end

        vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
            callback = function()
                lint.try_lint()
            end,
        })
    end,
}
