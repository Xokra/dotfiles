-- lua/plugins/live-server.lua
return {
	"aurum77/live-server.nvim",

	run = function()
		require("live_server.util").install()
	end,
	cmd = { "LiveServer", "LiveServerStart", "LiveServerStop" },
	config = function()
		local liveserver = require("live_server")
		liveserver.setup({
			port = 8080,
			browser_cmd = "firefox", -- or "google-chrome", "safari", etc.
			quiet = false,

			no_css_inject = false,
			install_path = vim.fn.stdpath("data") .. "/live-server/",
		})

		-- Keybindings
		vim.keymap.set("n", "<leader>ls", ":LiveServerStart<CR>", { desc = "Start Live Server" })
		vim.keymap.set("n", "<leader>le", ":LiveServerStop<CR>", { desc = "Stop Live Server" })
	end,
}
