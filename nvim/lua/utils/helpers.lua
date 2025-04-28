local M = {}

function M.file_exists(path)
    local stat = vim.loop.fs_stat(path)
    return (stat and stat.type) == "file"
end

return M
