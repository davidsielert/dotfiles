-- local autocmd = vim.api.nvim_create_autocmd

-- Auto resize panes when resizing nvim window
-- autocmd("VimResized", {
--   pattern = "*",
--   command = "tabdo wincmd =",
-- })
vim.filetype.add({
	pattern = {
		-- ansible playbook
		[".*/.*playbook.*.ya?ml"] = "yaml.ansible",
		[".*/.*tasks.*/.*ya?ml"] = "yaml.ansible",
		[".*/local.ya?ml"] = "yaml.ansible",
    --  [".*/hypr/.*%.conf"] = "hypr"
	},
})
-- vim.api.nvim_create_autocmd("FileType", {
--   pattern = "hypr",
--   callback = function(event)
--     vim.bo[event.buf].commentstring = "# %s"
--   end,
-- })
-- eol:↲
-- set list lcs=trail:·,tab:»·
vim.opt.listchars = { space = '·', tab = '»·', nbsp = '␣' }
-- vim.opt.listchars = { lcs = '·', tab = '»' }
local function open_nvim_tree(data)
  local is_real_file = vim.fn.filereadable(data.file) == 1
  local is_no_name_file = data.file == "" and vim.bo[data.buf].buftype == ""
  local is_a_directory = vim.fn.isdirectory(data.file) == 1

  if is_a_directory then
    vim.cmd.cd(data.file)
    require("nvim-tree.api").tree.open()
    return
  end

  if is_real_file or is_no_name_file then
    require("nvim-tree.api").tree.toggle { focus = false, find_file = true }
    return
  end
end

vim.api.nvim_create_autocmd({ "VimEnter" }, { callback = open_nvim_tree })
