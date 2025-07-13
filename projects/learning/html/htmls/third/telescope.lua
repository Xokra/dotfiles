return {
	"nvim-telescope/telescope.nvim",
	branch = "0.1.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
		"nvim-tree/nvim-web-devicons",
		"folke/todo-comments.nvim",
		-- Optional: more telescope extensions
		-- "nvim-telescope/telescope-ui-select.nvim",
		-- "nvim-telescope/telescope-file-browser.nvim",
	},

	config = function()
		local telescope = require("telescope")
		local actions = require("telescope.actions")

		telescope.setup({
			defaults = {
				path_display = { "smart" },
				file_ignore_patterns = {
					"node_modules",
					".git/",
					".cache",

					"%.o",
					"%.a",
					"%.out",
					"%.class",
					"%.pdf",
					"%.mkv",
					"%.mp4",
					"%.zip",
				},
				mappings = {
					i = {
						["<C-k>"] = actions.move_selection_previous, -- move to prev result

						["<C-j>"] = actions.move_selection_next, -- move to next result
						["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
						["<C-x>"] = actions.select_horizontal, -- open in horizontal split
						["<C-v>"] = actions.select_vertical, -- open in vertical split
						["<C-t>"] = actions.select_tab, -- open in new tab
						["<C-u>"] = actions.preview_scrolling_up,

						["<C-d>"] = actions.preview_scrolling_down,
						["<C-f>"] = actions.to_fuzzy_refine, -- refine search
						-- ["<C-t>"] = trouble_telescope.smart_open_with_trouble,
					},
					n = {

						["<C-k>"] = actions.move_selection_previous,
						["<C-j>"] = actions.move_selection_next,

						["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
						["dd"] = actions.delete_buffer,
						["<C-x>"] = actions.select_horizontal,
						["<C-v>"] = actions.select_vertical,

						["<C-t>"] = actions.select_tab,
					},
				},
				-- Better layout
				layout_strategy = "horizontal",
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
				-- Better sorting
				sorting_strategy = "ascending",

				-- Better previewer
				preview = {
					treesitter = true,
				},
				-- Better border
				borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
			},
			pickers = {
				find_files = {
					theme = "dropdown",
					previewer = false,
					hidden = true,
				},
				live_grep = {
					additional_args = function()
						return { "--hidden" }
					end,
				},
				buffers = {
					theme = "dropdown",
					previewer = false,

					initial_mode = "normal",

					mappings = {
						i = {
							["<C-d>"] = actions.delete_buffer,
						},
						n = {
							["dd"] = actions.delete_buffer,
						},
					},
				},
				colorscheme = {
					enable_preview = true,
				},
				git_files = {
					theme = "dropdown",
					previewer = false,
				},

				help_tags = {
					theme = "ivy",
				},
				keymaps = {
					theme = "dropdown",
				},
			},

			extensions = {

				fzf = {
					fuzzy = true,
					override_generic_sorter = true,
					override_file_sorter = true,
					case_mode = "smart_case",
				},
				-- ui_select = {
				--   require("telescope.themes").get_dropdown({}),
				-- },
				-- file_browser = {
				--   theme = "ivy",
				--   hijack_netrw = true,
				-- },
			},
		})

		-- Load extensions
		telescope.load_extension("fzf")
		-- telescope.load_extension("ui-select")
		-- telescope.load_extension("file_browser")

		-- Set keymaps (these are also in the main keymaps file)
		local keymap = vim.keymap

		-- File finding
		keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<CR>", { desc = "Find files" })
		keymap.set("n", "<leader>fr", "<cmd>Telescope oldfiles<CR>", { desc = "Recent files" })
		keymap.set(
			"n",
			"<leader>fa",
			"<cmd>Telescope find_files follow=true no_ignore=true hidden=true<CR>",
			{ desc = "Find all files" }
		)

		-- Search

		keymap.set("n", "<leader>fs", "<cmd>Telescope live_grep<CR>", { desc = "Live grep" })
		keymap.set("n", "<leader>fc", "<cmd>Telescope grep_string<CR>", { desc = "Find string under cursor" })
		keymap.set(
			"n",
			"<leader>fw",
			"<cmd>Telescope current_buffer_fuzzy_find<CR>",
			{ desc = "Find in current buffer" }
		)

		-- Git
		keymap.set("n", "<leader>fg", "<cmd>Telescope git_files<CR>", { desc = "Git files" })
		keymap.set("n", "<leader>gc", "<cmd>Telescope git_commits<CR>", { desc = "Git commits" })

		keymap.set("n", "<leader>gs", "<cmd>Telescope git_status<CR>", { desc = "Git status" })

		-- Buffers and misc
		keymap.set("n", "<leader>fb", "<cmd>Telescope buffers<CR>", { desc = "Find buffers" })
		keymap.set("n", "<leader>fh", "<cmd>Telescope help_tags<CR>", { desc = "Help tags" })
		keymap.set("n", "<leader>fk", "<cmd>Telescope keymaps<CR>", { desc = "Find keymaps" })

		keymap.set("n", "<leader>fo", "<cmd>Telescope vim_options<CR>", { desc = "Vim options" })
		keymap.set("n", "<leader>ft", "<cmd>TodoTelescope<CR>", { desc = "Find todos" })

		-- LSP related (these work with your lspconfig)
		keymap.set("n", "<leader>fd", "<cmd>Telescope diagnostics<CR>", { desc = "Find diagnostics" })
		keymap.set("n", "<leader>fm", "<cmd>Telescope marks<CR>", { desc = "Find marks" })
		keymap.set("n", "<leader>fj", "<cmd>Telescope jumplist<CR>", { desc = "Find jumplist" })
		keymap.set("n", "<leader>fr", "<cmd>Telescope registers<CR>", { desc = "Find registers" })

		-- Advanced searches

		keymap.set("n", "<leader>f/", "<cmd>Telescope search_history<CR>", { desc = "Search history" })
		keymap.set("n", "<leader>f:", "<cmd>Telescope command_history<CR>", { desc = "Command history" })

		-- File browser extension (if you add it)
		-- keymap.set("n", "<leader>fe", "<cmd>Telescope file_browser<CR>", { desc = "File browser" })
		-- keymap.set("n", "<leader>fE", "<cmd>Telescope file_browser path=%:p:h select_buffer=true<CR>", { desc = "File browser (current file)" })
	end,
}
