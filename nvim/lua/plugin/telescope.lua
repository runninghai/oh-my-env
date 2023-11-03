local builtin = require("telescope.builtin")

vim.keymap.set("n", "<leader>ff", builtin.find_files, {})
vim.keymap.set("n", "<leader>fg", builtin.live_grep, {})
vim.keymap.set("n", "<leader>fo", builtin.oldfiles, {})
vim.keymap.set("n", "<leader>fb", builtin.buffers, {})

vim.keymap.set("n", "<leader>ld", builtin.lsp_document_symbols, {})
vim.keymap.set("n", "<leader>li", builtin.lsp_incoming_calls, {})
vim.keymap.set("n", "<leader>lr", builtin.lsp_references, {})

require("telescope").setup {
  defaults = {
    initial_mode = "normal",
    -- Format path as "file.txt (path\to\file\)"
    path_display = function(opts, path)
      local tail = require("telescope.utils").path_tail(path)
      return string.format("%s (%s)", tail, path), { { { 1, #tail }, "Constant" } }
    end,
    grep = {
      ignore_case = true,
    },
    mappings = {
      i = {
        ["<C-h>"] = "which_key",
      },
    },
  },
  pickers = {
    live_grep = {
      initial_mode = "insert",
    },
    find_files = {
      initial_mode = "insert",
    },
  },
  extensions = {},
}

require("telescope").load_extension("fzf")
