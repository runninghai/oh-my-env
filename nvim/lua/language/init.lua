local fn = vim.fn
local cmd = vim.cmd

local scan = require("plenary.scandir")
local languages = scan.scan_dir(string.format("%s/lua/language", fn.stdpath("config")), { hidden = true, depth = 2 })
local language_init = string.format("%s/lua/language/%s", fn.stdpath("config"), "init.lua")
for _, file in ipairs(languages) do
    if file ~= language_init then
        cmd("source " .. file)
    end
end

-- load snippet
local snippets = string.format("%s/Snippet", fn.stdpath("config"))
require("luasnip.loaders.from_vscode").lazy_load({ paths = { snippets } })
