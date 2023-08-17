local fn = vim.fn
local cmd = vim.cmd


require('lazy').setup({
    'nvim-lua/plenary.nvim',
    {
        'windwp/nvim-autopairs',
        event = 'InsertEnter',
    },
    {
        'folke/neodev.nvim',
        version = 'v2.5.2'
    },

    {
        'ray-x/guihua.lua',
        build = 'cd lua/fzy && make'
    },
    {
        'nvim-treesitter/nvim-treesitter',
        version = 'v0.9.1'
    },
    'rking/ag.vim',
    {
        'nvim-tree/nvim-web-devicons',
        version = 'nerd-v2-compat'
    },
    'Mofiqul/dracula.nvim',
    'wakatime/vim-wakatime',
    {
        'folke/todo-comments.nvim',
        dependencies = { 'nvim-lua/plenary.nvim' },
        version = 'v1.1.0'
    },
    'tpope/vim-fugitive',
    {
        'lewis6991/gitsigns.nvim',
        version = 'v0.6'
    },

    'neovim/nvim-lspconfig',
    {
        'williamboman/mason.nvim',
        version = 'v1.6.2',
    },
    {
        'williamboman/mason-lspconfig.nvim',
        version = 'v1.12.0'
    },

    {
        'renerocksai/telekasten.nvim',
        dependencies = { 'nvim-telescope/telescope.nvim' }
    },
    'renerocksai/calendar-vim',

    'hrsh7th/cmp-nvim-lsp',
    'hrsh7th/cmp-buffer',
    'hrsh7th/cmp-path',
    'hrsh7th/cmp-cmdline',
    'hrsh7th/nvim-cmp',

    {
        'L3MON4D3/LuaSnip',
        -- follow latest release.
        version = '2.*', -- Replace <CurrentMajor> by the latest released major (first number of latest release)
        -- install jsregexp (optional!).
        build = 'make install_jsregexp'
    },
    'saadparwaiz1/cmp_luasnip',

    'simrat39/symbols-outline.nvim',


    {
        'folke/trouble.nvim',
        dependencies = { 'nvim-tree/nvim-web-devicons' },
    },

    {
        'folke/which-key.nvim',
        event = 'VeryLazy',
        init = function()
            vim.o.timeout = true
            vim.o.timeoutlen = 300
        end,
        version = 'v1.5.1'
    },

    {
        'mfussenegger/nvim-dap',
        version = '0.6.0'
    },
    {
        'rcarriga/nvim-dap-ui',
        version = 'v3.8.4'
    },
    'theHamsta/nvim-dap-virtual-text',
    {
        'ray-x/go.nvim',
    },

    {
        'iamcco/markdown-preview.nvim',
        build = 'cd app && npm install',
        init = function() vim.g.mkdp_filetypes = { 'markdown' } end,
        ft = { 'markdown' }
    },

    {
        'nvim-lualine/lualine.nvim',
        dependencies = { 'nvim-tree/nvim-web-devicons', opt = true }
    },

    {
        'nvim-tree/nvim-tree.lua',
        dependencies = {
            'nvim-tree/nvim-web-devicons',
        },
        version = 'nightly'
    },

    {
        'kylechui/nvim-surround',
        version = 'v2.1.1',
    },

    {
        'nvim-telescope/telescope.nvim',
        version = '0.1.2',
        dependencies = { { 'nvim-lua/plenary.nvim' } }
    },

    'nvim-lua/popup.nvim',
    'nvim-telescope/telescope-media-files.nvim',

    {
      'folke/flash.nvim',
      event = 'VeryLazy',
      opts = {},
      version = '1.17.3',
      keys = {
        { 's', mode = { 'n', 'x', 'o' }, function() require('flash').jump() end, desc = 'Flash' },
        { 'S', mode = { 'n', 'o', 'x' }, function() require('flash').treesitter() end, desc = 'Flash Treesitter' },
        { 'r', mode = 'o', function() require('flash').remote() end, desc = 'Remote Flash' },
        { 'R', mode = { 'o', 'x' }, function() require('flash').treesitter_search() end, desc = 'Treesitter Search' },
        { '<c-s>', mode = { 'c' }, function() require('flash').toggle() end, desc = 'Toggle Flash Search' },
      },
    },
    { 
      'lukas-reineke/indent-blankline.nvim',
      version = 'v2.20.7',
      event = 'VeryLazy',
    },

    {
        'kevinhwang91/promise-async',
        version = 'v1.0.0'
    },
    {
        'kevinhwang91/nvim-ufo',
        dependencies = {'kevinhwang91/promise-async'},
        version = 'v1.3.0'
    },
    {
      'glepnir/dashboard-nvim',
      event = 'VimEnter',
      dependencies = { {'nvim-tree/nvim-web-devicons'}}
    }
}
)

local scan = require 'plenary.scandir'
local plugins = scan.scan_dir(string.format('%s/lua/plugin', fn.stdpath('config')), { hidden = true, depth = 2 })
local plugin_init = string.format('%s/lua/plugin/%s', fn.stdpath('config'), 'init.lua')
for _, file in ipairs(plugins) do
    if file ~= plugin_init then
        cmd('source ' .. file)
    end
end
