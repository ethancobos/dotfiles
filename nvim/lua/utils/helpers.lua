local M = {}

-- find element v of l satisfying f(v)
function M.find(l, value)
    for _, v in ipairs(l) do
        if v == value then
            return v
        end
    end
    return nil
end

function M.file_exists(path)
    local stat = vim.loop.fs_stat(path)
    return (stat and stat.type) == "file"
end

function M.link_exists(path)
    local stat = vim.loop.fs_lstat(path)
    return (stat and stat.type) == "link"
end

return M
