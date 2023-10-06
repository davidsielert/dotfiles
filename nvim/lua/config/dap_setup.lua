local map = vim.api.nvim_set_keymap
local create_cmd = vim.api.nvim_create_user_command

create_cmd('BreakpointToggle', function()
  require('dap').toggle_breakpoint()
end, {})
create_cmd('Debug', function()
  require('dap').continue()
end, {})
create_cmd('DapREPL', function()
  require('dap').repl.open()
end, {})

map('n', '<F5>', '', {
  callback = function()
    require('dap').continue()
  end,
  noremap = true,
})
map('n', '<F10>', '', {
  callback = function()
    require('dap').step_over()
  end,
  noremap = true,
})
map('n', '<F11>', '', {
  callback = function()
    require('dap').step_into()
  end,
  noremap = true,
})
map('n', '<F12>', '', {
  callback = function()
    require('dap').step_out()
  end,
  noremap = true,
})


map('n','<leader>b','',{
    callback = function()
        require("dap").toggle_breakpoint()
    end,
    noremap=true,
})
vim.keymap.set('n', '<Leader>B', function() require('dap').set_breakpoint() end)
vim.keymap.set('n', '<Leader>lp', function() require('dap').set_breakpoint(nil, nil, vim.fn.input('Log point message: ')) end)
vim.keymap.set('n', '<Leader>dr', function() require('dap').repl.open() end)
vim.keymap.set('n', '<Leader>dl', function() require('dap').run_last() end)
vim.keymap.set({'n', 'v'}, '<Leader>dh', function()
  require('dap.ui.widgets').hover()
end)
vim.keymap.set({'n', 'v'}, '<Leader>dp', function()
  require('dap.ui.widgets').preview()
end)
vim.keymap.set('n', '<Leader>df', function()
  local widgets = require('dap.ui.widgets')
  widgets.centered_float(widgets.frames)
end)
vim.keymap.set('n', '<Leader>ds', function()
  local widgets = require('dap.ui.widgets')
  widgets.centered_float(widgets.scopes)
end)
