vim.g.mapleader = " "

local function map(mode, lhs, rhs, opts)
  local options = {
    noremap = true,

    silent = true,
  }
  if opts then
    options = vim.tbl_extend("force", options, opts)
  end
  vim.keymap.set(mode, lhs, rhs, options)
end

-- =============================================================================
-- GENERAL KEYMAPS
-- =============================================================================

-- File Operations
map("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })
map("n", "<leader>pv", vim.cmd.Ex, { desc = "Open netrw file explorer" })

-- Select All
map("n", "<C-q>", "gg<S-v>G", { desc = "Select all" })

-- =============================================================================

-- TEXT MANIPULATION
-- =============================================================================

-- Move lines up/down in visual mode
map("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move selection down" })

map("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move selection up" })

-- Better line joining
map("n", "J", "mzJ`z", { desc = "Join line below without moving cursor" })

-- Better scrolling
map("n", "<C-d>", "<C-d>zz", { desc = "Scroll down and center" })
map("n", "<C-u>", "<C-u>zz", { desc = "Scroll up and center" })

-- Better search navigation
map("n", "n", "nzzzv", { desc = "Next search result and center" })
map("n", "N", "Nzzzv", { desc = "Previous search result and center" })

-- =============================================================================
-- PASTE/DELETE OPERATIONS
-- =============================================================================

-- Paste without overwriting register
map("x", "<leader>p", '"_dP', { desc = "Paste without overwriting register" })
map("n", "<leader>p", '"_dP', { desc = "Paste without overwriting register" })
map("v", "<leader>p", '"_dP', { desc = "Paste without overwriting register" })

-- =============================================================================
-- QUICKFIX/LOCATION LIST NAVIGATION

-- =============================================================================

map("n", "<C-k>", "<cmd>cnext<CR>zz", { desc = "Next quickfix item" })
map("n", "<C-j>", "<cmd>cprev<CR>zz", { desc = "Previous quickfix item" })

map("n", "<leader>k", "<cmd>lnext<CR>zz", { desc = "Next location list item" })
map("n", "<leader>j", "<cmd>lprev<CR>zz", { desc = "Previous location list item" })

-- =============================================================================

-- SEARCH AND REPLACE

-- =============================================================================

-- Replace word under cursor
map(
  "n",
  "<leader>s",
  [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]],
  { desc = "Replace word under cursor globally" }
)

-- Replace selected text
map("v", "<leader>s", [[y:%s/<C-r>"/<C-r>"/gI<Left><Left><Left>]], { desc = "Replace selected text globally" })

-- Clear search highlights
map("n", "<leader>nh", ":nohl<CR>", { desc = "Clear search highlights" })

-- =============================================================================
-- FILE OPERATIONS
-- =============================================================================

-- Open Lazygit
-- map(
--   "n",
--   "<leader>g",
--   ":belowright split | terminal lazygit<CR>",
--   { noremap = true, silent = false, desc = "Open Lazygit" }
-- )

-- Make file executable
map("n", "<leader>x", "<cmd>!chmod +x %<CR>", { desc = "Make current file executable" })

-- Open file in browser (WSL)
map("n", "<leader>ob", function()
  local file = vim.fn.expand("%:p")

  vim.fn.system('wslview "' .. file .. '"')
end, { desc = "Open current file in browser" })

-- =============================================================================

-- WINDOW/SPLIT MANAGEMENT
-- =============================================================================

-- Close current split
map("n", "<leader>vw", "<cmd>close<CR>", { desc = "Close current split" })

-- =============================================================================
-- PLUGIN MANAGEMENT
-- =============================================================================

-- Open Lazy package manager

map("n", "<leader>l", ":Lazy<CR>", { desc = "Open Lazy package manager" })

-- Open Mason LSP manager
map("n", "<leader>m", ":Mason<CR>", { desc = "Open Mason LSP manager" })

-- Toggle Undotree
map("n", "`", vim.cmd.UndotreeToggle, { desc = "Toggle Undotree" })

-- =============================================================================
-- TELESCOPE KEYMAPS
-- =============================================================================

-- File finding
-- map("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "Find files in current directory" })
-- map("n", "<leader>fr", "<cmd>Telescope oldfiles<cr>", { desc = "Find recent files" })
--
-- -- Text searching
--
-- map("n", "<leader>fs", "<cmd>Telescope live_grep<cr>", { desc = "Find string in current directory" })
-- map("n", "<leader>fc", "<cmd>Telescope grep_string<cr>", { desc = "Find string under cursor" })
--
-- -- Todo finding
-- map("n", "<leader>ft", "<cmd>TodoTelescope<cr>", { desc = "Find todos" })

-- =============================================================================
-- LSP KEYMAPS (Applied on LspAttach)

-- =============================================================================

-- Note: These are set in an autocmd when LSP attaches to buffer
-- They are defined in the lspconfig.lua file but organized here for reference

-- Navigation
-- map("n", "gR", "<cmd>Telescope lsp_references<CR>", { desc = "Show LSP references" })
-- map("n", "gD", vim.lsp.buf.declaration, { desc = "Go to declaration" })
-- map("n", "gd", "<cmd>Telescope lsp_definitions<CR>", { desc = "Show LSP definitions" })
-- map("n", "gi", "<cmd>Telescope lsp_implementations<CR>", { desc = "Show LSP implementations" })
-- map("n", "gt", "<cmd>Telescope lsp_type_definitions<CR>", { desc = "Show LSP type definitions" })

-- Code Actions
-- map({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, { desc = "See available code actions" })
-- map("n", "<leader>rn", vim.lsp.buf.rename, { desc = "Smart rename" })

-- Diagnostics
-- map("n", "<leader>D", "<cmd>Telescope diagnostics bufnr=0<CR>", { desc = "Show buffer diagnostics" })
-- map("n", "<leader>d", vim.diagnostic.open_float, { desc = "Show line diagnostics" })
-- map("n", "[d", vim.diagnostic.goto_prev, { desc = "Go to previous diagnostic" })
-- map("n", "]d", vim.diagnostic.goto_next, { desc = "Go to next diagnostic" })

-- Documentation
-- map("n", "K", vim.lsp.buf.hover, { desc = "Show documentation for cursor item" })

-- LSP Management
--
-- map("n", "<leader>rs", ":LspRestart<CR>", { desc = "Restart LSP" })
