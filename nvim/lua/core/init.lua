local fn = vim.fn
local cmd = vim.cmd

local scan = require'plenary.scandir'
local core_init = string.format("%s/lua/core/%s", fn.stdpath("config"), "init.lua")
local cores = scan.scan_dir(string.format("%s/lua/core", fn.stdpath("config")), { hidden = true, depth = 2 })
for _, file in ipairs(cores) do
    if file ~= core_init then
        cmd("source " .. file)
    end
end
