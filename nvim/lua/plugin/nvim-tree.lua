local keyset = vim.keymap.set
require("nvim-tree").setup()

keyset('n', '<Leader>e', ':NvimTreeToggle<CR>')
