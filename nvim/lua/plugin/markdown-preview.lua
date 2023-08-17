local keyset = vim.keymap.set
keyset('n', '<Leader>mdp', ':MarkdownPreview<CR>')
keyset('n', '<Leader>mds', ':MarkdownPreview<CR>')


local g = vim.g
g.mkdp_port='9090'
