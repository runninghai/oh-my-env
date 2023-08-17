require("symbols-outline").setup()

local set = vim.keymap.set

set("n", "<leader>s", "<cmd>SymbolsOutline<cr>",
    { silent = true, noremap = true }
)
