-- lua/config/keymaps.lua
-- (Add these to your existing keymaps file or create a new one)

-- Web Development Shortcuts

vim.keymap.set("n", "<leader>wh", ":new index.html<CR>", { desc = "New HTML file" })
vim.keymap.set("n", "<leader>wc", ":new style.css<CR>", { desc = "New CSS file" })
vim.keymap.set("n", "<leader>wj", ":new script.js<CR>", { desc = "New JS file" })

-- Quick HTML tags
vim.keymap.set("i", "<C-t>", '<Esc>:lua require("web-helpers").wrap_tag()<CR>a', { desc = "Wrap with tag" })

-- CSS shortcuts
vim.keymap.set("i", "<C-f>", "display: flex;<Esc>o", { desc = "Insert flex" })
vim.keymap.set("i", "<C-g>", "display: grid;<Esc>o", { desc = "Insert grid" })

-- File navigation
vim.keymap.set("n", "<leader>ff", ":Telescope find_files<CR>", { desc = "Find files" })
vim.keymap.set("n", "<leader>fg", ":Telescope live_grep<CR>", { desc = "Live grep" })

-- Split navigation
vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "Go to left window" })

vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "Go to lower window" })
vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = "Go to upper window" })
vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "Go to right window" })

-- Quick save and format
vim.keymap.set("n", "<leader>w", ":w<CR>", { desc = "Save file" })
vim.keymap.set("n", "<leader>f", ":lua vim.lsp.buf.format()<CR>", { desc = "Format file" })

-- Web helpers module
local M = {}

function M.wrap_tag()
	local tag = vim.fn.input("Tag: ")
	if tag ~= "" then
		vim.cmd("normal! ciw<" .. tag .. "></" .. tag .. ">")

		vim.cmd("normal! F>a")
	end
end

return M
