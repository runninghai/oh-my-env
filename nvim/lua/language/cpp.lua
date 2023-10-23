local util = require("lspconfig.util")

local root_files = {
    ".clangd",
    ".clang-tidy",
    ".clang-format",
    "compile_commands.json",
    "compile_flags.txt",
    "build.sh",  -- buildProject
    "configure.ac", -- AutoTools
    "run",
    "compile",
}

local lsp_base = require("language.basic")

local settings = {
    on_attach = lsp_base.on_attach,
    capabilities = require("cmp_nvim_lsp").default_capabilities(),
    flags = lsp_base.lsp_flags,
    cmd = {
        "clangd",
        "--all-scopes-completion",
        "--background-index",
        "--clang-tidy",
        "--compile_args_from=filesystem", -- lsp-> does not come from compie_commands.json
        "--completion-parse=always",
        "--completion-style=bundled",
        "--debug-origin",
        "--enable-config", -- clangd 11+ supports reading from .clangd configuration file
        "--fallback-style=Qt",
        "--function-arg-placeholders",
        "--header-insertion=iwyu",
        "--pch-storage=memory", -- could also be disk
        "-j=4",           -- number of workers
        -- "--resource-dir="
        "--log=error",
        --[[ "--query-driver=/usr/bin/g++", ]]
    },
    filetypes = { "c", "cpp", "objc", "objcpp" },
    root_dir = function(fname)
        return util.root_pattern(unpack(root_files))(fname) or util.find_git_ancestor(fname)
    end,
    single_file_support = true,
    init_options = {
        compilationDatabasePath = "build",
    },
    commands = {},
}

require("lspconfig")["clangd"].setup(settings)
