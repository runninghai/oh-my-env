require("chatgpt").setup()

local keyset = vim.keymap.set

keyset('n', '<Leader>ai', ':ChatGPT<CR>')
