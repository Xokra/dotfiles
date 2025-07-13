-- Add this to your ~/.config/nvim/lua/zedocean/plugins/init.lua

return {
	{
		dir = vim.fn.stdpath("config") .. "/lua/zedocean/plugins/html-templates.lua",
		name = "html-templates",
		config = function()
			require("zedocean.plugins.html-templates").setup()
		end,
	},
}
