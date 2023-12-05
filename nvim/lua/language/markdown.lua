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
    markdown = {
        snip({
            trig = "date",
            namr = "Date",
            dscr = "Date in the form of YYYY-MM-DD",
        }, {
            func(date, {}),
        }),
        snip({
            trig = "link",
            namr = "markdown_link",
            dscr = "Create markdown link [txt](url)",
        }, {
            text("["),
            insert(1),
            text("]("),
            func(function(_, snip)
                return snip.env.TM_SELECTED_TEXT[1] or {}
            end, {}),
            text(")"),
            insert(0),
        }),
        snip({
            trig = "image",
            namr = "markdown_image",
            dscr = "Create markdown image ![txt](url)",
        }, {
            text("!["),
            insert(1),
            text("]("),
            text("/log/"),
            func(function()
                return { os.date("%Y/%m/%d") }
            end, {}),
            text("/images/"),
            text(")"),
            insert(0),
        }),
        snip(
            {
                trig = "log",
                namr = "log",
                dscr = "generate a log info with end time",
            },
            fmt(
                [[
                  # {}
                  ## task
                  ## content
                ]],
                {
                    func(date, {}),
                }
            )
        ),
        snip(
            {
                trig = "mermaid",
            },
            fmt(
                [[
                ```mermaid
                {}
                ```
                ]],
                {
                    insert(0),
                }
            )
        ),
        -- mermaid snips
        snip(
            {
                trig = "relaIsa",
            },
            fmt(
                [[
                {} <|-- {}
                ]],
                {
                    insert(1, "father"),
                    insert(0, "son"),
                }
            )
        ),
        snip(
            {
                trig = "relaReali",
            },
            fmt(
                [[
                {} <|.. {}
                ]],
                {
                    insert(1, "father"),
                    insert(0, "son"),
                }
            )
        ),
        snip(
            {
                trig = "relaHasa",
            },
            fmt(
                [[
                {} <|.. {}
                ]],
                {
                    insert(1, "father"),
                    insert(0, "son"),
                }
            )
        ),
    },
})
