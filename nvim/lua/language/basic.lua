local lspbuf = vim.lsp.buf
local function on_attach(client, bufnr)
    local keymapset = vim.keymap.set
    local nvim_buf_set_option = vim.api.nvim_buf_set_option
    local inspect = vim.inspect

    -- Enable completion triggered by <c-x><c-o>
    nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

    -- Mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local bufopts = { noremap = true, silent = true, buffer = bufnr }
    keymapset("n", "gD", lspbuf.declaration, bufopts)
    keymapset("n", "gd", lspbuf.definition, bufopts)
    keymapset("n", "K", lspbuf.hover, bufopts)
    keymapset("n", "gi", lspbuf.implementation, bufopts)
    keymapset("n", "<C-k>", lspbuf.signature_help, bufopts)
    keymapset("n", "<space>wa", lspbuf.add_workspace_folder, bufopts)
    keymapset("n", "<space>wr", lspbuf.remove_workspace_folder, bufopts)
    keymapset("n", "<space>wl", function()
        print(inspect(lspbuf.list_workspace_folders()))
    end, bufopts)
    keymapset("n", "<space>D", lspbuf.type_definition, bufopts)
    keymapset("n", "<space>rn", lspbuf.rename, bufopts)
    keymapset("n", "<space>ca", lspbuf.code_action, bufopts)
    keymapset("n", "gr", lspbuf.references, bufopts)
    keymapset("n", "<space>f", function()
        lspbuf.format({ async = true })
    end, bufopts)
end

return {
    on_attach = on_attach,
    lsp_flags = {
        debounce_text_changes = 150,
    },
    auto_format = function()
        lspbuf.format({ async = true })
    end,
}
