local lsp_basic = require("language.basic")
local nvim_create_augroup = vim.api.nvim_create_augroup
local nvim_create_autocmd = vim.api.nvim_create_autocmd

local format_sync_grp = nvim_create_augroup("PythonFormat", {})
nvim_create_autocmd("BufWritePre", {
    pattern = "*.py",
    callback = lsp_basic.auto_format,
    group = format_sync_grp,
})

local lsp_flags = {
    -- This is the default in Nvim 0.7+
    debounce_text_changes = 150,
}

require("lspconfig")["pyright"].setup({
    on_attach = lsp_basic.generate_on_attach(),
    capabilities = require("cmp_nvim_lsp").default_capabilities(),

    flags = lsp_basic.lsp_flags,
    single_file_support = true,
    settings = {
        pyright = {
            disableLanguageServices = false,
            disableOrganizeImports = false,
        },
        python = {
            analysis = {
                autoImportCompletions = true,
                autoSearchPaths = true,
                diagnosticMode = "workspace", -- openFilesOnly, workspace
                typeCheckingMode = "off", -- off, basic, strict
                useLibraryCodeForTypes = true,
            },
        },
    },
})
