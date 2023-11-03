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
local lspconfig = require("lspconfig")
lspconfig.lua_ls.setup({
	on_attach = lsp_basic.generate_on_attach(),
	flags = lsp_basic.lsp_flags,
	capabilities = require("cmp_nvim_lsp").default_capabilities(),
	Lua = {
		runtime = {
			-- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
			version = "LuaJIT",
		},
		diagnostics = {
			-- Get the language server to recognize the `vim` global
			globals = { "vim" },
		},
		workspace = {
			-- Make the server aware of Neovim runtime files,
			-- see also https://github.com/LuaLS/lua-language-server/wiki/Libraries#link-to-workspace .
			-- Lua-dev.nvim also has similar settings for lua ls, https://github.com/folke/neodev.nvim/blob/main/lua/neodev/luals.lua .
			maxPreload = 2000,
			preloadFileSize = 50000,
		},
	},
})
