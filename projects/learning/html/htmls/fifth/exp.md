i was thinking to make my new project(this is my first project, and this is for everything including next projects) to attract customers and do freelance as html&css while i will continue my learning of js, but for now i need money, and as nvim user, i think there will be repetitive task/codes, even from zero, maybe i can make command shortcut for such code, than i can edit them?(what i use right now is nvim, lazygit,tmux,stow for my dotfiles, haven't done any project yet)or what is the better approach?i need you to give me the step by step everything, and i already have lazy.nvim for my lua/plugins/example.luaso i think i want that i can maybe from you different style of axes (simplicity vs richness, classic/traditional vs modern/trendy, informative/functional vs emotional/experiential)that i have many variaties to show to my clients with each of them stands out and better than 99% of other competitors.(glass morphism options is great, what other things that can make me stands out?)

but hold your horses,
and i saw that my files are too big just one chat(as you are limited by just a comment, so my plan is i want you to strategically answer one type of thing that you need to do and next you have to strategically prompt me for a newly chat ai so the ai(other claude.ai) can continue the other than you've already done(tell the ai what you've done in detail, so they can continue your work, and tell them in what part of the work are already finish, and that newly ai should continue the next one thing(so it wouldn't get the text limit per message, so each newly claude.ai should do one thing at a time, while continue check mark the things that have been done. and it also prompt another for the other newly claude.ai. so it can be a chain of responds through different newly claude ai and so on. again the repetitive for the prompt is:

1. understand what the previous claude.ai have done(maybe in steps/part/phase)

2. tell them the whole structure of steps and what steps we are in and done, so the next claude.ai know what step are they in and the only one thing they need to do.

3. make them prompt the same thing for the next claude.ai.  
   again one thing at a newly claude.ai at a time) while understanding all i will give you here(it is the past for the new ai), so we will smartly use the message efficiently in just one full new ai chat(new claude.ai chat) for the next and the next.

also i will ask you to prompt me to the next and like that until everything is finished.

and i like how you use this "local function map(mode, lhs, rhs, opts)
local options = {
noremap = true,
silent = true,
}
if opts then
options = vim.tbl_extend("force", options, opts)

end

vim.keymap.set(mode, lhs, rhs, options)
end"
okay that's all, i will give you my codes now:

"❯ cat ~/.config/nvim/init.lua

require("zedocean.core")
require("zedocean.lazy")
-- Add this to your Neovim config (e.g., init.lua or a separate file like alacritty.lua)

-- Function to sync Alacritty config
local function sync_alacritty_config()
local source = vim.fn.expand("%:p")
local target = "/mnt/c/Users/dixie/AppData/Roaming/Alacritty/alacritty.toml"

-- Check if we're editing the dotfiles version

if string.match(source, "dotfiles.*alacritty.toml") then
vim.fn.system(string.format("cp %s %s", source, target))
vim.notify("Alacritty config synced to Windows!", vim.log.levels.INFO)
elseif string.match(source, "AppData.*Alacritty.\*alacritty.toml") then
local dotfiles_target = vim.fn.expand("~/dotfiles/alacritty/.config/alacritty/alacritty.toml")

    vim.fn.system(string.format("cp %s %s", source, dotfiles_target))
    vim.notify("Alacritty config synced to dotfiles!", vim.log.levels.INFO)

end

end

-- Autocommand to sync on save
vim.api.nvim_create_autocmd({ "BufWritePost" }, {
pattern = { "\*alacritty.toml" },
callback = sync_alacritty_config,
})

-- Keymap to manually sync (useful if you want to force a sync)
vim.keymap.set("n", "<leader>;k", function()
sync_alacritty_config()
end, { desc = "Sync Alacritty Config" })

-- Optional: Keymap to open Alacritty config
vim.keymap.set("n", "<leader>;q", function()
vim.cmd("edit " .. vim.fn.expand("~/dotfiles/alacritty/.config/alacritty/alacritty.toml"))
end, { desc = "Edit Alacritty Config" })

-- -- Add this to your init.lua
-- local function format_js_headings()
-- local bufnr = 0 -- Current buffer
-- local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
-- local new_lines = {}
--
-- local last_non_empty_was_js = false
--
-- for i = 1, #lines do
-- local current_line = lines[i]
--

-- local is_js_heading = current_line:match("^JS%s+")
-- local is_empty = current_line:match("^%s\*$")
--
-- if is_js_heading then
-- -- Starting a new JS section
-- if i > 1 and not last_non_empty_was_js then
-- -- Add exactly 3 blank lines before a new JS heading
-- -- (unless it's the first line or follows another JS heading)
--

-- local empty_count = 0
-- local check_idx = i - 1
--
-- -- Count existing blank lines before this heading
-- while check_idx >= 1 and lines[check_idx]:match("^%s\*$") do
-- empty_count = empty_count + 1
-- check_idx = check_idx - 1
-- end

--
-- -- Clear any existing empty lines we've already added
-- while #new*lines > 0 and new_lines[#new_lines]:match("^%s\*$") do
-- table.remove(new_lines)
-- end
--
-- -- Add exactly 3 blank lines
-- for * = 1, 3 do
-- table.insert(new_lines, "")
-- end

## -- end

-- last_non_empty_was_js = true

-- elseif not is_empty then
-- last_non_empty_was_js = false

## -- end

-- -- Add the current line
-- table.insert(new_lines, current_line)
-- end
--
-- -- Replace buffer content with our adjusted lines
-- vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, new_lines)
-- end
--
-- -- Create an autocommand to run this function before saving .md files
--

## -- vim.api.nvim_create_autocmd("BufWritePre", {

-- pattern = "\*.md",
-- callback = function()
-- format_js_headings()
-- end,
-- })
--

-- -- Create a command to run this function manually if needed
-- vim.api.nvim_create_user_command("FormatJSHeadings", function()
-- format_js_headings()
-- end, {})
--
-- vim.g.format_sync_post_hook = function()
-- if vim.bo.filetype == "markdown" then
-- format_js_headings()
-- vim.cmd("noautocmd write")
-- end
-- end
--
-- vim.api.nvim_create_autocmd("BufWritePost", { -- Note: BufWritePost instead of BufWritePre
--
-- pattern = "\*.md",

-- callback = function()
-- format_js_headings()
-- -- Save again without triggering additional formatting
-- vim.cmd("noautocmd write")
-- end,
-- })

❯ cat ~/.config/nvim/lua/zedocean/core/init.lua

require("zedocean.core.options")
require("zedocean.core.keymaps")
❯ cat ~/.config/nvim/lua/zedocean/core/options.lua

vim.cmd("let g:netrw_liststyle = 3")

-- Session options for auto-session
vim.o.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"

local opt = vim.opt

opt.relativenumber = true
opt.number = true

--tabs & indentation
opt.tabstop = 2 -- 2 spaces for tabs ( prettier default)
opt.shiftwidth = 2 -- 2 spaces for indent width
opt.softtabstop = 2 -- 2

opt.expandtab = true -- expand tab to spaces
opt.autoindent = true

opt.wrap = false

--use undotree
opt.swapfile = false

opt.backup = false
opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
opt.undofile = true

opt.hlsearch = false
opt.incsearch = true

opt.scrolloff = 20
opt.signcolumn = "yes"
opt.isfname:append("@-@")

-- search settings
opt.ignorecase = true -- ignore case when searching
opt.smartcase = true -- if you include mixed case in your search, assumes you want case-sensitive

opt.cursorline = false

opt.termguicolors = true
opt.background = "dark"

-- backspace
opt.backspace = "indent,eol,start" -- allow backspace on indent or

--opt.updatetime = 50
--opt.colorcolumn = "80"

--clipboard
opt.clipboard:append("unnamedplus") -- use system clipboard as default register
-- what happen now?

--split windows
opt.splitright = true -- split vertical window to the right
opt.splitbelow = true -- split horizontal window to the bottom

opt.undofile = true
~
❯ cat ~/.config/nvim/lua/zedocean/core/keymaps.lua

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
keymap.set("x", "<leader>p", '"\_dP')
keymap.set("n", "<leader>p", '"\_dP')
keymap.set("v", "<leader>p", '"\_dP')

keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz")
keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz")
keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz")
keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz")

--change or replace the word you are on to all the same word with it
keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], { desc = "change all the text" })

keymap.set("v", "<leader>s", [[y:%s/<C-r>"/<C-r>"/gI<Left><Left><Left>]], { desc = "Replace selected text" })

--chmod straigt away your file
keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true, desc = "!chmod this file" })

--remove highlight after search
keymap.set("n", "<leader>nh", ":nohl<CR>", { desc = "Clear search highlights" })

--close your current split
keymap.set("n", "<leader>vw", "<cmd>close<CR>", { desc = "Close current split" }) -- close current split

keymap.set("n", "<leader>l", ":Lazy<CR>", { noremap = true, silent = true, desc = "Open Lazy.Nvim" })

keymap.set("n", "`", vim.cmd.UndotreeToggle)

keymap.set("n", "<leader>m", ":Mason<CR>", { desc = "Mason" })

keymap.set("n", "<leader>ob", function()

local file = vim.fn.expand("%:p") -- Get full path of current file
vim.fn.system('wslview "' .. file .. '"')

end, { desc = "Open in Browser" })

-- -- Table Mode keymaps
-- keymap.set("n", "<Leader>tm", ":TableModeToggle<CR>", { desc = "Toggle Table Mode" })
-- keymap.set("n", "<Leader>ta", ":TableModeRealign<CR>", { desc = "Realign Table" })
-- keymap.set("n", "<Leader>tr", ":TableModeInsertRow<CR>", { desc = "Insert Row in Table" })
-- keymap.set("n", "<Leader>td", ":TableModeDeleteRow<CR>", { desc = "Delete Row in Table" })

-- keymap.set("n", "<Leader>tc", ":TableModeInsertColumn<CR>", { desc = "Insert Column in Table" })
-- keymap.set("n", "<Leader>tx", ":TableModeDeleteColumn<CR>", { desc = "Delete Column in Table" })
-- keymap.set("n", "<Leader>te", ":TableModeDisable<CR>", { desc = "Disable Table Mode" })
❯
❯ cat ~/.config/nvim/lua/zedocean/lazy.lua

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
vim.fn.system({
"git",
"clone",
"--filter=blob:none",
"https://github.com/folke/lazy.nvim.git",
"--branch=stable", -- latest stable release
lazypath,
})
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({ { import = "zedocean.plugins" }, { import = "zedocean.plugins.lsp"} }, {
change_detection = {

        notify = false,
    },

})
~

❯ cat ~/.config/nvim/lua/zedocean/plugins/nvim-cmp.lua

return {
"hrsh7th/nvim-cmp",
event = "InsertEnter",
dependencies = {

    "hrsh7th/cmp-buffer", -- source for text in buffer
    "hrsh7th/cmp-path", -- source for file system paths
    {

      "L3MON4D3/LuaSnip",
      -- follow latest release.
      version = "v2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
      -- install jsregexp (optional!).
      build = "make install_jsregexp",
    },
    "saadparwaiz1/cmp_luasnip", -- for autocompletion

    "rafamadriz/friendly-snippets", -- useful snippets
    "onsails/lspkind.nvim", -- vs-code like pictograms

},
config = function()

    local cmp = require("cmp")


    local luasnip = require("luasnip")


    local lspkind = require("lspkind")


    -- loads vscode style snippets from installed plugins (e.g. friendly-snippets)
    require("luasnip.loaders.from_vscode").lazy_load()


    cmp.setup({
      completion = {
        completeopt = "menu,menuone,preview,noselect",
      },
      snippet = { -- configure how nvim-cmp interacts with snippet engine
        expand = function(args)
          luasnip.lsp_expand(args.body)

        end,
      },
      mapping = cmp.mapping.preset.insert({
        ["<C-k>"] = cmp.mapping.select_prev_item(), -- previous suggestion

        ["<C-j>"] = cmp.mapping.select_next_item(), -- next suggestion
        ["<C-b>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),

        ["<C-Space>"] = cmp.mapping.complete(), -- show completion suggestions
        ["<C-e>"] = cmp.mapping.abort(), -- close completion window

        ["<CR>"] = cmp.mapping.confirm({ select = false }),

      }),
      -- sources for autocompletion
      sources = cmp.config.sources({
        { name = "nvim_lsp"},

        { name = "luasnip" }, -- snippets


        { name = "buffer" }, -- text within current buffer
        { name = "path" }, -- file system paths
      }),



      -- configure lspkind for vs-code like pictograms in completion menu
      formatting = {
        format = lspkind.cmp_format({
          maxwidth = 50,
          ellipsis_char = "...",

        }),

      },
    })

end,

}
~
❯
❯ cat ~/.config/nvim/lua/zedocean/plugins/telescope.lua

return {
"nvim-telescope/telescope.nvim",
branch = "0.1.x",
dependencies = {
"nvim-lua/plenary.nvim",
{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
"nvim-tree/nvim-web-devicons",
"folke/todo-comments.nvim",
},
config = function()
local telescope = require("telescope")
local actions = require("telescope.actions")
-- local transform_mod = require("telescope.actions.mt").transform_mod

    --   local trouble = require("trouble")
    --  local trouble_telescope = require("trouble.providers.telescope")

    -- or create your custom action
    --    local custom_actions = transform_mod({
    --      open_trouble_qflist = function(prompt_bufnr)
    --        trouble.toggle("quickfix")
    --      end,

    --    })

    telescope.setup({
      defaults = {
        path_display = { "smart" },
        mappings = {
          i = {
            ["<C-k>"] = actions.move_selection_previous, -- move to prev result
            ["<C-j>"] = actions.move_selection_next, -- move to next result

            ["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist,

            --            ["<C-t>"] = trouble_telescope.smart_open_with_trouble,
          },
        },

      },
    })

    telescope.load_extension("fzf")


    -- set keymaps
    local keymap = vim.keymap -- for conciseness


    keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "Fuzzy find files in cwd" })
    keymap.set("n", "<leader>fr", "<cmd>Telescope oldfiles<cr>", { desc = "Fuzzy find recent files" })

    keymap.set("n", "<leader>fs", "<cmd>Telescope live_grep<cr>", { desc = "Find string in cwd" })
    keymap.set("n", "<leader>fc", "<cmd>Telescope grep_string<cr>", { desc = "Find string under cursor in cwd" })
    keymap.set("n", "<leader>ft", "<cmd>TodoTelescope<cr>", { desc = "Find todos" })

end,

}
~
❯
❯ cat ~/.config/nvim/lua/zedocean/plugins/lsp/lspconfig.lua

return {
"neovim/nvim-lspconfig",
event = { "BufReadPre", "BufNewFile" },
dependencies = {
"hrsh7th/cmp-nvim-lsp",
{ "antosha417/nvim-lsp-file-operations", config = true },
{ "folke/neodev.nvim", opts = {} },
},
config = function()
-- import lspconfig plugin

    local lspconfig = require("lspconfig")

    -- import mason_lspconfig plugin

    local mason_lspconfig = require("mason-lspconfig")

    -- import cmp-nvim-lsp plugin
    local cmp_nvim_lsp = require("cmp_nvim_lsp")

    local keymap = vim.keymap -- for conciseness


    vim.api.nvim_create_autocmd("LspAttach", {
      group = vim.api.nvim_create_augroup("UserLspConfig", {}),
      callback = function(ev)

        -- Buffer local mappings.
        -- See `:help vim.lsp.*` for documentation on any of the below functions
        local opts = { buffer = ev.buf, silent = true }

        -- set keybinds
        opts.desc = "Show LSP references"
        keymap.set("n", "gR", "<cmd>Telescope lsp_references<CR>", opts) -- show definition, references

        opts.desc = "Go to declaration"
        keymap.set("n", "gD", vim.lsp.buf.declaration, opts) -- go to declaration

        opts.desc = "Show LSP definitions"
        keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<CR>", opts) -- show lsp definitions

        opts.desc = "Show LSP implementations"

        keymap.set("n", "gi", "<cmd>Telescope lsp_implementations<CR>", opts) -- show lsp implementations

        opts.desc = "Show LSP type definitions"

        keymap.set("n", "gt", "<cmd>Telescope lsp_type_definitions<CR>", opts) -- show lsp type definitions

        opts.desc = "See available code actions"

        keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts) -- see available code actions, in visual mode will apply to selection


        opts.desc = "Smart rename"
        keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts) -- smart rename


        opts.desc = "Show buffer diagnostics"
        keymap.set("n", "<leader>D", "<cmd>Telescope diagnostics bufnr=0<CR>", opts) -- show  diagnostics for file

        opts.desc = "Show line diagnostics"
        keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts) -- show diagnostics for line

        opts.desc = "Go to previous diagnostic"
        keymap.set("n", "[d", vim.diagnostic.goto_prev, opts) -- jump to previous diagnostic in buffer

        opts.desc = "Go to next diagnostic"

        keymap.set("n", "]d", vim.diagnostic.goto_next, opts) -- jump to next diagnostic in buffer

        opts.desc = "Show documentation for what is under cursor"
        keymap.set("n", "K", vim.lsp.buf.hover, opts) -- show documentation for what is under cursor

        opts.desc = "Restart LSP"
        keymap.set("n", "<leader>rs", ":LspRestart<CR>", opts) -- mapping to restart lsp if necessary
      end,
    })

    -- used to enable autocompletion (assign to every lsp server config)
    local capabilities = cmp_nvim_lsp.default_capabilities()

    -- Change the Diagnostic symbols in the sign column (gutter)

    local signs = { Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }

    for type, icon in pairs(signs) do
      local hl = "DiagnosticSign" .. type
      vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
    end

    -- Setup mason-lspconfig with handlers


    mason_lspconfig.setup({
      handlers = {
        -- default handler for installed servers
        function(server_name)
          lspconfig[server_name].setup({
            capabilities = capabilities,
          })
        end,
        ["svelte"] = function()
          -- configure svelte server
          lspconfig["svelte"].setup({
            capabilities = capabilities,
            on_attach = function(client, bufnr)
              vim.api.nvim_create_autocmd("BufWritePost", {
                pattern = { "*.js", "*.ts" },
                callback = function(ctx)
                  -- Here use ctx.match instead of ctx.file
                  client.notify("$/onDidChangeTsOrJsFile", { uri = ctx.match })
                end,

              })
            end,

          })
        end,


        ["graphql"] = function()
          -- configure graphql language server

          lspconfig["graphql"].setup({
            capabilities = capabilities,

            filetypes = { "graphql", "gql", "svelte", "typescriptreact", "javascriptreact" },
          })
        end,
        ["emmet_ls"] = function()
          -- configure emmet language server
          lspconfig["emmet_ls"].setup({
            capabilities = capabilities,
            filetypes = { "html", "typescriptreact", "javascriptreact", "css", "sass", "scss", "less", "svelte" },
          })
        end,
        ["lua_ls"] = function()
          -- configure lua server (with special settings)
          lspconfig["lua_ls"].setup({

            capabilities = capabilities,
            settings = {
              Lua = {

                -- make the language server recognize "vim" global
                diagnostics = {
                  globals = { "vim" },
                },
                completion = {
                  callSnippet = "Replace",
                },
              },
            },

          })
        end,

      },
    })

end,

}

~
❯"
