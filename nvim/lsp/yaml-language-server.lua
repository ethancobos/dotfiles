return {
    cmd = { 'yaml-language-server', '--stdio' },
    filetypes = { 'yaml', 'yml', },
    settings = {
        yaml = {
            customTags = {
                "!call mapping",
                "!eval scalar",
                "!set_override mapping",
                "!merge sequence"
            },
            yamlVersion = 1.1
        },
        redhat = { telemetry = { enabled = false } },
    },
}
