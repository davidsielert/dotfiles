-- This file can be loaded by calling `lua require('plugins')` from your init.vim
-- Only required if you have packer configured as `opt`

local plugins = {
    -- Packer can manage itself
    {
        'nvim-telescope/telescope.nvim', tag = '0.1.3',
        dependencies = { {'nvim-lua/plenary.nvim'} },
        config=function()
              local ts = require('telescope')
              ts.setup {
                pickers = {
                  find_files = {
                    follow = true
                  }
                }
              }
        end,
        init=function()
            local builtin = require('telescope.builtin')
            vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
            vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
            vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
            vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})
            vim.keymap.set('n', '<C-p>', builtin.git_files, {})
            vim.keymap.set('n', '<leader>ps', function()
                builtin.grep_string({ search = vim.fn.input("<Grep > ") })
            end)

        end,
    },
    {
        "folke/trouble.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        opts = {
            -- your configuration comes here
            -- or leave it empty to use the default settings
            -- refer to the configuration section below
        },
    },

    { 'rose-pine/neovim', name = 'rose-pine' },
    {"nvim-treesitter/nvim-treesitter", build = ":TSUpdate"},
    "nvim-treesitter/playground",
    'nvim-lua/plenary.nvim',
    'ThePrimeagen/harpoon',
    'mbbill/undotree',
    'tpope/vim-fugitive',
    {
        'VonHeikemen/lsp-zero.nvim', 
        branch = 'v3.x',
        lazy = true,
        config = false,
        init = function()
            -- Disable automatic setup, we are doing it manually
            vim.g.lsp_zero_extend_cmp = 0
            vim.g.lsp_zero_extend_lspconfig = 0
        end,
    },
    {
        'neovim/nvim-lspconfig',
        cmd = {'LspInfo', 'LspInstall', 'LspStart'},
        event = {'BufReadPre', 'BufNewFile'},
        dependencies = {
            {'hrsh7th/cmp-nvim-lsp'},
            {'williamboman/mason-lspconfig.nvim'},
        },
        config = function()
            -- This is where all the LSP shenanigans will live
            local lsp_zero = require('lsp-zero')
            lsp_zero.extend_lspconfig()

            lsp_zero.on_attach(function(client, bufnr)
                -- see :help lsp-zero-keybindings
                -- to learn the available actions
                lsp_zero.default_keymaps({buffer = bufnr})
            end)

            require('mason-lspconfig').setup({
                ensure_installed = {},
                handlers = {
                    lsp_zero.default_setup,
                    lua_ls = function()
                        -- (Optional) Configure lua language server for neovim
                        local lua_opts = lsp_zero.nvim_lua_ls()
                        require('lspconfig').lua_ls.setup(lua_opts)
                    end,
                }
            })
        end
    },
    
    {'hrsh7th/cmp-nvim-lsp'},
    {
        'hrsh7th/nvim-cmp',
        event = 'InsertEnter',
        dependencies = {
            {'L3MON4D3/LuaSnip'},
        },
        config = function()
            -- Here is where you configure the autocompletion settings.
            local lsp_zero = require('lsp-zero')
            lsp_zero.extend_cmp()

            -- And you can configure cmp even more, if you want to.
            local cmp = require('cmp')
            local cmp_action = lsp_zero.cmp_action()

            cmp.setup({
                formatting = lsp_zero.cmp_format(),
                mapping = cmp.mapping.preset.insert({
                    ['<C-Space>'] = cmp.mapping.complete(),
                    ['<C-u>'] = cmp.mapping.scroll_docs(-4),
                    ['<C-d>'] = cmp.mapping.scroll_docs(4),
                    ['<C-f>'] = cmp_action.luasnip_jump_forward(),
                    ['<C-b>'] = cmp_action.luasnip_jump_backward(),
                })
            })
        end
    },
    
    {
        'williamboman/mason.nvim',
        lazy = false,
        config = true,
    },  
    {
        'nvim-tree/nvim-tree.lua',
        dependencies = {'nvim-tree/nvim-web-devicons'},
    },

    'lewis6991/gitsigns.nvim' ,
    'christoomey/vim-tmux-navigator',
    "zbirenbaum/copilot.lua",
    'nvim-lualine/lualine.nvim',
     {'akinsho/bufferline.nvim', version = "*", dependencies = 'nvim-tree/nvim-web-devicons'},
    {
        'mfussenegger/nvim-dap',
        init = function()
            require 'config.dap_setup'
        end,
        config = function()
            require 'config.dap'
        end,
        dependencies = {
            'jbyuki/one-small-step-for-vimkind',
            "mfussenegger/nvim-dap-python",
            'folke/neodev.nvim',


            {
                'rcarriga/nvim-dap-ui',
                opts = {},
                config = function(_, opts)
                    local dap = require 'dap'
                    local dapui = require 'dapui'
                    dapui.setup(opts)
                    dap.listeners.after.event_initialized['dapui_config'] = function()
                        dapui.open {}
                    end
                    dap.listeners.before.event_terminated['dapui_config'] = function()
                        dapui.close {}
                    end
                    dap.listeners.before.event_exited['dapui_config'] = function()
                        dapui.close {}
                    end
                end,
            },
            {
                'theHamsta/nvim-dap-virtual-text',
                opts = {},
            },
        },
        cmd = { 'BreakpointToggle', 'Debug', 'DapREPL' },
    },
    {
        'ThePrimeagen/vim-be-good'
    }, 
    {
        'lambdalisue/suda.vim'
    },
    {"brenoprata10/nvim-highlight-colors"},
    {"RRethy/vim-hexokinase"}


}
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
local opts =  {}
vim.opt.rtp:prepend(lazypath)
require("lazy").setup(plugins,opts)
