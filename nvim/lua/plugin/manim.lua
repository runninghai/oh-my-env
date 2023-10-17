require('manim').setup()
local keyset = vim.keymap.set
keyset('n', '<space>mp', ':ManimPreview<CR>')
