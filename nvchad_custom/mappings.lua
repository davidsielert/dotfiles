---@type MappingsTable
local M = {}

M.general = {
  n = {
    [";"] = { ":", "enter command mode", opts = { nowait = true } },
  },
  v = {
    [">"] = { ">gv", "indent"},
  },
}


M.trouble = {
  n = {
    ["<leader>tt"] = { function() require("trouble").toggle() end, "toggle trouble"},
    ["<leader>tw"] = { function() require("trouble").toggle("workspace_diagnostics") end, "toggle trouble workspace"},
    ["<leader>tq"] = { function() require("trouble").toggle("quickfix") end, "toggle trouble quickfix"},
  },
}

M.lspsaga = {
  n = {
    ["<leader>."] = { "<CMD>CodeActionMenu<CR>", "󰅱 Code Action" },
    ["gf"] = {
      function()
        vim.cmd "Lspsaga lsp_finder"
      end,
      " Go to definition",
    },
    ["gt"] = {
      "<CMD>Lspsaga goto_definition<CR>",
      " Go to definition",
    },
    ["<leader>lp"] = {
      "<CMD>Lspsaga peek_definition<CR>",
      " Peek definition",
    },

    ["<leader>k"] = {
      -- "<CMD>Lspsaga hover_doc<CR>",
      function()
        require("pretty_hover").hover()
      end,
      "󱙼 Hover lsp",
    },
    ["<leader>o"] = { "<CMD>Lspsaga outline<CR>", " Show Outline" },
    --  LSP
    ["gr"] = { "<CMD>Telescope lsp_references<CR>", " Lsp references" },
    ["[d"] = { "<CMD>Lspsaga diagnostic_jump_prev<CR>", " Prev Diagnostic" },
    ["]d"] = { "<CMD>Lspsaga diagnostic_jump_next<CR>", " Next Diagnostic" },
    ["<leader>qf"] = {
      function()
        vim.diagnostic.setloclist()
      end,
      "󰁨 Lsp Quickfix",
    },
  },
}

M.telescope = {
  n = {
    ["<leader>li"] = { "<CMD>Telescope highlights<CR>", "Highlights" },
    ["<leader>fk"] = { "<CMD>Telescope keymaps<CR>", " Find keymaps" },
    ["<leader>fs"] = { "<CMD>Telescope lsp_document_symbols<CR>", " Find document symbols" },
    ["<leader>fr"] = { "<CMD>Telescope frecency<CR>", " Recent files" },
    ["<leader>fu"] = { "<CMD>Telescope undo<CR>", " Undo tree" },
    ["<leader>fg"] = { "<CMD>Telescope ast_grep<CR>", " Structural Search" },
  }
}
M.compiler = {
  n = {
    ["<F4>"] = {"<cmd>CompilerOpen<cr>"}
  }
}
M.tmux = {
  n = {
    ["<C-h>"] = { function() require("nvim-tmux-navigation").NvimTmuxNavigateLeft() end ,"Tmux Navigate Left"},
    ["<C-j>"] = { function() require("nvim-tmux-navigation").NvimTmuxNavigateDown() end ,"Tmux Navigate Down"},
    ["<C-k>"] = { function() require("nvim-tmux-navigation").NvimTmuxNavigateUp() end ,"Tmux Navigate Up"},
    ["<C-l>"] = { function() require("nvim-tmux-navigation").NvimTmuxNavigateRight() end ,"Tmux Navigate Right"},
  }
}

M.DAP = {
  n = {
    ['<Leader>B'] = { function() require('dap').set_breakpoint() end, "Toggle Breakpoint"},
    ['<F5>'] = { function() require('dap').continue() end, "Continue Execution"},
    ['<F8>'] = { function() require('dap').step_over() end, "Continue Execution"},
    ['<F7>'] = { function() require('dap').step_into() end, "Continue Execution"},
    ['<F9>'] = { function() require('dap').step_out() end, "Continue Execution"},
    ['<leader>dh'] = { function()
      require('dap.ui.widgets').hover() end, "DAP Hover"},
    ['<leader>dp'] = { function()
      local widgets = require('dap.ui.widgets')
      widgets.preview()
    end, "DAP Preview"},
    ['<leader>df'] = { function()
      local widgets = require('dap.ui.widgets')
      widgets.centered_float(widgets.frames)
    end, "DAP Frames Float"},
    ['<leader>ds'] = { function()
      local widgets = require('dap.ui.widgets')
      widgets.centered_float(widgets.scopes)
    end, "DAP Widget float"},
    -- [''] = { function() require('dap'). end, ""}
    -- [''] = { function() require('dap'). end, ""},
    -- [''] = { function() require('dap'). end, ""},
    -- [''] = { function() require('dap'). end, ""},
    -- [''] = { function() require('dap'). end, ""},
  },
}


return M
