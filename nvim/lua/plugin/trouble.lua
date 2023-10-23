require("trouble").setup()
local set = vim.keymap.set

-- Lua
set("n", "<leader>xx", "<cmd>TroubleToggle<cr>", { silent = true, noremap = true })
