return {
    "nvim-telescope/telescope.nvim",
    cmd = "Telescope",
    event = "VimEnter",
    dependencies = {
        "nvim-treesitter/nvim-treesitter",
        "nvim-lua/plenary.nvim",
        {
            "nvim-telescope/telescope-fzf-native.nvim",

            -- `build` is used to run some command when the plugin is installed/updated.
            -- This is only run then, not every time Neovim starts up.
            build = "make",

            -- `cond` is a condition used to determine whether this plugin should be
            -- installed and loaded.
            cond = function()
                return vim.fn.executable("make") == 1
            end,
        },
        { "nvim-telescope/telescope-ui-select.nvim" },

        -- Useful for getting pretty icons, but requires a Nerd Font.
        { "nvim-tree/nvim-web-devicons", enabled = vim.g.have_nerd_font },
    },
    opts = function()
        dofile(vim.g.base46_cache .. "telescope")
        return {
            defaults = {
                prompt_prefix = "   ",
                selection_caret = " ",
                entry_prefix = " ",
                sorting_strategy = "ascending",
                layout_config = {
                    horizontal = {
                        prompt_position = "top",
                        preview_width = 0.55,
                    },
                    width = 0.87,
                    height = 0.80,
                },
                mappings = {
                    n = { ["q"] = require("telescope.actions").close },
                },
            },

            extensions = {
                ["ui-select"] = {
                    require("telescope.themes").get_dropdown(),
                },
            },
        }
    end,
    config = function(_, opts)
        dofile(vim.g.base46_cache .. "telescope")
        require("telescope").setup(opts)

        pcall(require("telescope").load_extension, "fzf")
        pcall(require("telescope").load_extension, "ui-select")

        local map = vim.keymap.set
        local builtin = require("telescope.builtin")

        map("n", "<leader>sh", builtin.help_tags, { desc = "[S]earch [H]elp" })
        map("n", "<leader>sk", builtin.keymaps, { desc = "[S]earch [K]eymaps" })
        map("n", "<leader>sf", builtin.find_files, { desc = "[S]earch [F]iles" })
        map("n", "<leader>ss", builtin.builtin, { desc = "[S]earch [S]elect Telescope" })
        map("n", "<leader>sw", builtin.grep_string, { desc = "[S]earch current [W]ord" })
        map("n", "<leader>sg", builtin.live_grep, { desc = "[S]earch by [G]rep" })
        map("n", "<leader>sd", builtin.diagnostics, { desc = "[S]earch [D]iagnostics" })
        map("n", "<leader>sr", builtin.resume, { desc = "[S]earch [R]esume" })
        map("n", "<leader>s.", builtin.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
        map("n", "<leader>sb", builtin.buffers, { desc = "[S]earch [B]uffers" })
        map("n", "<leader>sc", builtin.git_commits, { desc = "[S]earch [C]ommits" })
        map("n", "<leader>st", builtin.git_status, { desc = "[S]earch s[T]atus" })

        map("n", "<leader>s/", function()
            builtin.live_grep({
                grep_open_files = true,
                prompt_title = "Live Grep in Open Files",
            })
        end, { desc = "[S]earch [/] in Open Files" })

        -- Shortcut for searching your Neovim configuration files
        map("n", "<leader>sn", function()
            builtin.find_files({ cwd = vim.fn.stdpath("config") })
        end, { desc = "[S]earch [N]eovim files" })

        map("n", "<leader>/", builtin.current_buffer_fuzzy_find, { desc = "[/] Fuzzily search in current buffer" })
    end,
}
