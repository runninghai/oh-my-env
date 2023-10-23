-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
    local keymapset = vim.keymap.set
    local lspbuf = vim.lsp.buf

    -- Enable completion triggered by <c-x><c-o>
    vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

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
        print(vim.inspect(lspbuf.list_workspace_folders()))
    end, bufopts)
    keymapset("n", "<space>D", lspbuf.type_definition, bufopts)
    keymapset("n", "<space>rn", lspbuf.rename, bufopts)
    keymapset("n", "<space>ca", lspbuf.code_action, bufopts)
    keymapset("n", "gr", lspbuf.references, bufopts)
    keymapset("n", "<space>f", function()
        require("go.format").gofmt()
        require("go.format").goimport()
    end, bufopts)
    keymapset("n", "ut", ":GoTestFunc<CR>", bufopts)
    keymapset("n", "cf", function()
        require("go.term").close()
    end, bufopts)
end

local lsp_flags = {
    -- This is the default in Nvim 0.7+
    debounce_text_changes = 150,
}

-- Run gofmt + goimport on save

local format_sync_grp = vim.api.nvim_create_augroup("GoImport", {})
vim.api.nvim_create_autocmd("BufWritePre", {
    pattern = "*.go",
    callback = function()
        require("go.format").gofmt()
        require("go.format").goimport()
    end,
    group = format_sync_grp,
})

require("lspconfig")["gopls"].setup({
    on_attach = on_attach,
    capabilities = require("cmp_nvim_lsp").default_capabilities(),

    flags = lsp_flags,
})
--keymaps--

-- snips --

local ls = require("luasnip")

local snip = ls.snippet
local func = ls.function_node
local text = ls.text_node
local fmt = require("luasnip.extras.fmt").fmt
local insert = ls.insert_node

local date = function()
    return { os.date("%Y-%m-%d %H:%M:%S") }
end

ls.add_snippets(nil, {
    go = {
        snip({
            trig = "func",
            namr = "func",
            dscr = "function",
        }, {
            text({ "func " }),
            insert(1, "Name"),
            text({ "() {", "" }),
            text({ "}" }),
        }),
        snip({
            trig = "struct",
            namr = "struct",
            dscr = "struct",
        }, {
            text({ "type " }),
            insert(1, "Name"),
            text({ " struct {", "" }),
            text({ "}" }),
        }),
        snip({
            trig = "interface",
            namr = "interface",
            dscr = "interface",
        }, {
            text({ "type " }),
            insert(1, "Name"),
            text({ " interface {", "" }),
            text({ "}" }),
        }),
        snip(
            {
                trig = "mkm",
            },
            fmt(
                [[
				p := gomonkey.ApplyMethod(reflect.TypeOf(&<>{}), "<>",
					func() () {
					})

            ]],
                {
                    insert(1, "type"),
                    insert(0, "func"),
                },
                {
                    delimiters = "<>",
                }
            )
        ),
        snip(
            {
                trig = "mkf",
            },
            fmt(
                [[
				p := gomonkey.ApplyFunc(<>,
					func() () {
					})

            ]],
                {
                    insert(0, "func"),
                },
                {
                    delimiters = "<>",
                }
            )
        ),
        snip(
            {
                trig = "err",
            },
            fmt(
                [[
                if err != nil {

                }
            ]],
                {},
                {
                    delimiters = "<>",
                }
            )
        ),
        snip(
            {
                trig = "patchs",
            },
            fmt(
                [[
            var patches []*gomonkey.Patches
			if tt.mocks != nil {
				patches = tt.mocks()
			}
			defer func() {
				for _, p := range patches {
					p.Reset()
				}
			}()
            ]],
                {},
                {
                    delimiters = "<>",
                }
            )
        ),
    },
})
