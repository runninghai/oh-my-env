vim.opt.termguicolors = true

vim.opt.list = true
vim.opt.listchars:append "space:⋅"
vim.opt.listchars:append "eol:↴"

require("indent_blankline").setup {
    space_char_blankline = " ",
    show_current_context = true,
    show_current_context_start = true,
    filetype_exclude = {
        "", -- for all buffers without a file type
        "dashboard",
        "dotooagenda",
        "flutterToolsOutline",
        "fugitive",
        "git",
        "gitcommit",
        "help",
        "log",
        "markdown",
        "NvimTree",
        "peekaboo",
        "startify",
        "TelescopePrompt",
        "todoist",
        "txt",
        "undotree",
        "vimwiki",
        "vista",
    },
}
