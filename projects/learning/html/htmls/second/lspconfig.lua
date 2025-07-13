return {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		"hrsh7th/cmp-nvim-lsp",
		{ "antosha417/nvim-lsp-file-operations", config = true },
		{ "folke/neodev.nvim", opts = {} },
	},
	config = function()
		-- Import lspconfig plugin
		local lspconfig = require("lspconfig")
		local mason_lspconfig = require("mason-lspconfig")
		local cmp_nvim_lsp = require("cmp_nvim_lsp")

		local keymap = vim.keymap

		-- LSP attach autocmd with organized keymaps
		vim.api.nvim_create_autocmd("LspAttach", {
			group = vim.api.nvim_create_augroup("UserLspConfig", {}),
			callback = function(ev)
				-- Buffer local mappings

				local opts = { buffer = ev.buf, silent = true }

				-- ================================
				-- NAVIGATION & REFERENCES
				-- ================================

				-- Go to definition/declaration
				keymap.set(
					"n",
					"gd",
					"<cmd>Telescope lsp_definitions<CR>",
					vim.tbl_extend("force", opts, { desc = "Go to definition" })
				)
				keymap.set(
					"n",
					"gD",
					vim.lsp.buf.declaration,
					vim.tbl_extend("force", opts, { desc = "Go to declaration" })
				)

				-- References and implementations
				keymap.set(
					"n",
					"gR",
					"<cmd>Telescope lsp_references<CR>",
					vim.tbl_extend("force", opts, { desc = "Show references" })
				)
				keymap.set(
					"n",
					"gi",
					"<cmd>Telescope lsp_implementations<CR>",
					vim.tbl_extend("force", opts, { desc = "Show implementations" })
				)
				keymap.set(
					"n",
					"gt",
					"<cmd>Telescope lsp_type_definitions<CR>",
					vim.tbl_extend("force", opts, { desc = "Show type definitions" })
				)

				-- ================================

				-- DOCUMENTATION & HOVER
				-- ================================

				keymap.set("n", "K", vim.lsp.buf.hover, vim.tbl_extend(
					"force",
					opts,
					{ desc = "Show hover documentation" }
				))
				keymap.set(
					"n",
					"<C-k>",
					vim.lsp.buf.signature_help,
					vim.tbl_extend("force", opts, { desc = "Show signature help" })
				)

				-- ================================
				-- CODE ACTIONS & REFACTORING
				-- ================================

				keymap.set(
					{ "n", "v" },
					"<leader>ca",
					vim.lsp.buf.code_action,
					vim.tbl_extend("force", opts, { desc = "Show code actions" })
				)
				keymap.set("n", "<leader>rn", vim.lsp.buf.rename, vim.tbl_extend(
					"force",
					opts,
					{ desc = "Smart rename" }
				))

				-- Format code
				keymap.set("n", "<leader>fm", function()
					vim.lsp.buf.format({ async = true })
				end, vim.tbl_extend("force", opts, { desc = "Format buffer" }))

				-- ================================
				-- DIAGNOSTICS
				-- ================================

				-- Show diagnostics
				keymap.set(
					"n",
					"<leader>d",
					vim.diagnostic.open_float,
					vim.tbl_extend("force", opts, { desc = "Show line diagnostics" })
				)
				keymap.set(
					"n",
					"<leader>D",
					"<cmd>Telescope diagnostics bufnr=0<CR>",
					vim.tbl_extend("force", opts, { desc = "Show buffer diagnostics" })
				)

				-- Navigate diagnostics
				keymap.set(
					"n",
					"[d",
					vim.diagnostic.goto_prev,
					vim.tbl_extend("force", opts, { desc = "Go to previous diagnostic" })
				)
				keymap.set(
					"n",
					"]d",
					vim.diagnostic.goto_next,
					vim.tbl_extend("force", opts, { desc = "Go to next diagnostic" })
				)

				-- Set diagnostic severity
				keymap.set("n", "<leader>de", function()
					vim.diagnostic.goto_next({ severity = vim.diagnostic.severity.ERROR })
				end, vim.tbl_extend("force", opts, { desc = "Go to next error" }))

				keymap.set("n", "<leader>dw", function()
					vim.diagnostic.goto_next({ severity = vim.diagnostic.severity.WARN })
				end, vim.tbl_extend("force", opts, { desc = "Go to next warning" }))

				-- ================================
				-- WORKSPACE MANAGEMENT
				-- ================================

				keymap.set(
					"n",
					"<leader>wa",
					vim.lsp.buf.add_workspace_folder,
					vim.tbl_extend("force", opts, { desc = "Add workspace folder" })
				)
				keymap.set(
					"n",
					"<leader>wr",
					vim.lsp.buf.remove_workspace_folder,
					vim.tbl_extend("force", opts, { desc = "Remove workspace folder" })
				)
				keymap.set("n", "<leader>wl", function()
					print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
				end, vim.tbl_extend("force", opts, { desc = "List workspace folders" }))

				-- ================================
				-- LSP UTILITY
				-- ================================

				keymap.set(
					"n",
					"<leader>rs",
					":LspRestart<CR>",
					vim.tbl_extend("force", opts, { desc = "Restart LSP" })
				)
				keymap.set("n", "<leader>li", ":LspInfo<CR>", vim.tbl_extend("force", opts, { desc = "LSP Info" }))
			end,
		})

		-- Enhanced autocompletion capabilities

		local capabilities = cmp_nvim_lsp.default_capabilities()

		-- Add additional capabilities for better experience
		capabilities.textDocument.completion.completionItem.snippetSupport = true
		capabilities.textDocument.completion.completionItem.resolveSupport = {
			properties = {
				"documentation",

				"detail",
				"additionalTextEdits",
			},
		}

		-- Enhanced diagnostic signs with better icons
		local signs = {
			Error = " ",
			Warn = " ",
			Hint = "󰠠 ",
			Info = " ",
		}

		for type, icon in pairs(signs) do
			local hl = "DiagnosticSign" .. type
			vim.fn.sign_define(hl, {
				text = icon,
				texthl = hl,
				numhl = "",
			})
		end

		-- Configure diagnostic display
		vim.diagnostic.config({
			virtual_text = {
				prefix = "●",
				source = "if_many",
			},
			float = {

				source = "always",
				border = "rounded",
			},
			signs = true,
			underline = true,
			update_in_insert = false,
			severity_sort = true,
		})

		-- Setup mason-lspconfig with enhanced handlers
		mason_lspconfig.setup({
			handlers = {
				-- Default handler for all servers

				function(server_name)
					lspconfig[server_name].setup({
						capabilities = capabilities,
					})
				end,

				-- ================================
				-- WEB DEVELOPMENT SERVERS
				-- ================================

				["html"] = function()
					lspconfig["html"].setup({
						capabilities = capabilities,
						settings = {
							html = {
								format = {
									templating = true,
									wrapLineLength = 120,

									wrapAttributes = "auto",
								},
								hover = {
									documentation = true,
									references = true,
								},
							},
						},
					})
				end,

				["cssls"] = function()
					lspconfig["cssls"].setup({
						capabilities = capabilities,
						settings = {
							css = {
								validate = true,
								lint = {

									unknownAtRules = "ignore",
								},
							},
							scss = {
								validate = true,
								lint = {
									unknownAtRules = "ignore",
								},
							},
							less = {
								validate = true,

								lint = {
									unknownAtRules = "ignore",
								},
							},
						},
					})
				end,

				["emmet_ls"] = function()
					lspconfig["emmet_ls"].setup({
						capabilities = capabilities,
						filetypes = {
							"html",
							"typescriptreact",

							"javascriptreact",
							"css",

							"sass",
							"scss",
							"less",
							"svelte",
							"vue",
							"astro",
						},
						init_options = {
							html = {
								options = {
									-- For possible options, see: https://github.com/emmetio/emmet/blob/master/src/config.ts#L79-L267

									["bem.enabled"] = true,
								},
							},
						},
					})
				end,

				["tailwindcss"] = function()
					lspconfig["tailwindcss"].setup({
						capabilities = capabilities,
						settings = {

							tailwindCSS = {
								experimental = {

									classRegex = {
										"tw`([^`]*)",
										'tw="([^"]*)',
										'tw={"([^"}]*)',
										"tw\\.\\w+`([^`]*)",
										"tw\\(.*?\\)`([^`]*)",
									},
								},
							},
						},
					})
				end,

				-- ================================
				-- JAVASCRIPT/TYPESCRIPT SERVERS
				-- ================================

				["tsserver"] = function()
					lspconfig["tsserver"].setup({
						capabilities = capabilities,
						settings = {
							typescript = {
								inlayHints = {
									includeInlayParameterNameHints = "all",
									includeInlayParameterNameHintsWhenArgumentMatchesName = false,
									includeInlayFunctionParameterTypeHints = true,
									includeInlayVariableTypeHints = true,
									includeInlayPropertyDeclarationTypeHints = true,
									includeInlayFunctionLikeReturnTypeHints = true,
									includeInlayEnumMemberValueHints = true,
								},
							},
							javascript = {
								inlayHints = {
									includeInlayParameterNameHints = "all",
									includeInlayParameterNameHintsWhenArgumentMatchesName = false,
									includeInlayFunctionParameterTypeHints = true,
									includeInlayVariableTypeHints = true,
									includeInlayPropertyDeclarationTypeHints = true,
									includeInlayFunctionLikeReturnTypeHints = true,
									includeInlayEnumMemberValueHints = true,
								},
							},
						},
					})
				end,

				["eslint"] = function()
					lspconfig["eslint"].setup({
						capabilities = capabilities,
						settings = {
							codeAction = {
								disableRuleComment = {
									enable = true,
									location = "separateLine",
								},
								showDocumentation = {
									enable = true,
								},
							},
							codeActionOnSave = {
								enable = false,

								mode = "all",
							},
							experimental = {
								useFlatConfig = false,
							},
							format = true,
							nodePath = "",
							onIgnoredFiles = "off",
							problems = {
								shortenToSingleLine = false,
							},
							quiet = false,
							rulesCustomizations = {},
							run = "onType",
							useESLintClass = false,

							validate = "on",
							workingDirectory = {
								mode = "location",
							},
						},
					})
				end,

				-- ================================
				-- FRAMEWORK SPECIFIC SERVERS
				-- ================================

				["svelte"] = function()
					lspconfig["svelte"].setup({

						capabilities = capabilities,
						on_attach = function(client, bufnr)
							vim.api.nvim_create_autocmd("BufWritePost", {
								pattern = { "*.js", "*.ts" },
								callback = function(ctx)
									client.notify("$/onDidChangeTsOrJsFile", { uri = ctx.match })
								end,
							})
						end,
					})
				end,

				["astro"] = function()
					lspconfig["astro"].setup({
						capabilities = capabilities,
						init_options = {
							configuration = {},
						},
					})
				end,

				["graphql"] = function()
					lspconfig["graphql"].setup({

						capabilities = capabilities,
						filetypes = {
							"graphql",
							"gql",
							"svelte",
							"typescriptreact",
							"javascriptreact",
						},
					})
				end,

				-- ================================
				-- UTILITY SERVERS
				-- ================================

				["lua_ls"] = function()
					lspconfig["lua_ls"].setup({
						capabilities = capabilities,
						settings = {
							Lua = {
								diagnostics = {

									globals = { "vim" },
								},
								completion = {
									callSnippet = "Replace",
								},
								workspace = {
									library = {
										[vim.fn.expand("$VIMRUNTIME/lua")] = true,
										[vim.fn.stdpath("config") .. "/lua"] = true,
									},
								},
								telemetry = {
									enable = false,
								},
							},
						},
					})
				end,

				["jsonls"] = function()
					lspconfig["jsonls"].setup({
						capabilities = capabilities,
						settings = {
							json = {
								schemas = require("schemastore").json.schemas(),
								validate = { enable = true },
							},
						},
					})
				end,

				["yamlls"] = function()
					lspconfig["yamlls"].setup({
						capabilities = capabilities,
						settings = {
							yaml = {
								schemas = require("schemastore").yaml.schemas(),

								validate = true,
								completion = true,
								hover = true,
							},
						},
					})
				end,
			},
		})

		-- ================================
		-- ADDITIONAL LSP ENHANCEMENTS

		-- ================================

		-- Auto-format on save for specific filetypes
		vim.api.nvim_create_autocmd("BufWritePre", {
			pattern = { "*.ts", "*.tsx", "*.js", "*.jsx", "*.json", "*.css", "*.scss", "*.html" },
			callback = function()
				if vim.lsp.buf.format then
					vim.lsp.buf.format({ async = false })
				end
			end,
		})

		-- Show line diagnostics automatically in hover window
		vim.api.nvim_create_autocmd("CursorHold", {
			callback = function()
				local opts = {
					focusable = false,
					close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
					border = "rounded",
					source = "always",
					prefix = " ",
					scope = "cursor",
				}
				vim.diagnostic.open_float(nil, opts)
			end,
		})

		-- Highlight symbol under cursor
		vim.api.nvim_create_autocmd("CursorHold", {
			callback = function()
				local clients = vim.lsp.get_active_clients()
				if next(clients) == nil then
					return
				end

				for _, client in pairs(clients) do
					if client.server_capabilities.documentHighlightProvider then
						vim.lsp.buf.document_highlight()
						break
					end
				end
			end,
		})

		vim.api.nvim_create_autocmd("CursorMoved", {
			callback = function()
				vim.lsp.buf.clear_references()
			end,
		})
	end,
}
