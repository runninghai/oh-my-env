local fn = vim.fn
local cmd = vim.cmd

local spec = {
    "nvim-lua/plenary.nvim",
    {
        "windwp/nvim-autopairs",
        event = "InsertEnter",
    },
    {
        "folke/neodev.nvim",
        version = "v2.5.2",
    },

    {
        "ray-x/guihua.lua",
        build = "cd lua/fzy && make",
    },
    {
        "nvim-treesitter/nvim-treesitter",
        version = "v0.9.1",
    },
    "rking/ag.vim",
    {
        "nvim-tree/nvim-web-devicons",
        version = "nerd-v2-compat",
    },
    --'Mofiqul/dracula.nvim',
    { "ellisonleao/gruvbox.nvim",                 priority = 1000 },
    "wakatime/vim-wakatime",
    {
        "folke/todo-comments.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
        version = "v1.1.0",
    },
    -- 'tpope/vim-fugitive',
    {
        "lewis6991/gitsigns.nvim",
        version = "v0.6",
    },
    {
        "kdheepak/lazygit.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
        },
    },

    "neovim/nvim-lspconfig",
    {
        "williamboman/mason.nvim",
        version = "v1.6.2",
    },
    {
        "williamboman/mason-lspconfig.nvim",
        version = "v1.12.0",
    },
    "WhoIsSethDaniel/mason-tool-installer.nvim",

    "nvimtools/none-ls.nvim",
    {
        "jay-babu/mason-null-ls.nvim",
        event = { "BufReadPre", "BufNewFile" },
        dependencies = {
            "williamboman/mason.nvim",
            "nvimtools/none-ls.nvim",
        },
    },

    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
    "hrsh7th/cmp-cmdline",
    "hrsh7th/nvim-cmp",
    "uga-rosa/cmp-dictionary",

    {
        "L3MON4D3/LuaSnip",
        -- follow latest release.
        version = "2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
        -- install jsregexp (optional!).
        build = "make install_jsregexp",
    },
    "saadparwaiz1/cmp_luasnip",

    "simrat39/symbols-outline.nvim",

    {
        "folke/trouble.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
    },

    {
        "folke/which-key.nvim",
        event = "VeryLazy",
        init = function()
            vim.o.timeout = true
            vim.o.timeoutlen = 300
        end,
        version = "v1.5.1",
    },

    {
        "mfussenegger/nvim-dap",
        version = "0.6.0",
    },
    {
        "rcarriga/nvim-dap-ui",
        version = "v3.9.1",
    },
    "theHamsta/nvim-dap-virtual-text",

    {
        "runninghai/go.nvim",
        dependencies = { -- optional packages
            "ray-x/guihua.lua",
            "neovim/nvim-lspconfig",
            "nvim-treesitter/nvim-treesitter",
        },
        event = { "CmdlineEnter" },
        ft = { "go", "gomod" },
    },

    {
        "iamcco/markdown-preview.nvim",
        build = "cd app && npm install",
        init = function()
            vim.g.mkdp_filetypes = { "markdown" }
        end,
        ft = { "markdown" },
    },

    {
        "nvim-lualine/lualine.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons", opt = true },
    },

    {
        "nvim-tree/nvim-tree.lua",
        dependencies = {
            "nvim-tree/nvim-web-devicons",
        },
        version = "nightly",
    },

    {
        "kylechui/nvim-surround",
        version = "v2.1.1",
    },

    {
        "nvim-telescope/telescope.nvim",
        version = "0.1.2",
        dependencies = { { "nvim-lua/plenary.nvim" } },
    },
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },

    {
        "folke/flash.nvim",
        event = "VeryLazy",
        opts = {
            char = { enabled = false },
        },
        version = "1.17.3",
        keys = {
            {
                "s",
                mode = { "n", "x", "o" },
                function()
                    require("flash").jump()
                end,
                desc = "Flash",
            },
            {
                "S",
                mode = { "n", "o", "x" },
                function()
                    require("flash").treesitter()
                end,
                desc = "Flash Treesitter",
            },
            {
                "R",
                mode = { "o", "x" },
                function()
                    require("flash").treesitter_search()
                end,
                desc = "Treesitter Search",
            },
            {
                "<c-s>",
                mode = { "c" },
                function()
                    require("flash").toggle()
                end,
                desc = "Toggle Flash Search",
            },
        },
    },
    {
        "lukas-reineke/indent-blankline.nvim",
        version = "v2.20.7",
        event = "VeryLazy",
    },

    {
        "kevinhwang91/promise-async",
        version = "v1.0.0",
    },
    {
        "kevinhwang91/nvim-ufo",
        dependencies = { "kevinhwang91/promise-async" },
        version = "v1.3.0",
    },
    {
        "glepnir/dashboard-nvim",
        event = "VimEnter",
        dependencies = { { "nvim-tree/nvim-web-devicons" } },
    },
    {
        "dstein64/vim-startuptime",
        version = "v4.4.0",
    },

    {
        "MunifTanjim/nui.nvim",
        version = "v0.2.0",
    },
    {
        "jackMort/ChatGPT.nvim",
        event = "VeryLazy",
        config = function()
            require("chatgpt").setup()
        end,
        dependencies = {
            "MunifTanjim/nui.nvim",
            "nvim-lua/plenary.nvim",
            "nvim-telescope/telescope.nvim",
        },
    },
    {
        "runninghai/manim.nvim",
        dev = true,
    },
}

local codePath = os.getenv("CODEPATH")
require("lazy").setup({
    spec = spec,
    dev = {
        path = codePath .. "/git",
    },
})

local scan = require("plenary.scandir")
local plugins = scan.scan_dir(string.format("%s/lua/plugin", fn.stdpath("config")), { hidden = true, depth = 2 })
local plugin_init = string.format("%s/lua/plugin/%s", fn.stdpath("config"), "init.lua")
for _, file in ipairs(plugins) do
    if file ~= plugin_init then
        cmd("source " .. file)
    end
end
