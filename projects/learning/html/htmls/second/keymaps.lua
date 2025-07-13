-- Set leader key
vim.g.mapleader = " "

-- Helper function for consistent keymap options
local function map(mode, lhs, rhs, opts)
	local options = { noremap = true, silent = true }
	if opts then
		options = vim.tbl_extend("force", options, opts)
	end
	vim.keymap.set(mode, lhs, rhs, options)
end

-- ================================
-- BASIC EDITOR OPERATIONS

-- ================================

-- File operations
map("n", "<C-s>", ":w<CR>", { desc = "Save file" })
-- map("n", "<C-q>", ":wq<CR>", { desc = "Save and quit" })  -- Conflicts with your select all
map("n", "<leader>q", ":q<CR>", { desc = "Quit" })
map("n", "<leader>Q", ":qa<CR>", { desc = "Quit all" })
map("n", "<leader>w", ":w<CR>", { desc = "Save" })
map("n", "<leader>W", ":wa<CR>", { desc = "Save all" })

-- Selection and editing
map("n", "<C-q>", "gg<S-v>G", { desc = "Select all" })
map("n", "<C-a>", "ggVG", { desc = "Select all (alternative)" }) -- Common alternative

-- Move selected lines up/down
map("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move selection down" })
map("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move selection up" })

-- Better line joining
map("n", "J", "mzJ`z", { desc = "Join line below" })

-- ================================
-- NAVIGATION & SCROLLING

-- ================================

-- Centered scrolling
map("n", "<C-d>", "<C-d>zz", { desc = "Scroll down centered" })
map("n", "<C-u>", "<C-u>zz", { desc = "Scroll up centered" })

-- Centered search navigation
map("n", "n", "nzzzv", { desc = "Next search result centered" })
map("n", "N", "Nzzzv", { desc = "Previous search result centered" })

-- Clear search highlights
map("n", "<leader>nh", ":nohl<CR>", { desc = "Clear search highlights" })

-- ================================
-- QUICKFIX & LOCATION LISTS
-- ================================

-- Quickfix navigation
map("n", "<C-k>", "<cmd>cnext<CR>zz", { desc = "Next quickfix item" })
map("n", "<C-j>", "<cmd>cprev<CR>zz", { desc = "Previous quickfix item" })

-- Location list navigation
map("n", "<leader>k", "<cmd>lnext<CR>zz", { desc = "Next location item" })
map("n", "<leader>j", "<cmd>lprev<CR>zz", { desc = "Previous location item" })

-- ================================
-- COPY, PASTE & REGISTER OPERATIONS
-- ================================

-- Paste without overwriting register

map("x", "<leader>p", '"_dP', { desc = "Paste without overwriting register" })
map("n", "<leader>p", '"_dP', { desc = "Paste without overwriting register" })
map("v", "<leader>p", '"_dP', { desc = "Paste without overwriting register" })

-- Copy to system clipboard
map("n", "<leader>y", '"+y', { desc = "Copy to system clipboard" })
map("v", "<leader>y", '"+y', { desc = "Copy to system clipboard" })
map("n", "<leader>Y", '"+Y', { desc = "Copy line to system clipboard" })

-- Paste from system clipboard

-- map("n", "<leader>P", '"+p', { desc = "Paste from system clipboard" })
-- map("v", "<leader>P", '"+p', { desc = "Paste from system clipboard" })

-- Delete without overwriting register
map("n", "<leader>d", '"_d', { desc = "Delete without overwriting register" })
map("v", "<leader>d", '"_d', { desc = "Delete without overwriting register" })

-- ================================
-- SEARCH & REPLACE
-- ================================

-- Replace word under cursor globally
map("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], { desc = "Replace word under cursor" })
map("v", "<leader>s", [[y:%s/<C-r>"/<C-r>"/gI<Left><Left><Left>]], { desc = "Replace selected text" })

-- Case-insensitive search and replace
-- map("n", "<leader>S", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gIc<Left><Left><Left><Left>]], { desc = "Replace word (confirm each)" })

-- ================================
-- SPLIT & WINDOW MANAGEMENT
-- ================================

-- Split operations
map("n", "<leader>vw", "<cmd>close<CR>", { desc = "Close current split" })
map("n", "<leader>vs", ":vsplit<CR>", { desc = "Vertical split" })
map("n", "<leader>hs", ":split<CR>", { desc = "Horizontal split" })

-- Window navigation
-- map("n", "<leader>h", "<C-w>h", { desc = "Move to left split" })
-- map("n", "<leader>l", "<C-w>l", { desc = "Move to right split" })  -- Conflicts with your Lazy
-- map("n", "<leader>j", "<C-w>j", { desc = "Move to bottom split" })  -- Conflicts with location list
-- map("n", "<leader>k", "<C-w>k", { desc = "Move to top split" })     -- Conflicts with location list

-- Alternative window navigation

map("n", "<C-h>", "<C-w>h", { desc = "Move to left split" })
map("n", "<C-l>", "<C-w>l", { desc = "Move to right split" })
-- map("n", "<C-j>", "<C-w>j", { desc = "Move to bottom split" })  -- Conflicts with quickfix
-- map("n", "<C-k>", "<C-w>k", { desc = "Move to top split" })     -- Conflicts with quickfix

-- Window resizing
map("n", "<leader>+", "<C-w>+", { desc = "Increase window height" })
map("n", "<leader>-", "<C-w>-", { desc = "Decrease window height" })
map("n", "<leader>>", "<C-w>>", { desc = "Increase window width" })
map("n", "<leader><", "<C-w><", { desc = "Decrease window width" })
map("n", "<leader>=", "<C-w>=", { desc = "Equalize windows" })

-- ================================
-- FILE MANAGEMENT
-- ================================

-- File explorer
map("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })
map("n", "<leader>pv", vim.cmd.Ex, { desc = "Open netrw" })

-- File permissions
map("n", "<leader>x", "<cmd>!chmod +x %<CR>", { desc = "Make file executable" })

-- Open in browser (WSL specific)
map("n", "<leader>ob", function()
	local file = vim.fn.expand("%:p")
	vim.fn.system('wslview "' .. file .. '"')
end, { desc = "Open in browser" })

-- ================================
-- PLUGIN MANAGEMENT
-- ================================

-- Plugin managers

map("n", "<leader>l", ":Lazy<CR>", { desc = "Open Lazy.nvim" })

map("n", "<leader>m", ":Mason<CR>", { desc = "Open Mason" })

-- Utility plugins
map("n", "`", vim.cmd.UndotreeToggle, { desc = "Toggle Undotree" })
map("n", "<leader>u", vim.cmd.UndotreeToggle, { desc = "Toggle Undotree (alternative)" })

-- ================================
-- HTML/CSS WEB DEVELOPMENT
-- ================================

-- Emmet expansion
map("i", "<C-y>,", "<plug>(emmet-expand-abbr)", { desc = "Emmet expand" })
map("n", "<C-y>,", "<plug>(emmet-expand-abbr)", { desc = "Emmet expand" })

-- Snippet navigation (LuaSnip)
-- map("i", "<C-k>", function() require('luasnip').expand() end, { desc = "Expand snippet" })  -- Conflicts with quickfix

-- map("i", "<C-l>", function() require('luasnip').jump(1) end, { desc = "Jump to next snippet" })   -- Conflicts with window nav
-- map("i", "<C-h>", function() require('luasnip').jump(-1) end, { desc = "Jump to previous snippet" })  -- Conflicts with window nav

-- Alternative snippet navigation
map("i", "<Tab>", function()
	local luasnip = require("luasnip")

	if luasnip.expand_or_jumpable() then
		luasnip.expand_or_jump()
	else
		return "<Tab>"
	end
end, { expr = true, desc = "Expand or jump snippet" })

map("i", "<S-Tab>", function()
	local luasnip = require("luasnip")
	if luasnip.jumpable(-1) then
		luasnip.jump(-1)
	else
		return "<S-Tab>"
	end
end, { expr = true, desc = "Jump to previous snippet" })

-- Quick HTML structure templates
map("n", "<leader>h5", "ihtml5<Tab>", { desc = "HTML5 boilerplate" })
map("n", "<leader>hc", "icard<Tab>", { desc = "HTML card component" })
map("n", "<leader>hf", "iform<Tab>", { desc = "HTML form" })

map("n", "<leader>hl", "ilanding<Tab>", { desc = "HTML landing section" })
map("n", "<leader>hn", "inavbar<Tab>", { desc = "HTML navbar" })

-- Quick CSS utilities
map("n", "<leader>cf", "iflex<Tab>", { desc = "CSS flexbox" })
map("n", "<leader>cg", "igrid<Tab>", { desc = "CSS grid" })
map("n", "<leader>cb", "ibtn<Tab>", { desc = "CSS button" })
map("n", "<leader>cc", "icard<Tab>", { desc = "CSS card" })
map("n", "<leader>cr", "iresponsive<Tab>", { desc = "CSS responsive" })
map("n", "<leader>ct", "ireset<Tab>", { desc = "CSS reset" })

-- Live server
map("n", "<leader>ls", ":Bracey<CR>", { desc = "Start live server" })
map("n", "<leader>lx", ":BraceyStop<CR>", { desc = "Stop live server" })
map("n", "<leader>lr", ":BraceyReload<CR>", { desc = "Reload live server" })

-- HTML tag manipulation
map("v", "<leader>wt", 'c<><C-r>"</>', { desc = "Wrap selection in HTML tags" })
map("v", "<leader>wd", 'c<div><C-r>"</div>', { desc = "Wrap selection in div" })
map("v", "<leader>ws", 'c<span><C-r>"</span>', { desc = "Wrap selection in span" })

-- ================================
-- PRODUCTIVITY & UTILITIES
-- ================================

-- Quick escape alternatives

map("i", "jk", "<ESC>", { desc = "Exit insert mode" })
map("i", "kj", "<ESC>", { desc = "Exit insert mode" })

-- Center cursor on various operations
map("n", "G", "Gzz", { desc = "Go to end of file centered" })
map("n", "gg", "ggzz", { desc = "Go to start of file centered" })

-- Better indenting
map("v", "<", "<gv", { desc = "Indent left and reselect" })
map("v", ">", ">gv", { desc = "Indent right and reselect" })

-- Line numbers toggle
-- map("n", "<leader>nn", ":set nu!<CR>", { desc = "Toggle line numbers" })

-- map("n", "<leader>nr", ":set rnu!<CR>", { desc = "Toggle relative line numbers" })

-- ================================
-- COMMENTED OUT ALTERNATIVES
-- ================================

-- These keymaps are commented out because they might conflict with existing plugins
-- Uncomment them if you need them and they don't conflict

-- Alternative file operations
-- map("n", "<C-n>", ":enew<CR>", { desc = "New file" })
-- map("n", "<C-o>", ":browse confirm e<CR>", { desc = "Open file" })

-- Alternative navigation
-- map("n", "<leader>e", ":Ex<CR>", { desc = "Open file explorer" })
-- map("n", "<leader>E", ":Sex<CR>", { desc = "Open file explorer in split" })

-- Alternative search
-- map("n", "<leader>/", "/", { desc = "Search forward" })
-- map("n", "<leader>?", "?", { desc = "Search backward" })

-- Buffer navigation
-- map("n", "<leader>bn", ":bnext<CR>", { desc = "Next buffer" })
-- map("n", "<leader>bp", ":bprevious<CR>", { desc = "Previous buffer" })
-- map("n", "<leader>bd", ":bdelete<CR>", { desc = "Delete buffer" })

-- Tab navigation

-- map("n", "<leader>tn", ":tabnew<CR>", { desc = "New tab" })
-- map("n", "<leader>tc", ":tabclose<CR>", { desc = "Close tab" })
-- map("n", "<leader>to", ":tabonly<CR>", { desc = "Close other tabs" })

-- Terminal shortcuts
-- map("n", "<leader>tt", ":terminal<CR>", { desc = "Open terminal" })
-- map("t", "<Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

-- ================================
-- TABLE MODE (Your commented keymaps)
-- ================================

-- Table Mode keymaps - uncomment if you use the table mode plugin
-- map("n", "<Leader>tm", ":TableModeToggle<CR>", { desc = "Toggle Table Mode" })
-- map("n", "<Leader>ta", ":TableModeRealign<CR>", { desc = "Realign Table" })
-- map("n", "<Leader>tr", ":TableModeInsertRow<CR>", { desc = "Insert Row in Table" })
-- map("n", "<Leader>td", ":TableModeDeleteRow<CR>", { desc = "Delete Row in Table" })
-- map("n", "<Leader>tc", ":TableModeInsertColumn<CR>", { desc = "Insert Column in Table" })
-- map("n", "<Leader>tx", ":TableModeDeleteColumn<CR>", { desc = "Delete Column in Table" })
-- map("n", "<Leader>te", ":TableModeDisable<CR>", { desc = "Disable Table Mode" })

-- ================================
-- DEBUGGING HELPERS
-- ================================

-- Show current file path
-- map("n", "<leader>fp", ":echo expand('%:p')<CR>", { desc = "Show full file path" })

-- Reload configuration
-- map("n", "<leader>R", ":source $MYVIMRC<CR>", { desc = "Reload config" })

-- Check key mappings
-- map("n", "<leader>?", ":map<CR>", { desc = "Show all keymaps" })

-- ================================
-- TELESCOPE FUZZY FINDER
-- ================================

-- File finding
map("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "Find files in cwd" })
map("n", "<leader>fr", "<cmd>Telescope oldfiles<cr>", { desc = "Find recent files" })
map("n", "<leader>fb", "<cmd>Telescope buffers<cr>", { desc = "Find buffers" })
map("n", "<leader>fh", "<cmd>Telescope help_tags<cr>", { desc = "Find help tags" })

-- Text searching
map("n", "<leader>fs", "<cmd>Telescope live_grep<cr>", { desc = "Find string in cwd" })
map("n", "<leader>fc", "<cmd>Telescope grep_string<cr>", { desc = "Find string under cursor" })
map("n", "<leader>ft", "<cmd>TodoTelescope<cr>", { desc = "Find todos" })

-- Git integration
map("n", "<leader>fgc", "<cmd>Telescope git_commits<cr>", { desc = "Find git commits" })
map("n", "<leader>fgb", "<cmd>Telescope git_branches<cr>", { desc = "Find git branches" })

map("n", "<leader>fgs", "<cmd>Telescope git_status<cr>", { desc = "Find git status" })

-- LSP integration
map("n", "<leader>fls", "<cmd>Telescope lsp_document_symbols<cr>", { desc = "Find LSP symbols" })
map("n", "<leader>flw", "<cmd>Telescope lsp_workspace_symbols<cr>", { desc = "Find LSP workspace symbols" })

-- ================================
-- LAZYGIT INTEGRATION
-- ================================

-- LazyGit main interface
map("n", "<leader>gg", ":LazyGit<CR>", { desc = "Open LazyGit" })
map("n", "<leader>gl", ":LazyGitCurrentFile<CR>", { desc = "LazyGit current file" })

-- Git operations (fallback commands if LazyGit not available)
-- map("n", "<leader>gs", ":Git<CR>", { desc = "Git status" })
-- map("n", "<leader>gc", ":Git commit<CR>", { desc = "Git commit" })
-- map("n", "<leader>gp", ":Git push<CR>", { desc = "Git push" })
-- map("n", "<leader>gd", ":Git diff<CR>", { desc = "Git diff" })
-- map("n", "<leader>gb", ":Git blame<CR>", { desc = "Git blame" })

-- ================================
-- TMUX INTEGRATION
-- ================================

-- Tmux navigation (if using vim-tmux-navigator)
-- map("n", "<C-h>", ":TmuxNavigateLeft<CR>", { desc = "Navigate to left tmux pane" })
-- map("n", "<C-j>", ":TmuxNavigateDown<CR>", { desc = "Navigate to down tmux pane" })
-- map("n", "<C-k>", ":TmuxNavigateUp<CR>", { desc = "Navigate to up tmux pane" })
-- map("n", "<C-l>", ":TmuxNavigateRight<CR>", { desc = "Navigate to right tmux pane" })

-- Tmux session management
-- map("n", "<leader>ts", ":!tmux new-session -d -s ", { desc = "Create new tmux session" })
-- map("n", "<leader>ta", ":!tmux attach-session -t ", { desc = "Attach to tmux session" })

-- ================================
-- STOW DOTFILES MANAGEMENT
-- ================================

-- Quick dotfiles editing

map("n", "<leader>dot", ":e ~/.config/nvim/init.lua<CR>", { desc = "Edit nvim config" })

map("n", "<leader>doz", ":e ~/.zshrc<CR>", { desc = "Edit zsh config" })

map("n", "<leader>dot", ":e ~/.tmux.conf<CR>", { desc = "Edit tmux config" })

-- Stow operations (requires terminal)
-- map("n", "<leader>ds", ":!cd ~/.dotfiles && stow nvim<CR>", { desc = "Stow nvim config" })
-- map("n", "<leader>du", ":!cd ~/.dotfiles && stow -D nvim<CR>", { desc = "Unstow nvim config" })

-- ================================
-- LSP KEYMAPS (Already configured in lspconfig)
-- ================================

-- These are handled by your lspconfig.lua file:
-- gR - Show LSP references (Telescope)
-- gD - Go to declaration
-- gd - Show LSP definitions (Telescope)
-- gi - Show LSP implementations (Telescope)
-- gt - Show LSP type definitions (Telescope)

-- <leader>ca - Code actions
-- <leader>rn - Smart rename
-- <leader>D - Show buffer diagnostics (Telescope)

-- <leader>d - Show line diagnostics
-- [d - Go to previous diagnostic
-- ]d - Go to next diagnostic

-- K - Show documentation for cursor
-- <leader>rs - Restart LSP
