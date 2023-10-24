local lsp_basic = require("language.basic")
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
    on_attach = lsp_basic.generate_on_attach({
        ["<space>f"] = function()
            require("go.format").gofmt()
            require("go.format").goimport()
        end,
    }),
    capabilities = require("cmp_nvim_lsp").default_capabilities(),

    flags = lsp_basic.lsp_flags,
})

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
