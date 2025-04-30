local helpers = require("utils.helpers")

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

-- For brazil integration
function M.bemol()
    local bemol_dir = vim.fs.find({ ".bemol" }, { upward = true, type = "directory" })[1]
    local ws_folders_lsp = {}
    if bemol_dir then
        local file = io.open(bemol_dir .. "/ws_root_folders", "r")
        if file then
            for line in file:lines() do
                table.insert(ws_folders_lsp, line)
            end
            file:close()
        end
    end
    local current_ws_folders = vim.lsp.buf.list_workspace_folders()
    for _, line in ipairs(ws_folders_lsp) do
        if not M.find(current_ws_folders, line) then
            vim.lsp.buf.add_workspace_folder(line)
        end
    end
end

function M.get_bemol_farms_if_exists(filepath)
    if vim.fn.filereadable(filepath) == 0 then
        return {} -- File doesn't exist
    end

    local lines = vim.fn.readfile(filepath)
    local includes = {}

    local inside_include_block = false

    for _, line in ipairs(lines) do
        if line:match("^include:") then
            inside_include_block = true
        elseif inside_include_block then
            local path = line:match("%- (.+)")
            if path then
                table.insert(includes, vim.trim(path))
            else
                -- Once we hit a non-path line, stop parsing
                break
            end
        end
    end

    return includes
end

function M.remove_ruby_build_symlink_if_exists(client)
    -- ensures that is only removes if it is a link
    if client and client.name == "ruby-lsp" and helpers.link_exists("build") then
        os.remove("build")
    end
end

return M
