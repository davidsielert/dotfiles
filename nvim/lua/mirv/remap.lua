vim.g.mapleader = " "
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- next greatest remap ever : asbjornHaland
vim.keymap.set({"n", "v"}, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])

vim.keymap.set({"n", "v"}, "<leader>d", [["_d]])

-- This is going to get me cance:qlled
vim.keymap.set("i", "<C-c>", "<Esc>")

vim.keymap.set("n", "Q", "<nop>")
vim.keymap.set("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>")
vim.keymap.set("n", "<leader>f", vim.lsp.buf.format)

vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz")
vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz")
vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz")
vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz")

vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })
-- vim.keymap.set("n", "<leader>vpp", "<cmd>e ~/.dotfiles/nvim/.config/nvim/lua/theprimeagen/packer.lua<CR>");
vim.keymap.set("n", "<F2>", "<cmd>NvimTreeToggle<CR>")
vim.keymap.set("n", "<leader><leader>", function()
    vim.cmd("so")
end)
vim.keymap.set("n","<leader>bn","<cmd>bnext<CR>")
vim.keymap.set("n","<leader>bp","<cmd>bprev<CR>")
vim.keymap.set("n","<leader>1",function()
    require('bufferline').go_to_buffer(1, true)
end)

vim.keymap.set("n","<leader>1",function()
    require('bufferline').go_to_buffer(1, true)
end)
vim.keymap.set("n","<leader>2",function()
    require('bufferline').go_to_buffer(2, true)
end)
vim.keymap.set("n","<leader>3",function()
    require('bufferline').go_to_buffer(3, true)
end)
vim.keymap.set("n","<leader>4",function()
    require('bufferline').go_to_buffer(4, true)
end)
vim.keymap.set("n","<leader>4",function()
    require('bufferline').go_to_buffer(4, true)
end)
vim.keymap.set("n","<leader>5",function()
    require('bufferline').go_to_buffer(5, true)
end)
vim.keymap.set("n","<leader>6",function()
    require('bufferline').go_to_buffer(6, true)
end)
