local keyset = vim.keymap.set

keyset('n', '<Leader>rr', ':source $MYVIMRC<CR>')

keyset('n', '<Leader>wq', ':wq<CR>')
keyset('n', '<Leader>w', ':w<CR>')
keyset('n', '<Leader>q', ':q<CR>')
keyset('n', '<Leader>qq', ':q!<CR>')

keyset('n', '<Up>', '<nop>')
keyset('n', '<Down>', '<nop>')
keyset('n', '<Left>', '<nop>')
keyset('n', '<Right>', '<nop>')
keyset('i', '<Up>', '<nop>')
keyset('i', '<Down>', '<nop>')
keyset('i', '<Left>', '<nop>')
keyset('i', '<Right>', '<nop>')
