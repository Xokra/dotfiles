vim.g.mapleader = " "

-- vim.api.nvim_set_keymap('n', '<C-s>', ':w<CR>', { noremap = true, silent = true })
-- vim.api.nvim_set_keymap('n', '<C-q>', ':wq<CR>', { noremap = true, silent = true })

local keymap = vim.keymap

keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })

keymap.set("n", "<leader>pv", vim.cmd.Ex)

keymap.set("n", "<C-q>", "gg<S-v>G", { desc = "Select all" })

keymap.set("v", "J", ":m '>+1<CR>gv=gv")
keymap.set("v", "K", ":m '<-2<CR>gv=gv")

keymap.set("n", "J", "mzJ`z")
keymap.set("n", "<C-d>", "<C-d>zz")
keymap.set("n", "<C-u>", "<C-u>zz")

keymap.set("n", "n", "nzzzv")
keymap.set("n", "N", "Nzzzv")

--reconfigure your deleted to paste buffer
keymap.set("x", "<leader>p", '"_dP')
keymap.set("n", "<leader>p", '"_dP')
keymap.set("v", "<leader>p", '"_dP')

keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz")
keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz")
keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz")
keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz")

--change or replace the word you are on to all the same word with it
keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], { desc = "change all the text" })

--chmod straigt away your file
keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true, desc = "!chmod this file" })

--remove highlight after search
keymap.set("n", "<leader>nh", ":nohl<CR>", { desc = "Clear search highlights" })

--close your current split
keymap.set("n", "<leader>vw", "<cmd>close<CR>", { desc = "Close current split" }) -- close current split

keymap.set("n", "<leader>l", ":Lazy<CR>", { noremap = true, silent = true, desc = "Open Lazy.Nvim" })

keymap.set("n", "`", vim.cmd.UndotreeToggle)

keymap.set("n", "<leader>m", ":Mason<CR>", { desc = "Mason" })
