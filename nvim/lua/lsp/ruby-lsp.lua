local amazon = require("utils.amazon")

return {
    cmd = { "ruby-lsp" },
    filetypes = { "ruby", "eruby" },
    root_markers = { "packageInfo" }, -- ruby-lsp does not support multi-root ws
    init_options = {
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
            includedPatterns = amazon.get_bemol_farms_if_exists(),
        },
        experimentalFeaturesEnabled = false,
    },
}
