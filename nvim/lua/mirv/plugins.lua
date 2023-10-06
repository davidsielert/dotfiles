-- This file can be loaded by calling `lua require('plugins')` from your init.vim
-- Only required if you have packer configured as `opt`

local plugins = {
	-- Packer can manage itself
	{
		'nvim-telescope/telescope.nvim', tag = '0.1.3',
		dependencies = { {'nvim-lua/plenary.nvim'} },
		init=function()
			local builtin = require('telescope.builtin')
			vim.keymap.set('n', '<leader>pf', builtin.find_files, {})
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
		dependencies = {
			{'williamboman/mason.nvim'},
			{'williamboman/mason-lspconfig.nvim'},

			-- LSP Support:
			{'neovim/nvim-lspconfig'},
			-- Autocompletion
			{'hrsh7th/nvim-cmp'},
			{'hrsh7th/cmp-nvim-lsp'},
			{'L3MON4D3/LuaSnip'},
		}
	},
	{
		'nvim-tree/nvim-tree.lua',
		dependencies = {
			'nvim-tree/nvim-web-devicons',
		},
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

	--    "mfussenegger/nvim-dap-python",
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
