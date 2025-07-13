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
    local keymap = vim.keymap

    -- Enhanced LSP handlers for better UI

    local handlers = {
      ["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
        border = "rounded",
      }),
      ["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
        border = "rounded",
      }),
    }

    -- Enhanced capabilities with snippet support
    local capabilities = cmp_nvim_lsp.default_capabilities()

    capabilities.textDocument.completion.completionItem.snippetSupport = true

    -- LSP attach function with enhanced keymaps
    local function on_attach(client, bufnr)
      local opts = { buffer = bufnr, silent = true }
      
      -- Navigation
      opts.desc = "Show LSP references"
      keymap.set("n", "gR", "<cmd>Telescope lsp_references<CR>", opts)

      
      opts.desc = "Go to declaration"
      keymap.set("n", "gD", vim.lsp.buf.declaration, opts)

      
      opts.desc = "Show LSP definitions"
      keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<CR>", opts)
      
      opts.desc = "Show LSP implementations"
      keymap.set("n", "gi", "<cmd>Telescope lsp_implementations<CR>", opts)

      
      opts.desc = "Show LSP type definitions"
      keymap.set("n", "gt", "<cmd>Telescope lsp_type_definitions<CR>", opts)
      

      -- Code actions
      opts.desc = "See available code actions"
      keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)

      
      opts.desc = "Smart rename"
      keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
      

      -- Diagnostics

      opts.desc = "Show buffer diagnostics"
      keymap.set("n", "<leader>D", "<cmd>Telescope diagnostics bufnr=0<CR>", opts)

      
      opts.desc = "Show line diagnostics"

      keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts)
      

      opts.desc = "Go to previous diagnostic"
      keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)

      
      opts.desc = "Go to next diagnostic"

      keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
      
      -- Documentation

      opts.desc = "Show documentation for what is under cursor"
      keymap.set("n", "K", vim.lsp.buf.hover, opts)
      
      opts.desc = "Show signature help"

      keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, opts)
      
      -- Workspace management
      opts.desc = "Add workspace folder"
      keymap.set("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, opts)
      
      opts.desc = "Remove workspace folder"
      keymap.set("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, opts)
      
      opts.desc = "List workspace folders"
      keymap.set("n", "<leader>wl", function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))

      end, opts)
      
      -- Formatting
      opts.desc = "Format buffer"
      keymap.set("n", "<leader>f", function()
        vim.lsp.buf.format({ async = true })
      end, opts)
      
      -- LSP control
      opts.desc = "Restart LSP"
      keymap.set("n", "<leader>rs", ":LspRestart<CR>", opts)
      
      opts.desc = "Show LSP info"
      keymap.set("n", "<leader>li", ":LspInfo<CR>", opts)
      
      -- Document symbols
      opts.desc = "Document symbols"
      keymap.set("n", "<leader>ds", "<cmd>Telescope lsp_document_symbols<CR>", opts)
      
      opts.desc = "Workspace symbols"
      keymap.set("n", "<leader>ws", "<cmd>Telescope lsp_workspace_symbols<CR>", opts)
      

      -- Highlight references when cursor is on a word
      if client.server_capabilities.documentHighlightProvider then
        local highlight_augroup = vim.api.nvim_create_augroup("LspDocumentHighlight", { clear = false })
        vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
          buffer = bufnr,
          group = highlight_augroup,
