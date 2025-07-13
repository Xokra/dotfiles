-- =============================================================================
-- KEYMAPS CONFIGURATION - Organized by Category
-- =============================================================================

vim.g.mapleader = " "

-- Helper function for cleaner keymap creation
local function map(mode, lhs, rhs, opts)
	local options = { noremap = true, silent = true }
	if opts then
		options = vim.tbl_extend("force", options, opts)
	end
	vim.keymap.set(mode, lhs, rhs, options)
end

-- =============================================================================
-- GENERAL EDITING & NAVIGATION
-- =============================================================================

-- File operations
-- map("n", "<C-s>", ":w<CR>", { desc = "Save file" })
-- map("n", "<C-q>", ":wq<CR>", { desc = "Save and quit" })
map("n", "<C-q>", "gg<S-v>G", { desc = "Select all" })

-- Navigation improvements
map("n", "<C-d>", "<C-d>zz", { desc = "Half page down (centered)" })

map("n", "<C-u>", "<C-u>zz", { desc = "Half page up (centered)" })
map("n", "n", "nzzzv", { desc = "Next search result (centered)" })
map("n", "N", "Nzzzv", { desc = "Previous search result (centered)" })
map("n", "J", "mzJ`z", { desc = "Join lines (preserve cursor)" })

-- Line movement in visual mode
map("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move selection down" })
map("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move selection up" })

-- Better paste (doesn't overwrite clipboard)
map("x", "<leader>p", '"_dP', { desc = "Paste without overwriting clipboard" })
map("n", "<leader>p", '"_dP', { desc = "Paste without overwriting clipboard" })

map("v", "<leader>p", '"_dP', { desc = "Paste without overwriting clipboard" })

-- =============================================================================

-- SEARCH & REPLACE
-- =============================================================================

-- Clear search highlights

map("n", "<leader>nh", ":nohl<CR>", { desc = "Clear search highlights" })

-- Global search and replace
map("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], { desc = "Replace word under cursor" })
map("v", "<leader>s", [[y:%s/<C-r>"/<C-r>"/gI<Left><Left><Left>]], { desc = "Replace selected text" })

-- =============================================================================
-- QUICKFIX & LOCATION LIST NAVIGATION
-- =============================================================================

-- Quickfix navigation
map("n", "<C-k>", "<cmd>cnext<CR>zz", { desc = "Next quickfix item" })
map("n", "<C-j>", "<cmd>cprev<CR>zz", { desc = "Previous quickfix item" })

-- Location list navigation
map("n", "<leader>k", "<cmd>lnext<CR>zz", { desc = "Next location item" })

map("n", "<leader>j", "<cmd>lprev<CR>zz", { desc = "Previous location item" })

-- =============================================================================
-- WINDOW & SPLIT MANAGEMENT
-- =============================================================================

-- Close current split
map("n", "<leader>vw", "<cmd>close<CR>", { desc = "Close current split" })

-- Split navigation (if not using tmux navigator)
-- map("n", "<C-h>", "<C-w>h", { desc = "Move to left split" })
-- map("n", "<C-j>", "<C-w>j", { desc = "Move to bottom split" })
-- map("n", "<C-k>", "<C-w>k", { desc = "Move to top split" })
-- map("n", "<C-l>", "<C-w>l", { desc = "Move to right split" })

-- Split resizing
-- map("n", "<C-Up>", ":resize +2<CR>", { desc = "Increase window height" })
-- map("n", "<C-Down>", ":resize -2<CR>", { desc = "Decrease window height" })

-- map("n", "<C-Left>", ":vertical resize -2<CR>", { desc = "Decrease window width" })
-- map("n", "<C-Right>", ":vertical resize +2<CR>", { desc = "Increase window width" })

-- =============================================================================
-- FILE MANAGEMENT
-- =============================================================================

-- File explorer
map("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })
map("n", "<leader>pv", vim.cmd.Ex, { desc = "Open file explorer" })

-- Make file executable

map("n", "<leader>x", "<cmd>!chmod +x %<CR>", { desc = "Make file executable" })

-- Open file in browser (WSL)
map("n", "<leader>ob", function()
	local file = vim.fn.expand("%:p")
	vim.fn.system('wslview "' .. file .. '"')
end, { desc = "Open in Browser" })

-- =============================================================================
-- PLUGIN MANAGEMENT

-- =============================================================================

-- Plugin managers
map("n", "<leader>l", ":Lazy<CR>", { desc = "Open Lazy.nvim" })
map("n", "<leader>m", ":Mason<CR>", { desc = "Open Mason" })

-- Undo tree
map("n", "`", vim.cmd.UndotreeToggle, { desc = "Toggle Undo Tree" })

-- =============================================================================

-- TELESCOPE KEYMAPS (Enhanced)
-- =============================================================================

-- File finding
map("n", "<leader>ff", "<cmd>Telescope find_files<CR>", { desc = "Find files" })

map("n", "<leader>fr", "<cmd>Telescope oldfiles<CR>", { desc = "Recent files" })
map(
	"n",
	"<leader>fa",
	"<cmd>Telescope find_files follow=true no_ignore=true hidden=true<CR>",
	{ desc = "Find all files" }
)

-- Search
map("n", "<leader>fs", "<cmd>Telescope live_grep<CR>", { desc = "Live grep" })
map("n", "<leader>fc", "<cmd>Telescope grep_string<CR>", { desc = "Find string under cursor" })

map("n", "<leader>fw", "<cmd>Telescope current_buffer_fuzzy_find<CR>", { desc = "Find in current buffer" })

-- Git
map("n", "<leader>fg", "<cmd>Telescope git_files<CR>", { desc = "Git files" })
map("n", "<leader>gc", "<cmd>Telescope git_commits<CR>", { desc = "Git commits" })
map("n", "<leader>gs", "<cmd>Telescope git_status<CR>", { desc = "Git status" })

-- Misc

map("n", "<leader>ft", "<cmd>TodoTelescope<CR>", { desc = "Find todos" })
map("n", "<leader>fb", "<cmd>Telescope buffers<CR>", { desc = "Find buffers" })
map("n", "<leader>fh", "<cmd>Telescope help_tags<CR>", { desc = "Help tags" })
map("n", "<leader>fk", "<cmd>Telescope keymaps<CR>", { desc = "Find keymaps" })
map("n", "<leader>fo", "<cmd>Telescope vim_options<CR>", { desc = "Vim options" })

-- =============================================================================
-- LSP KEYMAPS (Enhanced - these are set in autocmd)
-- =============================================================================

-- Note: LSP keymaps are set in the LspAttach autocmd in lspconfig.lua
-- Here are additional LSP-related keymaps that aren't buffer-specific

-- Workspace management
-- map("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, { desc = "Add workspace folder" })
-- map("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, { desc = "Remove workspace folder" })

-- map("n", "<leader>wl", function() print(vim.inspect(vim.lsp.buf.list_workspace_folders())) end, { desc = "List workspace folders" })

-- =============================================================================
-- HTML/CSS DEVELOPMENT KEYMAPS
-- =============================================================================

-- Emmet expansion
map("i", "<C-y>,", "<plug>(emmet-expand-abbr)", { desc = "Emmet expand" })
map("n", "<C-y>,", "<plug>(emmet-expand-abbr)", { desc = "Emmet expand" })

-- HTML snippets
map("n", "<leader>h5", "ihtml5<C-k>", { desc = "HTML5 boilerplate" })
map("n", "<leader>hc", "icard<C-k>", { desc = "HTML card component" })
map("n", "<leader>hf", "iform<C-k>", { desc = "HTML form" })
map("n", "<leader>hl", "ilanding<C-k>", { desc = "HTML landing section" })
map("n", "<leader>hn", "inavbar<C-k>", { desc = "HTML navbar" })

-- CSS snippets
map("n", "<leader>cf", "iflex<C-k>", { desc = "CSS flexbox" })

map("n", "<leader>cg", "igrid<C-k>", { desc = "CSS grid" })
map("n", "<leader>cb", "ibtn<C-k>", { desc = "CSS button" })
map("n", "<leader>cc", "icard<C-k>", { desc = "CSS card" })
map("n", "<leader>cr", "iresponsive<C-k>", { desc = "CSS responsive" })
map("n", "<leader>cs", "ireset<C-k>", { desc = "CSS reset" })

-- Live server
map("n", "<leader>ls", ":Bracey<CR>", { desc = "Start live server" })
map("n", "<leader>lx", ":BraceyStop<CR>", { desc = "Stop live server" })
map("n", "<leader>lr", ":BraceyReload<CR>", { desc = "Reload live server" })

-- HTML utilities
map("v", "<leader>wt", 'c<><C-r>"</>', { desc = "Wrap in HTML tags" })
map("n", "<leader>ht", "viw<leader>wt", { desc = "Wrap word in HTML tags" })

-- =============================================================================
-- DEBUGGING KEYMAPS (for future use)
-- =============================================================================

-- Debug adapter protocol

-- map("n", "<leader>db", "<cmd>DapToggleBreakpoint<CR>", { desc = "Toggle breakpoint" })
-- map("n", "<leader>dc", "<cmd>DapContinue<CR>", { desc = "Continue debugging" })

-- map("n", "<leader>di", "<cmd>DapStepInto<CR>", { desc = "Step into" })
-- map("n", "<leader>do", "<cmd>DapStepOver<CR>", { desc = "Step over" })

-- map("n", "<leader>dO", "<cmd>DapStepOut<CR>", { desc = "Step out" })
-- map("n", "<leader>dr", "<cmd>DapRepl<CR>", { desc = "Open REPL" })

-- =============================================================================
-- GIT KEYMAPS (for future use with fugitive or similar)
-- =============================================================================

-- Git operations
-- map("n", "<leader>gg", ":LazyGit<CR>", { desc = "Open LazyGit" })
-- map("n", "<leader>gb", ":Git blame<CR>", { desc = "Git blame" })
-- map("n", "<leader>gd", ":Git diff<CR>", { desc = "Git diff" })
-- map("n", "<leader>gl", ":Git log<CR>", { desc = "Git log" })

-- =============================================================================
-- TMUX INTEGRATION (if using tmux)
-- =============================================================================

-- Tmux navigation (if using christoomey/vim-tmux-navigator)
-- map("n", "<C-h>", "<cmd>TmuxNavigateLeft<CR>", { desc = "Navigate left" })
-- map("n", "<C-j>", "<cmd>TmuxNavigateDown<CR>", { desc = "Navigate down" })
-- map("n", "<C-k>", "<cmd>TmuxNavigateUp<CR>", { desc = "Navigate up" })
-- map("n", "<C-l>", "<cmd>TmuxNavigateRight<CR>", { desc = "Navigate right" })

-- =============================================================================
-- TABLE MODE KEYMAPS (currently commented out)
-- =============================================================================

-- Table operations
-- map("n", "<Leader>tm", ":TableModeToggle<CR>", { desc = "Toggle Table Mode" })
-- map("n", "<Leader>ta", ":TableModeRealign<CR>", { desc = "Realign Table" })
-- map("n", "<Leader>tr", ":TableModeInsertRow<CR>", { desc = "Insert Row in Table" })
-- map("n", "<Leader>td", ":TableModeDeleteRow<CR>", { desc = "Delete Row in Table" })
-- map("n", "<Leader>tc", ":TableModeInsertColumn<CR>", { desc = "Insert Column in Table" })

-- map("n", "<Leader>tx", ":TableModeDeleteColumn<CR>", { desc = "Delete Column in Table" })
-- map("n", "<Leader>te", ":TableModeDisable<CR>", { desc = "Disable Table Mode" })

-- =============================================================================

-- BUFFER MANAGEMENT
-- =============================================================================

-- Buffer navigation
-- map("n", "<leader>bn", ":bnext<CR>", { desc = "Next buffer" })
-- map("n", "<leader>bp", ":bprevious<CR>", { desc = "Previous buffer" })
-- map("n", "<leader>bd", ":bdelete<CR>", { desc = "Delete buffer" })
-- map("n", "<leader>bD", ":bdelete!<CR>", { desc = "Force delete buffer" })

-- =============================================================================
-- TERMINAL KEYMAPS
-- =============================================================================

-- Terminal toggle
-- map("n", "<leader>tt", ":ToggleTerm<CR>", { desc = "Toggle terminal" })

-- map("t", "<Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

-- =============================================================================
-- MARKDOWN KEYMAPS (for future use)
-- =============================================================================

-- Markdown preview
-- map("n", "<leader>mp", ":MarkdownPreview<CR>", { desc = "Markdown preview" })
-- map("n", "<leader>ms", ":MarkdownPreviewStop<CR>", { desc = "Stop markdown preview" })

-- =============================================================================
-- SNIPPET KEYMAPS (for LuaSnip)
-- =============================================================================

-- Snippet navigation (these are set in the plugin config)
-- map({"i", "s"}, "<C-k>", function() require("luasnip").expand() end, { desc = "Expand snippet" })
-- map({"i", "s"}, "<C-l>", function() require("luasnip").jump(1) end, { desc = "Jump to next snippet placeholder" })

-- map({"i", "s"}, "<C-h>", function() require("luasnip").jump(-1) end, { desc = "Jump to previous snippet placeholder" })

-- =============================================================================
-- CUSTOM UTILITY KEYMAPS
-- =============================================================================

-- Toggle line numbers
-- map("n", "<leader>tn", function()
--   if vim.wo.number then
--     vim.wo.number = false
--     vim.wo.relativenumber = false

--   else
--     vim.wo.number = true
--     vim.wo.relativenumber = true

--   end
-- end, { desc = "Toggle line numbers" })

-- Toggle word wrap
-- map("n", "<leader>tw", function()
--   vim.wo.wrap = not vim.wo.wrap
-- end, { desc = "Toggle word wrap" })

-- Quick source current file
-- map("n", "<leader><leader>", function()
--   vim.cmd("so")
-- end, { desc = "Source current file" })

-- =============================================================================
-- NOTES:
-- =============================================================================
-- 1. Commented keymaps are suggestions for future plugins or features
-- 2. Some keymaps might conflict with plugins - uncomment carefully
-- 3. The HTML/CSS keymaps require the web-dev plugin configuration
-- 4. LSP keymaps are set in the LspAttach autocmd in your lspconfig.lua
-- 5. Consider your tmux setup when uncommenting navigation keymaps
-- =============================================================================
