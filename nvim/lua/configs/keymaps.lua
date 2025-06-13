-- This is where I put keymaps that I want to load on startup.
-- Alternatively, other keymaps may be in their respective plugin file.

local map = vim.keymap.set

-- ╭──────────────────────────────────────────────╮
-- │                  General                     │
-- ╰──────────────────────────────────────────────╯

map("n", ";", ":", { desc = "CMD enter command mode" })
map("n", "<Esc>", "<cmd>noh<CR>", { desc = "general clear highlights" })
map("n", "<C-s>", "<cmd>w<CR>", { desc = "general save file" })
map("n", "<C-c>", "<cmd>%y+<CR>", { desc = "general copy whole file" })

-- ╭──────────────────────────────────────────────╮
-- │                  Navigation                  │
-- ╰──────────────────────────────────────────────╯

map("n", "<C-h>", "<cmd> TmuxNavigateLeft<CR>", { desc = "window left" })
map("n", "<C-j>", "<cmd> TmuxNavigateDown<CR>", { desc = "window down" })
map("n", "<C-k>", "<cmd> TmuxNavigateUp<CR>", { desc = "window up" })
map("n", "<C-l>", "<cmd> TmuxNavigateRight<CR>", { desc = "window right" })

map("i", "<C-a>", "<ESC>^i", { desc = "move beginning of line" })
map("i", "<C-e>", "<End>", { desc = "move end of line" })
map("i", "<C-h>", "<Left>", { desc = "move left" })
map("i", "<C-j>", "<Down>", { desc = "move down" })
map("i", "<C-k>", "<Up>", { desc = "move up" })
map("i", "<C-l>", "<Right>", { desc = "move right" })

-- ╭──────────────────────────────────────────────╮
-- │                  Tabufline                   │
-- ╰──────────────────────────────────────────────╯

map("n", "<leader>b", "<cmd>enew<CR>", { desc = "buffer new" })

map("n", "<tab>", function()
    require("nvchad.tabufline").next()
end, { desc = "buffer goto next" })

map("n", "<S-tab>", function()
    require("nvchad.tabufline").prev()
end, { desc = "buffer goto prev" })

map("n", "<leader>x", function()
    require("nvchad.tabufline").close_buffer()
end, { desc = "buffer close" })

-- ╭──────────────────────────────────────────────╮
-- │                  NvimTree                    │
-- ╰──────────────────────────────────────────────╯

map("n", "<C-n>", "<cmd>NvimTreeToggle<CR>", { desc = "nvimtree toggle window" })
map("n", "<leader>e", "<cmd>NvimTreeFocus<CR>", { desc = "nvimtree focus window" })

-- ╭──────────────────────────────────────────────╮
-- │                  Themeing                    │
-- ╰──────────────────────────────────────────────╯

map("n", "<leader>th", function()
    require("nvchad.themes").open()
end, { desc = "telescope nvchad themes" })

-- ╭──────────────────────────────────────────────╮
-- │                  WhichKey                    │
-- ╰──────────────────────────────────────────────╯

map("n", "<leader>wK", "<cmd>WhichKey <CR>", { desc = "whichkey all keymaps" })

map("n", "<leader>wk", function()
    vim.cmd("WhichKey " .. vim.fn.input("WhichKey: "))
end, { desc = "whichkey query lookup" })

-- ╭──────────────────────────────────────────────╮
-- │                    Oil                       │
-- ╰──────────────────────────────────────────────╯

map("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })

-- ╭──────────────────────────────────────────────╮
-- │               Global Toggles                 │
-- ╰──────────────────────────────────────────────╯

map("n", "<leader>td", function()
    vim.diagnostic.enable(not vim.diagnostic.is_enabled())
end, { desc = "[T]oggle [D]iagnostics" })

map("n", "<leader>tn", "<cmd>set nu!<CR>", { desc = "toggle line number" })
map("n", "<leader>trn", "<cmd>set rnu!<CR>", { desc = "toggle relative number" })
map("n", "<leader>tch", "<cmd>NvCheatsheet<CR>", { desc = "toggle nvcheatsheet" })
