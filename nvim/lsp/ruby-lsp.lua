local amazon = require("utils.amazon")

-- ╭──────────────────────────────────────────────╮
-- │                   Command                    │
-- ╰──────────────────────────────────────────────╯

local cmd = { 'ruby-lsp' }

-- ╭──────────────────────────────────────────────╮
-- │                 Filetypes                    │
-- ╰──────────────────────────────────────────────╯

local filetypes = { 'ruby', 'eruby' }

-- ╭──────────────────────────────────────────────╮
-- │                 Init Options                 │
-- ╰──────────────────────────────────────────────╯

local init_options = {
    enabledFeatures = {
        codeActions = true,
        codeLens = true,
        completion = true,
        definition = true,
        diagnostics = true,
        documentHighlights = true,
        documentLink = true,
        documentSymbols = true,
        foldingRanges = true,
        formatting = false,
        hover = true,
        inlayHint = true,
        onTypeFormatting = true,
        selectionRanges = true,
        semanticHighlighting = true,
        signatureHelp = true,
        typeHierarchy = true,
        workspaceSymbol = true,
    },
    featuresConfiguration = {
        inlayHint = {
            implicitHashValue = true,
            implicitRescue = true,
        },
    },
    indexing = {
        includedPatterns = amazon.get_bemol_farms_for_single_package(),
    },
    experimentalFeaturesEnabled = false,
}

-- ╭──────────────────────────────────────────────╮
-- │                   On Init                    │
-- ╰──────────────────────────────────────────────╯

local on_init = function(_, _)
    amazon.remove_package_build_link_if_exists()
end

-- ╭──────────────────────────────────────────────╮
-- │                   Config                     │
-- ╰──────────────────────────────────────────────╯

return {
    cmd = cmd,
    filetypes = filetypes,
    init_options = init_options,
    on_init = on_init
}
