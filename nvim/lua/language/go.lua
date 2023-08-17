-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
    -- Enable completion triggered by <c-x><c-o>
    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

    -- Mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local bufopts = { noremap = true, silent = true, buffer = bufnr }
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
    vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, bufopts)
    vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
    vim.keymap.set('n', '<space>wl', function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, bufopts)
    vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, bufopts)
    vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
    vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
    vim.keymap.set('n', '<space>f', function() vim.lsp.buf.format { async = true } end, bufopts)
end

local lsp_flags = {
    -- This is the default in Nvim 0.7+
    debounce_text_changes = 150,
}

require('lspconfig')['gopls'].setup {
    on_attach = on_attach,
    capabilities = require('cmp_nvim_lsp').default_capabilities(),

    flags = lsp_flags,
}

-- snips --

local ls = require('luasnip')

local snip = ls.snippet
local func = ls.function_node
local text = ls.text_node
local fmt = require("luasnip.extras.fmt").fmt
local insert = ls.insert_node

local date = function() return { os.date('%Y-%m-%d %H:%M:%S') } end

ls.add_snippets(nil, {
    go = {
        snip({
                trig = "func",
                namr = "func",
                dscr = "function",
            },
            {
                text { 'func ' }, insert(1, "Name"), text { '() {', '' }, text { '}' }
        }),
        snip({
                trig = "struct",
                namr = "struct",
                dscr = "struct",
            },
            {
                text { 'type ' }, insert(1, "Name"), text { ' struct {', '' }, text { '}' }
        }),
        snip({
                trig = "interface",
                namr = "interface",
                dscr = "interface",
            },
            {
                text { 'type ' }, insert(1, "Name"), text { ' interface {', '' }, text { '}' }
        }),
        snip({
                trig = "galoistest",
                namr = "galoistest",
                dscr = "galoistest",
            },
            fmt(
                [[
                import (
                    "context"
                    "testing"

                    "github.com/golang/mock/gomock"
                    "github.com/onsi/gomega"
                )

                func Test<>(t *testing.T) {
                    mockCtrl := gomock.NewController(t)
                    mockRepo := repomock.NewMockCompletedInstanceRepository(mockCtrl)

                    testCases := []struct {
                        name       string
                    }{
                    }
                    for _, tt := range testCases {
                        t.Run(tt.name, func(t *testing.T) {
                            if tt.mockFunc != nil {
                                tt.mockFunc()
                            }
                            if err := <>(context.Background(), tt.msg); (err != nil) != tt.wantErr {
                                t.Errorf("<>() error = %v, wantErr %v", err, tt.wantErr)
                            }
                        })
                    }
                }
                ]],
                {
                    insert(2, "behave"),
                    insert(1, "func"),
                    insert(0, "func"),
                },
                {
                    delimiters = "<>",
                }
            )
        ),
    }
})
