local ls = require('luasnip')

local snip = ls.snippet
local fmt = require("luasnip.extras.fmt").fmt
local insert = ls.insert_node
local text = ls.text_node

ls.add_snippets(nil, {
    json = {
        snip(
            {
                trig = "task",
                namr = "task",
                dscr = "generate task info",
            },
            {
                text { "{", "    \"Name\": " }, insert(1, "\"task name\""), text(","),
                text { "", "    \"BoundaryName\": " }, insert(2, "\"task boundary name\""), text(","),
                text { "", "    \"Description\": " }, insert(3, "\"task description\""), text(","),
                text { "", "    \"TimeBudget\": " }, insert(3, "\"30m\""), text(","),
                text { "", "    \"Childs\": [", "    ]" },
                text { "", "}" }
            }
        ),
    }
})
