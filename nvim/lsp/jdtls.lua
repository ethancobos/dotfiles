-- to cache some of the data calculated below
local cache_vars = {}
local jdtls_version = "1.46.1"

-- Get all of the paths of various things needed for jdtls
local get_jdtls_paths = function()
    if cache_vars.paths then
        return cache_vars.paths
    end

    local path = {}
    local jdtls_install = "/home/linuxbrew/.linuxbrew/Cellar/jdtls/" .. jdtls_version

    path.data_dir = vim.fn.stdpath("cache") .. "/nvim-jdtls"
    path.jdtls_bin = jdtls_install .. "/bin/jdtls"
    path.java_agent = "/home/ecobos/.local/state/lombok/lombok.jar"
    path.launcher_jar = vim.fn.glob(jdtls_install .. "/libexec/plugins/org.eclipse.equinox.launcher_*.jar")
    path.platform_config = jdtls_install .. "/libexec/config_linux"
    path.runtimes = {}
    path.bundles = {}

    cache_vars.paths = path

    return path
end

local path = get_jdtls_paths()
local project_path = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h")
local project_path_hash = string.gsub(project_path, "[/\\:+-]", "_")
local data_dir = path.data_dir .. project_path_hash

local cmd = {
    path.jdtls_bin,
    -- could also be '/usr/lib/jvm/java-21-amazon-corretto/bin/java',

    "-XX:+UseParallelGC",                  -- Better performance for multi-core systems
    "-XX:GCTimeRatio=4",                   -- Spend less time on GC
    "-XX:AdaptiveSizePolicyWeight=90",     -- Optimize for throughput
    "-Dsun.zip.disableMemoryMapping=true", -- Reduce memory pressure
    "-Xms1g",                              -- Initial heap size
    "-Xmx8g",                              -- Maximum heap size
    "-XX:+UseStringDeduplication",         -- Reduce memory usage for string storage
    "-XX:+OptimizeStringConcat",           -- Optimize string concatenation
    "-Declipse.application=org.eclipse.jdt.ls.core.id1",
    "-Dosgi.bundles.defaultStartLevel=4",
    "-Declipse.product=org.eclipse.jdt.ls.core.product",
    "-Dlog.protocol=true",
    "-Dlog.level=ALL",
    "-javaagent:" .. path.java_agent,
    "-Xms1g",
    "--add-modules=ALL-SYSTEM",
    "--add-opens",
    "java.base/java.util=ALL-UNNAMED",
    "--add-opens",
    "java.base/java.lang=ALL-UNNAMED",

    "-jar",
    path.launcher_jar,

    "-configuration",
    path.platform_config,

    "-data",
    data_dir,
}

local lsp_settings = {
    java = {
        eclipse = {
            downloadSources = true,
        },
        configuration = {
            updateBuildConfiguration = "automatic",
            runtimes = path.runtimes,
        },
        maven = {
            downloadSources = true,
        },
        implementationsCodeLens = {
            enabled = true,
        },
        referencesCodeLens = {
            enabled = true,
        },
        references = {
            includeDecompiledSources = true,
            includeAccessors = true,
            includeDeclaration = true,
        },
        quickfix = {
            enabled = true,
        },
        inlayHints = {
            parameterNames = {
                enabled = "all",
            },
        },
        format = {
            enabled = false,
            settings = {
                profile = 'DdbLogService',
                url = '/home/ecobos/work-dotfiles/LogProducer/DdbLogService.xml'
            }
        },
    },
    signatureHelp = {
        enabled = true,
    },
    completion = {
        favoriteStaticMembers = {
            "org.hamcrest.MatcherAssert.assertThat",
            "org.hamcrest.Matchers.*",
            "org.hamcrest.CoreMatchers.*",
            "org.junit.jupiter.api.Assertions.*",
            "java.util.Objects.requireNonNull",
            "java.util.Objects.requireNonNullElse",
            "org.mockito.Mockito.*",
        },
        filteredTypes = {
            "com.sun.*",
            "io.micrometer.shaded.*",
            "java.awt.*",
            "jdk.*",
            "sun.*",
        },
    },
    contentProvider = {
        preferred = "fernflower",
    },
    sources = {
        organizeImports = {
            starThreshold = 9999,
            staticStarThreshold = 9999,
        },
    },
    codeGeneration = {
        toString = {
            template = "${object.className}{${member.name()}=${member.value}, ${otherMembers}}",
        },
        useBlocks = true,
    },
}

return {
    cmd = cmd,
    filetypes = { 'java' },
    settings = lsp_settings,
    root_markers = { "packageInfo" },
    flags = {
        allow_incremental_sync = true,
    },
    init_options = {
        bundles = path.bundles,
    },
}
