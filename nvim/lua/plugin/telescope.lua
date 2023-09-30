local builtin = require('telescope.builtin')

vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})

vim.keymap.set('n', '<leader>ld', builtin.lsp_document_symbols, {})
vim.keymap.set('n', '<leader>li', builtin.lsp_incoming_calls, {})
vim.keymap.set('n', '<leader>lr', builtin.lsp_references, {})


require('telescope').setup {
    defaults = {
        -- Default configuration for telescope goes here:
        -- config_key = value,
        initial_mode = 'normal',
        path_display = {
            shorten = 3,
        },
        grep = {
            ignore_case = true,
        },
        mappings = {
            i = {
                ["<C-h>"] = "which_key"
            }
        }
    },
    pickers = {},
    extensions = {}
}

require('telescope').load_extension('fzf')
require('telescope').load_extension('lazygit')
