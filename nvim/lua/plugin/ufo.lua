local o = vim.o
local keymapset = vim.keymap.set

o.foldcolumn = "1" -- '0' is not bad
o.foldlevel = 99   -- Using ufo provider need a large value, feel free to decrease the value
o.foldlevelstart = 99
o.foldenable = true

-- Using ufo provider need remap `zR` and `zM`. If Neovim is 0.6.1, remap yourself
keymapset("n", "zR", require("ufo").openAllFolds)
keymapset("n", "zM", require("ufo").closeAllFolds)

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.foldingRange = {
    dynamicRegistration = false,
    lineFoldingOnly = true,
}
local language_servers = require("lspconfig").util.available_servers() -- or list servers manually like {'gopls', 'clangd'}
for _, ls in ipairs(language_servers) do
    require("lspconfig")[ls].setup({
        capabilities = capabilities,
        -- you can add other fields for setting up lsp server in this table
    })
end
require("ufo").setup()
