local lsp_basic = require("language.basic")
local nvim_create_augroup = vim.api.nvim_create_augroup
local nvim_create_autocmd = vim.api.nvim_create_autocmd

local format_sync_grp = nvim_create_augroup("LuaAutoFormat", {})
nvim_create_autocmd("BufWritePre", {
    pattern = "*.lua",
    callback = lsp_basic.auto_format,
    group = format_sync_grp,
})

require("neodev").setup()
require("lspconfig")["lua_ls"].setup({
    on_attach = lsp_basic.generate_on_attach(),
    flags = lsp_basic.lsp_flags,
    capabilities = require("cmp_nvim_lsp").default_capabilities(),
    settings = {
        Lua = {
            completion = {
                callSnippet = "Replace",
            },
        },
    },
})
