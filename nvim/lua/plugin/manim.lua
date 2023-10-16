require('manim').setup()
local keyset = vim.keymap.set
keyset('n', '<Leader>mp', ':ManimPreview<CR>')
