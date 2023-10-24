-- Mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
local opts = { noremap = true, silent = true }
vim.keymap.set("n", "<space>e", vim.diagnostic.open_float, opts)
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
vim.keymap.set("n", "<space>q", vim.diagnostic.setloclist, opts)

-- vim.cmd [[autocmd BufWritePre * lua vim.lsp.buf.format({async = true})]]
require("mason").setup()
require("mason-lspconfig").setup({})
require("mason-tool-installer").setup({
    -- a list of all tools you want to ensure are installed upon
    -- start; they should be the names Mason uses for each tool
    ensure_installed = {
        -- you can pin a tool to a particular version
        { "golangci-lint", version = "v1.47.0" },

        "lua-language-server",
        "clangd",
        "gopls",
        "delve",
        "rust-analyzer",

        "black",
        "pyright",
    },

    -- if set to true this will check each tool for updates. If updates
    -- are available the tool will be updated. This setting does not
    -- affect :MasonToolsUpdate or :MasonToolsInstall.
    -- Default: false
    auto_update = false,

    -- automatically install / update on startup. If set to false nothing
    -- will happen on startup. You can use :MasonToolsInstall or
    -- :MasonToolsUpdate to install tools and check for updates.
    -- Default: true
    run_on_start = true,

    -- set a delay (in ms) before the installation starts. This is only
    -- effective if run_on_start is set to true.
    -- e.g.: 5000 = 5 second delay, 10000 = 10 second delay, etc...
    -- Default: 0
    start_delay = 3000, -- 3 second delay

    -- Only attempt to install if 'debounce_hours' number of hours has
    -- elapsed since the last time Neovim was started. This stores a
    -- timestamp in a file named stdpath('data')/mason-tool-installer-debounce.
    -- This is only relevant when you are using 'run_on_start'. It has no
    -- effect when running manually via ':MasonToolsInstall' etc....
    -- Default: nil
    debounce_hours = 5, -- at least 5 hours between attempts to install/update
})

require("mason-null-ls").setup({
    ensure_installed = { "stylua", "jq", "black" },
})

local null_ls = require("null-ls")

null_ls.setup({
    sources = {
        null_ls.builtins.formatting.black,
        null_ls.builtins.formatting.stylua,
        null_ls.builtins.diagnostics.eslint,
        null_ls.builtins.completion.spell,
        null_ls.builtins.formatting.jq,
        null_ls.builtins.diagnostics.luacheck,
    },
})
