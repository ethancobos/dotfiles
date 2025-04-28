dofile(vim.g.base46_cache .. "git")

return {
    "lewis6991/gitsigns.nvim",
    event = "User FilePost",
    opts = {
        signs = {
            delete = { text = "󰍵" },
            changedelete = { text = "󱕖" },
        },
    },
}
