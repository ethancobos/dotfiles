local M = {}

function M.file_exists(path)
    local stat = vim.loop.fs_stat(path)
    return (stat and stat.type) == "file"
end

function M.link_exists(path)
    local stat = vim.loop.fs_lstat(path)
    return (stat and stat.type) == "link"
end

return M
