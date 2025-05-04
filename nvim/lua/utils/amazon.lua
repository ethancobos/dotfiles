local helpers = require("utils.helpers")

local M = {}

-- get all of the current ws folder paths from bemol
function M.get_bemol_ws_folders()
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
    return ws_folders_lsp
end

-- Adds all of the ws folders to lsp workspace
--
-- Bemol works by generating lsp config files in each ws which the lsp would
-- ideally pick up automatically. We need to jump through some hoops for ruby-lsp
-- however since bemol is only supported by solargraph
function M.add_all_ws_folder_bemol()
    local ws_folders_lsp = M.get_bemol_ws_folders()
    local current_ws_folders = vim.lsp.buf.list_workspace_folders()
    for _, line in ipairs(ws_folders_lsp) do
        if not helpers.find(current_ws_folders, line) then
            vim.lsp.buf.add_workspace_folder(line)
        end
    end
end

-- This function is doing a lot. Bemol only supports solargraph for ruby development, but
-- solargraph sucks. Instead what we can do is get the ruby farms that bemol generates out
-- of each packages .solargraph.yml file and pass them to a ruby-lsp instance rooted at
-- the brazil ws root. The reason we do this is because ruby-lsp does not support multi
-- root workspaces like jdtls. Its a very hacky solution that works like 99% of the time.
-- but unfortunately ruby-lsp breaks when you build an lpt package because the build folder
-- has directories with square brackets in the name and the URI parser freaks out and yells
-- about a "bad component"
function M.get_bemol_farms_if_exists()
    local ws_folders_lsp = M.get_bemol_ws_folders()
    local ruby_farms = {}

    for _, filepath in ipairs(ws_folders_lsp) do
        local solargraph = filepath .. "/.solargraph.yml"

        if vim.fn.filereadable(solargraph) == 1 then
            local lines = vim.fn.readfile(solargraph)

            for _, line in ipairs(lines) do
                -- Only include bemol farms
                local path = string.match(line, "%- .*(%.bemol.+)")
                if path then
                    local path_trimmed = vim.trim(path)

                    if not helpers.find(ruby_farms, path_trimmed) then
                        table.insert(ruby_farms, path_trimmed)
                    end
                end
            end
        end
    end
    return ruby_farms
end

function M.remove_ruby_build_symlink_if_exists(client)
    -- ensures that is only removes if it is a link
    if client and client.name == "ruby-lsp" and helpers.link_exists("build") then
        os.remove("build")
    end
end

return M
