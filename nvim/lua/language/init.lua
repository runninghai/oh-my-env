local fn = vim.fn
local cmd = vim.cmd

local supported_languages = { "cpp", "go", "json", "lua", "markdown", "python", "sh", "yaml" }

for i, v in ipairs(supported_languages) do
    require("language." .. v)
end

-- load snippet
local snippets = string.format("%s/Snippet", fn.stdpath("config"))
require("luasnip.loaders.from_vscode").lazy_load({ paths = { snippets } })
