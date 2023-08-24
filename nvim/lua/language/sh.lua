local ls = require('luasnip')

local snip = ls.snippet
local text = ls.text_node
local insert = ls.insert_node

local shellsnips = {
    snip({
        trig = "shebang",
        namr = "head line of bash",
        dscr = "head line of bash",
    }, {
        text('#!/bin/bash'),
    }),
    snip({
        trig = "func",
        namr = "function of a snip",
        dscr = "head line of bash",
    }, {
        text('function '), insert(1, 'FuncName '),
        text { '{', '' },
        text { '}' }
    }),
}

ls.add_snippets(nil, {
    sh = shellsnips,
    bash = shellsnips,
    zsh = shellsnips
})
