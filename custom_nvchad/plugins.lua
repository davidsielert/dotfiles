local overrides = require "custom.configs.overrides"
local code_ft = {
  "c",
  "cpp",
  "lua",
  "rust",
  "go",
  "yaml",
  "json",
  "env",
  "sh",
  "bash",
  "python",
  "yaml.ansible",
}

---@type NvPluginSpec[]
local plugins = {
  { "nvim-lua/plenary.nvim" },
  {
    "petertriho/nvim-scrollbar",
    event = "WinScrolled",
    config = function()
      require "custom.configs.scrollbar"
    end,
  },
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      -- {
      --   "nvimtools/none-ls.nvim",
      --   config = function()
      --     require "custom.configs.null-ls"
      --   end,
      -- },
      {
        "williamboman/mason.nvim",
        opts = overrides.mason,
        config = function(_, opts)
          dofile(vim.g.base46_cache .. "mason")
          dofile(vim.g.base46_cache .. "lsp")
          require("mason").setup(opts)
          vim.api.nvim_create_user_command("MasonInstallAll", function()
            vim.cmd("MasonInstall " .. table.concat(opts.ensure_installed, " "))
          end, {})
          require "custom.configs.lspconfig"
        end,
      },
      "williamboman/mason-lspconfig.nvim",
      { "folke/neodev.nvim", opts = {} },
      {
        "jose-elias-alvarez/null-ls.nvim",
        config = function()
          require "custom.configs.null-ls"
        end,
      },
    },
    config = function()
    --  require "plugins.configs.lspconfig"
    --  require "custom.configs.lspconfig"
    end,
  },

  -- {
  --   "jose-elias-alvarez/null-ls.nvim",
  --   enabled = false,
  -- },
  --   {
  --     "neovim/nvim-lspconfig",
  --     dependencies = {
  --       -- format & linting
  --       {
  --         "jose-elias-alvarez/null-ls.nvim",
  --         config = function()
  --           require "custom.configs.null-ls"
  --         end,
  --       },
  --     },
  --     config = function()
  --       require "plugins.configs.lspconfig"
  --       require "custom.configs.lspconfig"
  --     end, -- Override to setup mason-lspconfig
  --   },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = overrides.treesitter,
  },

  {
    "nvim-tree/nvim-tree.lua",
    opts = overrides.nvimtree,
  },
  {
    "max397574/better-escape.nvim",
    event = "InsertEnter",
    config = function()
      require("better_escape").setup()
    end,
  },
  -- Rust DAP
  {
    "mrcjkb/rustaceanvim",
    version = "^3", -- Recommended
    ft = { "rust" },
  },

  --{
  --  "simrat39/rust-tools.nvim",
  --  ft = { "rust" },
  --  dependencies = { "neovim/nvim-lspconfig", "nvim-lua/plenary.nvim", "mfussenegger/nvim-dap" },
  --},
  { "mbbill/undotree" },
  {
    "folke/trouble.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
    },
  },
  {
    "kdheepak/lazygit.nvim",
    cmd = "LazyGit",
  },
  {
    "BrunoKrugel/lazydocker.nvim",
    cmd = "LazyDocker",
  },

  {
    "mfussenegger/nvim-dap",
    init = function()
      require "custom.configs.dap_setup"
    end,
    config = function()
      require "custom.configs.dap"
    end,
    dependencies = {
      "jbyuki/one-small-step-for-vimkind",
      "mfussenegger/nvim-dap-python",
      "folke/neodev.nvim",

      {
        "rcarriga/nvim-dap-ui",
        opts = {},
        config = function(_, opts)
          local dap = require "dap"
          local dapui = require "dapui"
          dapui.setup(opts)
          dap.listeners.after.event_initialized["dapui_config"] = function()
            dapui.open {}
          end
          dap.listeners.before.event_terminated["dapui_config"] = function()
            dapui.close {}
          end
          dap.listeners.before.event_exited["dapui_config"] = function()
            dapui.close {}
          end
        end,
      },
      {
        "theHamsta/nvim-dap-virtual-text",
        opts = {},
      },
    },
    cmd = { "BreakpointToggle", "Debug", "DapREPL" },
  },
  {
    "nvimdev/lspsaga.nvim",
    -- ft = code_ft,
    event = "LspAttach",
    config = function()
      require "custom.configs.lspsaga"
    end,
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-tree/nvim-web-devicons",
    },
  },
  {
    "Fildo7525/pretty_hover",
    event = "LspAttach",
    --    opts = {},
  },
  {
    "NvChad/nvim-colorizer.lua",
    opts = overrides.colorizer,
  },
  {
    "folke/todo-comments.nvim",
    event = "BufReadPost",
    config = function()
      require "custom.configs.todo"
      dofile(vim.g.base46_cache .. "todo")
    end,
  },
  {
    "chikko80/error-lens.nvim",
    ft = code_ft,
    config = true,
  },
  {
    "Zeioth/compiler.nvim",
    cmd = { "CompilerOpen", "CompilerToggleResults" },
    dependencies = {
      {
        "stevearc/overseer.nvim",
        -- commit = "3047ede61cc1308069ad1184c0d447ebee92d749",
        opts = {
          task_list = {
            direction = "bottom",
            min_height = 25,
            max_height = 25,
            default_detail = 1,
            bindings = {
              ["q"] = function()
                vim.cmd "OverseerClose"
              end,
            },
          },
        },
      },
    },
    config = function(_, opts)
      require("compiler").setup(opts)
    end,
  },
  {
    "kevinhwang91/nvim-hlslens",
    event = "BufReadPost",
    dependencies = { "petertriho/nvim-scrollbar" },
    config = function()
      require("scrollbar.handlers.search").setup {
        {
          nearest_float_when = false,
          override_lens = function(render, posList, nearest, idx, relIdx)
            local sfw = vim.v.searchforward == 1
            local indicator, text, chunks
            local absRelIdx = math.abs(relIdx)
            if absRelIdx > 1 then
              indicator = ("%d%s"):format(absRelIdx, sfw ~= (relIdx > 1) and icons.misc.up or icons.misc.down)
            elseif absRelIdx == 1 then
              indicator = sfw ~= (relIdx == 1) and icons.misc.up or icons.misc.down
            else
              indicator = icons.misc.dot
            end
            local lnum, col = unpack(posList[idx])
            if nearest then
              local cnt = #posList
              if indicator ~= "" then
                text = ("[%s %d/%d]"):format(indicator, idx, cnt)
              else
                text = ("[%d/%d]"):format(idx, cnt)
              end
              chunks = { { " ", "Ignore" }, { text, "HlSearchLensNear" } }
            else
              text = ("[%s %d]"):format(indicator, idx)
              chunks = { { " ", "Ignore" }, { text, "HlSearchLens" } }
            end
            render.setVirt(0, lnum - 1, col - 1, chunks, nearest)
          end,
        },
      }
    end,
  },
  {

    "lvimuser/lsp-inlayhints.nvim",
    branch = "anticonceal",
    event = "LspAttach",
    config = function()
      require "custom.configs.inlayhints"
    end,
  },
  {
    "shellRaining/hlchunk.nvim",
    event = "BufReadPost",
    config = function()
      require "custom.configs.hlchunk"
    end,
  },
  {
    "github/copilot.vim",
    lazy = false,
    config = function()
      require "custom.configs.copilot"
    end,
  },
  {
    "lambdalisue/suda.vim",
    lazy=false
  },
  {
    "code-biscuits/nvim-biscuits",
    event = "LspAttach",
    config = function()
      require "custom.configs.biscuits"
    end,
  },
  {
    "alexghergh/nvim-tmux-navigation",
    name = "nvim-tmux-navigation",
  },
  -- :h nvim-surround.usage
  {
    "kylechui/nvim-surround",
    version = "*", -- Use for stability; omit to use `main` branch for the latest features
    event = "VeryLazy",
    config = function()
      require("nvim-surround").setup {
        -- Configuration here, or leave empty to use defaults
      }
    end,
  },
  -- doesn't work right
  --   {
  --     "utilyre/barbecue.nvim",
  --     name = "barbecue",
  --     event = "LspAttach",
  --
  --     version = "*",
  --     dependencies = {
  --       "SmiteshP/nvim-navic",
  --       "nvim-tree/nvim-web-devicons", -- optional dependency
  --     },
  --     opts = {
  --       -- configurations go here
  --     },
  --   },
  -- To make a plugin not be loaded
  -- {
  --   "NvChad/nvim-colorizer.lua",
  --   enabled = false
  -- },

  -- All NvChad plugins are lazy-loaded by default
  -- For a plugin to be loaded, you will need to set either `ft`, `cmd`, `keys`, `event`, or set `lazy = false`
  -- If you want a plugin to load on startup, add `lazy = false` to a plugin spec, for example
  -- {
  --   "mg979/vim-visual-multi",
  --   lazy = false,
  -- }
  --
  {
    "YannickFricke/codestats.nvim",
    lazy = false,
    config = function()
      require("codestats-nvim").setup()
    end,
    dependencies = { { "nvim-lua/plenary.nvim" } },
  },
}

return plugins
