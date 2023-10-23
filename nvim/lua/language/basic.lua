local lspbuf = vim.lsp.buf
local inspect = vim.inspect
local function generate_on_attach(t)
    local defaultKeymap = {
        ["gD"] = lspbuf.declaration,
        ["gd"] = lspbuf.definition,
        ["K"] = lspbuf.hover,
        ["gi"] = lspbuf.implementation,
        ["<C-k>"] = lspbuf.signature_help,
        ["<space>wa"] = lspbuf.add_workspace_folder,
        ["<space>wr"] = lspbuf.remove_workspace_folder,
        ["<space>wl"] = function()
            print(inspect(lspbuf.list_workspace_folders()))
        end,
        ["<space>D"] = lspbuf.type_definition,
        ["<space>rn"] = lspbuf.rename,
        ["<space>ca"] = lspbuf.code_action,
        ["gr"] = lspbuf.references,
        ["<space>f"] = function()
            lspbuf.format({ async = true })
        end,
    }

    if type(t) == "table" then
        for key, value in pairs(t) do
            defaultKeymap[key] = value
        end
    end

    return function(client, bufnr)
        local keymapset = vim.keymap.set
        local nvim_buf_set_option = vim.api.nvim_buf_set_option

        -- Enable completion triggered by <c-x><c-o>
        nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

        -- Mappings.
        -- See `:help vim.lsp.*` for documentation on any of the below functions
        local bufopts = { noremap = true, silent = true, buffer = bufnr }

        for key, value in pairs(defaultKeymap) do
            keymapset("n", key, value, bufopts)
        end
    end
end

return {
    generate_on_attach = generate_on_attach,
    lsp_flags = {
        debounce_text_changes = 150,
    },
    auto_format = function()
        lspbuf.format({ async = true })
    end,
}
