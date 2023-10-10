local util = require 'lspconfig.util'
local on_attach = function(client, bufnr)
    -- Enable completion triggered by <c-x><c-o>
    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

    -- Mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local bufopts = { noremap = true, silent = true, buffer = bufnr }
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
    vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, bufopts)
    vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
    vim.keymap.set('n', '<space>wl', function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, bufopts)
    vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, bufopts)
    vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
    vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
    vim.keymap.set('n', '<space>f', function() vim.lsp.buf.format { async = true } end, bufopts)
end

local lsp_flags = {
    -- This is the default in Nvim 0.7+
    debounce_text_changes = 150,
}

local root_files = {
    '.clangd',
    '.clang-tidy',
    '.clang-format',
    'compile_commands.json',
    'compile_flags.txt',
    'build.sh',     -- buildProject
    'configure.ac', -- AutoTools
    'run',
    'compile',
}

local settings = {
    on_attach = on_attach,
    capabilities = require('cmp_nvim_lsp').default_capabilities(),
    flags = lsp_flags,
    cmd = { "clangd",
        "--all-scopes-completion",
        "--background-index",
        "--clang-tidy",
        "--compile_args_from=filesystem", -- lsp-> does not come from compie_commands.json
        "--completion-parse=always",
        "--completion-style=bundled",
        "--debug-origin",
        "--enable-config", -- clangd 11+ supports reading from .clangd configuration file
        "--fallback-style=Qt",
        "--function-arg-placeholders",
        "--header-insertion=iwyu",
        "--pch-storage=memory", -- could also be disk
        "-j=4",                 -- number of workers
        -- "--resource-dir="
        "--log=error",
        --[[ "--query-driver=/usr/bin/g++", ]]
    },
    filetypes = { "c", "cpp", "objc", "objcpp" },
    root_dir = function(fname)
        return util.root_pattern(unpack(root_files))(fname) or util.find_git_ancestor(fname)
    end,
    single_file_support = true,
    init_options = {
        compilationDatabasePath = "build",
    },
    commands = {

    },
}

require('lspconfig')['clangd'].setup(settings)
