-- ~/.config/nvim/lua/zedocean/plugins/html-css-freelance.lua

return {
	{

		"mattn/emmet-vim",
		ft = { "html", "css", "javascript", "typescript", "jsx", "tsx" },
		init = function()
			vim.g.user_emmet_leader_key = "<C-y>"
		end,
	},
	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		config = true,
	},
	{
		"windwp/nvim-ts-autotag",
		ft = { "html", "javascript", "typescript", "javascriptreact", "typescriptreact" },
		config = function()
			require("nvim-ts-autotag").setup()
		end,
	},
	{
		"norcalli/nvim-colorizer.lua",
		ft = { "css", "html", "javascript", "typescript" },

		config = function()
			require("colorizer").setup()
		end,
	},
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		config = function()
			require("nvim-treesitter.configs").setup({
				ensure_installed = { "html", "css", "javascript", "typescript", "tsx", "jsx" },
				highlight = { enable = true },
				indent = { enable = true },
			})
		end,
	},
}
