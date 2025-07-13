# Complete HTML/CSS Freelancing Setup with Neovim

## Phase 1: Immediate Setup for Freelancing

### 1. Essential Plugins for HTML/CSS Development

Add these to your `lazy.nvim` setup:

```lua
-- lua/plugins/web-dev.lua
return {
  -- HTML/CSS snippets and shortcuts
  {
    "L3MON4D3/LuaSnip",
    dependencies = { "rafamadriz/friendly-snippets" },

    config = function()
      require("luasnip.loaders.from_vscode").lazy_load()
      require("luasnip.loaders.from_lua").lazy_load({ paths = "~/.config/nvim/snippets/" })
    end,
  },

  -- Emmet for rapid HTML/CSS
  {
    "mattn/emmet-vim",
    ft = { "html", "css", "javascript", "javascriptreact", "typescript", "typescriptreact" },
    config = function()
      vim.g.user_emmet_leader_key = '<C-e>'
    end,
  },

  -- Auto close tags
  {
    "windwp/nvim-ts-autotag",
    dependencies = "nvim-treesitter/nvim-treesitter",
    config = function()
      require('nvim-ts-autotag').setup()
    end,
  },

  -- Color preview
  {
    "norcalli/nvim-colorizer.lua",
    config = function()
      require('colorizer').setup()
    end,
  },

  -- Live server
  {
    "barrett-ruth/live-server.nvim",
    build = "npm install -g live-server",
    cmd = { "LiveServerStart", "LiveServerStop" },
    config = true,
  },
}
```

### 2. Custom HTML/CSS Snippets

Create directory: `~/.config/nvim/snippets/`

```lua
-- ~/.config/nvim/snippets/html.lua
local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node

return {
  -- Basic HTML5 template
  s("html5", {
    t({
      "<!DOCTYPE html>",
      "<html lang=\"en\">",
      "<head>",
      "  <meta charset=\"UTF-8\">",
      "  <meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\">",
      "  <title>"
    }),
    i(1, "Document"),

    t({
      "</title>",
      "  <link rel=\"stylesheet\" href=\"style.css\">",
      "</head>",
      "<body>",
      "  "
    }),
    i(2, "<!-- Content here -->"),
    t({
      "",
      "  <script src=\"script.js\"></script>",
      "</body>",
      "</html>"
    })
  }),


  -- Modern CSS reset
  s("cssreset", {
    t({
      "/* Modern CSS Reset */",

      "* {",
      "  margin: 0;",
      "  padding: 0;",
      "  box-sizing: border-box;",
      "}",
      "",

      "body {",
      "  font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif;",
      "  line-height: 1.6;",
      "  color: #333;",
      "}",
      "",
      "img {",
      "  max-width: 100%;",
      "  height: auto;",
      "}",
      "",
      "a {",
      "  text-decoration: none;",
      "  color: inherit;",
      "}",
      "",
      "ul {",
      "  list-style: none;",
      "}"

    })
  }),

  -- Flexbox container
  s("flexbox", {
    t({
      ".container {",
      "  display: flex;",
      "  justify-content: "
    }),
    i(1, "center"),

    t({
      ";",
      "  align-items: "

    }),
    i(2, "center"),
    t({
      ";",
      "  flex-direction: "
    }),
    i(3, "row"),
    t({

      ";",
      "  gap: "
    }),

    i(4, "1rem"),

    t({
      ";",
      "}"
    })
  }),

  -- Grid layout

  s("grid", {
    t({
      ".grid {",
      "  display: grid;",
      "  grid-template-columns: "
    }),

    i(1, "repeat(auto-fit, minmax(250px, 1fr))"),
    t({

      ";",
      "  gap: "
    }),

    i(2, "1rem"),

    t({
      ";",
      "}"
    })
  }),

  -- Responsive breakpoints
  s("breakpoints", {
    t({
      "/* Mobile first approach */",
      "/* Small devices (landscape phones, 576px and up) */",
      "@media (min-width: 576px) {",
      "  "
    }),
    i(1, "/* styles */"),

    t({
      "",
      "}",
      "",
      "/* Medium devices (tablets, 768px and up) */",
      "@media (min-width: 768px) {",
      "  "
    }),
    i(2, "/* styles */"),
    t({
      "",
      "}",
      "",
      "/* Large devices (desktops, 992px and up) */",
      "@media (min-width: 992px) {",
      "  "
    }),
    i(3, "/* styles */"),
    t({
      "",
      "}",
      "",
      "/* Extra large devices (large desktops, 1200px and up) */",

      "@media (min-width: 1200px) {",
      "  "
    }),
    i(4, "/* styles */"),
    t({
      "",
      "}"
    })
  }),
}
```

### 3. Project Templates

Create a project template system:

```bash
# Create templates directory
mkdir -p ~/.config/nvim/templates/web-project

# Basic project structure
mkdir -p ~/.config/nvim/templates/web-project/{css,js,images,assets}
```

### 4. Workflow Automation Scripts

```bash
# ~/.local/bin/new-web-project
#!/bin/bash

project_name="$1"
if [ -z "$project_name" ]; then
    echo "Usage: new-web-project <project-name>"
    exit 1
fi

# Create project directory
mkdir -p "$project_name"/{css,js,images,assets}
cd "$project_name"

# Create basic files
cat > index.html << 'EOF'
<!DOCTYPE html>

<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Project Title</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>
    <header>
        <h1>Welcome to Your Project</h1>
    </header>

    <main>
        <section class="hero">
            <h2>Hero Section</h2>
            <p>Your content here</p>

        </section>
    </main>

    <footer>
        <p>&copy; 2025 Your Name. All rights reserved.</p>
    </footer>

    <script src="js/script.js"></script>
</body>
</html>
EOF

cat > css/style.css << 'EOF'
/* Modern CSS Reset */
* {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
}


body {
    font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif;
    line-height: 1.6;
    color: #333;
}

.hero {
    min-height: 100vh;
    display: flex;
    flex-direction: column;
    justify-content: center;
    align-items: center;

    text-align: center;
    padding: 2rem;
}

/* Mobile First Responsive Design */
@media (min-width: 768px) {
    .hero {

        padding: 4rem;
    }
}

EOF

cat > js/script.js << 'EOF'

// Your JavaScript code here
document.addEventListener('DOMContentLoaded', function() {
    console.log('Page loaded successfully!');
});
EOF

echo "Project '$project_name' created successfully!"
echo "Run 'cd $project_name && nvim .' to start editing"
```

Make it executable:

```bash
chmod +x ~/.local/bin/new-web-project
```

## Phase 2: Enhanced Neovim Configuration

### 1. Improved Keymaps

```lua

-- lua/config/keymaps.lua
vim.g.mapleader = " "
vim.g.maplocalleader = " "


local keymap = vim.keymap
local opts = { noremap = true, silent = true }

-- ===============================
-- BASIC NAVIGATION & EDITING
-- ===============================

-- Better window navigation
keymap.set("n", "<C-h>", "<C-w>h", { desc = "Go to left window" })
keymap.set("n", "<C-j>", "<C-w>j", { desc = "Go to lower window" })
keymap.set("n", "<C-k>", "<C-w>k", { desc = "Go to upper window" })
keymap.set("n", "<C-l>", "<C-w>l", { desc = "Go to right window" })


-- Resize with arrows
keymap.set("n", "<C-Up>", ":resize -2<CR>", opts)
keymap.set("n", "<C-Down>", ":resize +2<CR>", opts)
keymap.set("n", "<C-Left>", ":vertical resize -2<CR>", opts)
keymap.set("n", "<C-Right>", ":vertical resize +2<CR>", opts)

-- Navigate buffers
keymap.set("n", "<S-l>", ":bnext<CR>", opts)
keymap.set("n", "<S-h>", ":bprevious<CR>", opts)

-- File operations

keymap.set("n", "<C-s>", ":w<CR>", { desc = "Save file" })
keymap.set("n", "<C-q>", ":q<CR>", { desc = "Quit" })
keymap.set("n", "<C-S-q>", ":qa!<CR>", { desc = "Force quit all" })

-- Select all

keymap.set("n", "<C-a>", "ggVG", { desc = "Select all" })

-- ===============================
-- MOVEMENT & EDITING
-- ===============================

-- Stay in indent mode

keymap.set("v", "<", "<gv", opts)
keymap.set("v", ">", ">gv", opts)

-- Move text up and down
keymap.set("v", "J", ":m '>+1<CR>gv=gv", opts)
keymap.set("v", "K", ":m '<-2<CR>gv=gv", opts)

-- Better line joining
keymap.set("n", "J", "mzJ`z", { desc = "Join line below" })

-- Center cursor when scrolling
keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Scroll down and center" })
keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Scroll up and center" })

-- Center cursor when searching
keymap.set("n", "n", "nzzzv", { desc = "Next search result" })
keymap.set("n", "N", "Nzzzv", { desc = "Previous search result" })

-- ===============================
-- CLIPBOARD & REGISTERS
-- ===============================

-- Better paste (doesn't overwrite register)
keymap.set("x", "<leader>p", '"_dP', { desc = "Paste without overwriting register" })

-- System clipboard

keymap.set("n", "<leader>y", '"+y', { desc = "Copy to system clipboard" })
keymap.set("v", "<leader>y", '"+y', { desc = "Copy to system clipboard" })

keymap.set("n", "<leader>Y", '"+Y', { desc = "Copy line to system clipboard" })

-- Delete without overwriting register

keymap.set("n", "<leader>d", '"_d', { desc = "Delete without overwriting register" })
keymap.set("v", "<leader>d", '"_d', { desc = "Delete without overwriting register" })

-- ===============================
-- SEARCH & REPLACE
-- ===============================

-- Clear search highlights

keymap.set("n", "<leader>nh", ":nohl<CR>", { desc = "Clear search highlights" })

-- Search and replace current word

keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], { desc = "Replace word under cursor" })

-- Search and replace selected text

keymap.set("v", "<leader>s", [[y:%s/<C-r>"/<C-r>"/gI<Left><Left><Left>]], { desc = "Replace selected text" })

-- ===============================
-- QUICKFIX & LOCATION LIST
-- ===============================

keymap.set("n", "<leader>qo", ":copen<CR>", { desc = "Open quickfix list" })
keymap.set("n", "<leader>qc", ":cclose<CR>", { desc = "Close quickfix list" })
keymap.set("n", "<leader>qn", ":cnext<CR>zz", { desc = "Next quickfix item" })
keymap.set("n", "<leader>qp", ":cprev<CR>zz", { desc = "Previous quickfix item" })

keymap.set("n", "<leader>lo", ":lopen<CR>", { desc = "Open location list" })

keymap.set("n", "<leader>lc", ":lclose<CR>", { desc = "Close location list" })
keymap.set("n", "<leader>ln", ":lnext<CR>zz", { desc = "Next location item" })
keymap.set("n", "<leader>lp", ":lprev<CR>zz", { desc = "Previous location item" })

-- ===============================
-- FILE MANAGEMENT
-- ===============================

-- File explorer
keymap.set("n", "<leader>e", ":Oil<CR>", { desc = "Open file explorer" })
keymap.set("n", "<leader>E", ":Oil .<CR>", { desc = "Open file explorer in current directory" })

-- ===============================
-- PLUGIN MANAGEMENT
-- ===============================


keymap.set("n", "<leader>l", ":Lazy<CR>", { desc = "Open Lazy.nvim" })
keymap.set("n", "<leader>m", ":Mason<CR>", { desc = "Open Mason" })

-- ===============================
-- UTILITIES
-- ===============================

-- Make file executable
keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true, desc = "Make file executable" })

-- Undo tree
keymap.set("n", "<leader>u", ":UndotreeToggle<CR>", { desc = "Toggle undo tree" })


-- Open in browser (for HTML files)

keymap.set("n", "<leader>ob", function()
  local file = vim.fn.expand("%:p")

  local filetype = vim.bo.filetype
  if filetype == "html" then
    if vim.fn.has("wsl") == 1 then
      vim.fn.system('wslview "' .. file .. '"')
    elseif vim.fn.has("mac") == 1 then
      vim.fn.system('open "' .. file .. '"')
    else

      vim.fn.system('xdg-open "' .. file .. '"')
    end
  else
    print("Not an HTML file")
  end
end, { desc = "Open HTML file in browser" })

-- ===============================
-- WEB DEVELOPMENT SPECIFIC

-- ===============================


-- Live server
keymap.set("n", "<leader>ls", ":LiveServerStart<CR>", { desc = "Start live server" })
keymap.set("n", "<leader>lS", ":LiveServerStop<CR>", { desc = "Stop live server" })

-- Quick HTML structure
keymap.set("n", "<leader>h5", "i<html5><Esc>", { desc = "Insert HTML5 template" })
keymap.set("n", "<leader>css", "i<cssreset><Esc>", { desc = "Insert CSS reset" })
keymap.set("n", "<leader>flex", "i<flexbox><Esc>", { desc = "Insert flexbox template" })

keymap.set("n", "<leader>grid", "i<grid><Esc>", { desc = "Insert grid template" })
keymap.set("n", "<leader>bp", "i<breakpoints><Esc>", { desc = "Insert responsive breakpoints" })


-- Toggle color preview
keymap.set("n", "<leader>cp", ":ColorizerToggle<CR>", { desc = "Toggle color preview" })

-- Format code
keymap.set("n", "<leader>f", function()
  vim.lsp.buf.format({ async = true })
end, { desc = "Format code" })

-- ===============================
-- SPLITS & TABS
-- ===============================

-- Split management

keymap.set("n", "<leader>sv", ":vsplit<CR>", { desc = "Split window vertically" })
keymap.set("n", "<leader>sh", ":split<CR>", { desc = "Split window horizontally" })
keymap.set("n", "<leader>se", "<C-w>=", { desc = "Make splits equal size" })
keymap.set("n", "<leader>sx", ":close<CR>", { desc = "Close current split" })


-- Tab management

keymap.set("n", "<leader>to", ":tabnew<CR>", { desc = "Open new tab" })
keymap.set("n", "<leader>tx", ":tabclose<CR>", { desc = "Close current tab" })
keymap.set("n", "<leader>tn", ":tabn<CR>", { desc = "Go to next tab" })
keymap.set("n", "<leader>tp", ":tabp<CR>", { desc = "Go to previous tab" })

-- ===============================
-- TERMINAL
-- ===============================

keymap.set("n", "<leader>tt", ":terminal<CR>", { desc = "Open terminal" })
keymap.set("t", "<Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })
```

### 2. Enhanced Telescope Configuration

```lua
-- lua/plugins/telescope.lua
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

    telescope.setup({
      defaults = {
        path_display = { "truncate" },
        sorting_strategy = "ascending",

        layout_config = {
          horizontal = {
            prompt_position = "top",
            preview_width = 0.55,
            results_width = 0.8,
          },
          vertical = {
            mirror = false,
          },
          width = 0.87,
          height = 0.80,
          preview_cutoff = 120,
        },
        mappings = {
          i = {
            ["<C-k>"] = actions.move_selection_previous,

            ["<C-j>"] = actions.move_selection_next,
            ["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
            ["<C-x>"] = actions.select_horizontal,
            ["<C-v>"] = actions.select_vertical,
            ["<C-t>"] = actions.select_tab,
            ["<C-u>"] = actions.preview_scrolling_up,

            ["<C-d>"] = actions.preview_scrolling_down,
            ["<C-c>"] = actions.close,
          },
          n = {
            ["<esc>"] = actions.close,
            ["<CR>"] = actions.select_default,
            ["<C-x>"] = actions.select_horizontal,
            ["<C-v>"] = actions.select_vertical,
            ["<C-t>"] = actions.select_tab,
            ["<C-u>"] = actions.preview_scrolling_up,
            ["<C-d>"] = actions.preview_scrolling_down,
            ["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
          },
        },

      },
      pickers = {
        find_files = {
          theme = "dropdown",
          previewer = false,
        },
        live_grep = {
          theme = "dropdown",
        },
        buffers = {
          theme = "dropdown",
          previewer = false,
        },
      },
    })

    telescope.load_extension("fzf")


    -- Enhanced keymaps
    local keymap = vim.keymap

    -- File pickers
    keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "Find files" })
    keymap.set("n", "<leader>fr", "<cmd>Telescope oldfiles<cr>", { desc = "Recent files" })
    keymap.set("n", "<leader>fb", "<cmd>Telescope buffers<cr>", { desc = "Find buffers" })
    keymap.set("n", "<leader>fh", "<cmd>Telescope help_tags<cr>", { desc = "Help tags" })

    -- Search
    keymap.set("n", "<leader>fs", "<cmd>Telescope live_grep<cr>", { desc = "Live grep" })
    keymap.set("n", "<leader>fc", "<cmd>Telescope grep_string<cr>", { desc = "Grep string under cursor" })
    keymap.set("n", "<leader>ft", "<cmd>TodoTelescope<cr>", { desc = "Find todos" })

    -- Git
    keymap.set("n", "<leader>gc", "<cmd>Telescope git_commits<cr>", { desc = "Git commits" })
    keymap.set("n", "<leader>gf", "<cmd>Telescope git_files<cr>", { desc = "Git files" })
    keymap.set("n", "<leader>gb", "<cmd>Telescope git_branches<cr>", { desc = "Git branches" })

    -- LSP
    keymap.set("n", "<leader>fd", "<cmd>Telescope diagnostics<cr>", { desc = "Diagnostics" })
    keymap.set("n", "<leader>fk", "<cmd>Telescope keymaps<cr>", { desc = "Keymaps" })
    keymap.set("n", "<leader>fm", "<cmd>Telescope marks<cr>", { desc = "Marks" })
    keymap.set("n", "<leader>fo", "<cmd>Telescope vim_options<cr>", { desc = "Vim options" })

    keymap.set("n", "<leader>fj", "<cmd>Telescope jumplist<cr>", { desc = "Jumplist" })
  end,
}
```

### 3. Enhanced LSP Configuration

```lua
-- lua/plugins/lsp.lua
return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
    { "antosha417/nvim-lsp-file-operations", config = true },
    { "folke/neodev.nvim", opts = {} },
  },
  config = function()
    local lspconfig = require("lspconfig")
    local mason_lspconfig = require("mason-lspconfig")
    local cmp_nvim_lsp = require("cmp_nvim_lsp")

    -- Enhanced LSP UI
    local signs = { Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }
    for type, icon in pairs(signs) do
      local hl = "DiagnosticSign" .. type
      vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
    end


    -- Enhanced diagnostic config
    vim.diagnostic.config({
      virtual_text = {

        prefix = "●",
        source = "if_many",
      },
      signs = true,
      underline = true,
      update_in_insert = false,
      severity_sort = true,
      float = {
        focusable = false,
        style = "minimal",
        border = "rounded",
        source = "always",

        header = "",
        prefix = "",
      },
    })

    -- LSP handlers
    vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(
      vim.lsp.handlers.hover,
      { border = "rounded" }
    )

    vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(
      vim.lsp.handlers.signature_help,
      { border = "rounded" }
    )


    local on_attach = function(client, bufnr)
      local opts = { buffer = bufnr, silent = true }
      local keymap = vim.keymap

      -- LSP keybinds
      keymap.set("n", "gD", vim.lsp.buf.declaration, { desc = "Go to declaration", buffer = bufnr })
      keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<CR>", { desc = "Go to definition", buffer = bufnr })
      keymap.set("n", "gi", "<cmd>Telescope lsp_implementations<CR>", { desc = "Go to implementation", buffer = bufnr })
      keymap.set("n", "gt", "<cmd>Telescope lsp_type_definitions<CR>", { desc = "Go to type definition", buffer = bufnr })
      keymap.set("n", "gr", "<cmd>Telescope lsp_references<CR>", { desc = "Show references", buffer = bufnr })

      keymap.set("n", "K", vim.lsp.buf.hover, { desc = "Show hover documentation", buffer = bufnr })
      keymap.set("n", "<leader>k", vim.lsp.buf.signature_help, { desc = "Show signature help", buffer = bufnr })
      keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { desc = "Rename symbol", buffer = bufnr })
      keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "Code action", buffer = bufnr })
      keymap.set("v", "<leader>ca", vim.lsp.buf.code_action, { desc = "Code action", buffer = bufnr })
      keymap.set("n", "<leader>f", function()
        vim.lsp.buf.format({ async = true })
      end, { desc = "Format buffer", buffer = bufnr })


      -- Diagnostic keybinds
      keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Previous diagnostic", buffer = bufnr })
      keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Next diagnostic", buffer = bufnr })
      keymap.set("n", "<leader>d", vim.diagnostic.open_float, { desc = "Open diagnostic float", buffer = bufnr })
      keymap.set("n", "<leader>D", "<cmd>Telescope diagnostics bufnr=0<CR>", { desc = "Buffer diagnostics", buffer = bufnr })
      keymap.set("n", "<leader>wd", "<cmd>Telescope diagnostics<CR>", { desc = "Workspace diagnostics", buffer = bufnr })

      -- LSP info

      keymap.set("n", "<leader>li", ":LspInfo<CR>", { desc = "LSP Info", buffer = bufnr })
      keymap.set("n", "<leader>lr", ":LspRestart<CR>", { desc = "LSP Restart", buffer = bufnr })
    end

    local capabilities = cmp_nvim_lsp.default_capabilities()

    mason_lspconfig.setup({
      handlers = {
        function(server_name)

          lspconfig[server_name].setup({
            capabilities = capabilities,
            on_attach = on_attach,

          })
        end,


        ["html"] = function()
          lspconfig["html"].setup({
            capabilities = capabilities,
            on_attach = on_attach,
            filetypes = { "html", "templ" },

          })
        end,


        ["cssls"] = function()

          lspconfig["cssls"].setup({
            capabilities = capabilities,
            on_attach = on_attach,
            settings = {
              css = {
                validate = true,
                lint = {
                  unknownAtRules = "ignore",
                },
              },
            },
          })
        end,


        ["tailwindcss"] = function()
          lspconfig["tailwindcss"].setup({
            capabilities = capabilities,
            on_attach = on_attach,
            filetypes = { "html", "css", "javascript", "javascriptreact", "typescript", "typescriptreact" },
          })
        end,

        ["emmet_ls"] = function()
          lspconfig["emmet_ls"].setup({
            capabilities = capabilities,
            on_attach = on_attach,
            filetypes = { "html", "css", "javascript", "javascriptreact", "typescript", "typescriptreact", "sass", "scss", "less" },
          })
        end,

        ["lua_ls"] = function()

          lspconfig["lua_ls"].setup({
            capabilities = capabilities,

            on_attach = on_attach,
            settings = {
              Lua = {
                diagnostics = {

                  globals = { "vim" },
                },
                completion = {
                  callSnippet = "Replace",
                },
                workspace = {
                  library = vim.api.nvim_get_runtime_file("", true),
                  checkThirdParty = false,
                },
                telemetry = {
                  enable = false,
                },
              },
            },
          })
        end,
      },
    })

  end,
}
```

## Phase 3: Freelancing Workflow

### 1. Project Structure Template

```
project-name/
├── index.html
├── css/
│
```
