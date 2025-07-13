-- Add this to your ~/.config/nvim/lua/zedocean/core/keymaps.lua

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

-- HTML/CSS Freelance Shortcuts
local freelance_group = vim.api.nvim_create_augroup("FreelanceWorkflow", { clear = true })

-- Quick HTML Boilerplate
map("n", "<leader>hb", function()
	local lines = {
		"<!DOCTYPE html>",
		'<html lang="en">',
		"<head>",

		'    <meta charset="UTF-8">',
		'    <meta name="viewport" content="width=device-width, initial-scale=1.0">',
		"    <title>Document</title>",
		'    <link rel="stylesheet" href="styles.css">',
		"</head>",
		"<body>",
		"    ",
		"</body>",
		"</html>",
	}
	vim.api.nvim_put(lines, "l", true, true)
	vim.api.nvim_feedkeys("9j", "n", false) -- Move to body content
end, { desc = "HTML Boilerplate" })

-- CSS Reset/Normalize
map("n", "<leader>cr", function()
	local lines = {

		"* {",
		"    margin: 0;",
		"    padding: 0;",

		"    box-sizing: border-box;",

		"}",
		"",
		"body {",
		"    font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif;",
		"    line-height: 1.6;",
		"    color: #333;",
		"}",
		"",
		"img {",
		"    max-width: 100%;",
		"    height: auto;",
		"}",
	}
	vim.api.nvim_put(lines, "l", true, true)
end, { desc = "CSS Reset" })

-- Flexbox Center

map("n", "<leader>fc", function()
	local lines = {
		"display: flex;",
		"justify-content: center;",
		"align-items: center;",
	}
	vim.api.nvim_put(lines, "l", true, true)
end, { desc = "Flexbox Center" })

-- Grid Layout
map("n", "<leader>gl", function()
	local lines = {
		"display: grid;",
		"grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));",
		"gap: 2rem;",
	}
	vim.api.nvim_put(lines, "l", true, true)
end, { desc = "Grid Layout" })

-- Glassmorphism Effect
map("n", "<leader>gm", function()
	local lines = {
		"background: rgba(255, 255, 255, 0.1);",
		"backdrop-filter: blur(10px);",
		"border-radius: 10px;",
		"border: 1px solid rgba(255, 255, 255, 0.2);",

		"box-shadow: 0 8px 32px rgba(0, 0, 0, 0.1);",
	}
	vim.api.nvim_put(lines, "l", true, true)
end, { desc = "Glassmorphism" })

-- Smooth Transitions
map("n", "<leader>tr", function()
	local lines = {
		"transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);",
	}

	vim.api.nvim_put(lines, "l", true, true)
end, { desc = "Smooth Transition" })

-- Hover Effects Template
map("n", "<leader>hv", function()
	local lines = {
		".hover-effect {",

		"    transform: translateY(0);",
		"    transition: transform 0.3s ease;",
		"}",
		"",

		".hover-effect:hover {",
		"    transform: translateY(-5px);",
		"}",
	}
	vim.api.nvim_put(lines, "l", true, true)
end, { desc = "Hover Effect" })

-- Responsive Breakpoints
map("n", "<leader>bp", function()
	local lines = {
		"/* Mobile */",

		"@media (max-width: 768px) {",
		"    ",
		"}",
		"",
		"/* Tablet */",
		"@media (min-width: 769px) and (max-width: 1024px) {",

		"    ",

		"}",
		"",
		"/* Desktop */",
		"@media (min-width: 1025px) {",
		"    ",
		"}",
	}
	vim.api.nvim_put(lines, "l", true, true)
end, { desc = "Responsive Breakpoints" })

-- Quick Project Structure
map("n", "<leader>ps", function()
	local project_name = vim.fn.input("Project name: ")
	if project_name ~= "" then
		vim.fn.system("mkdir -p " .. project_name .. "/{css,js,images}")
		vim.fn.system("touch " .. project_name .. "/index.html")
		vim.fn.system("touch " .. project_name .. "/css/styles.css")
		vim.fn.system("touch " .. project_name .. "/js/main.js")
		vim.notify("Project structure created for: " .. project_name)
	end
end, { desc = "Project Structure" })

-- Live Server (if you have it globally installed)
map("n", "<leader>ls", function()
	vim.fn.system("live-server . &")

	vim.notify("Live server started!")
end, { desc = "Start Live Server" })

-- Color Palette Generator
map("n", "<leader>cp", function()
	local colors = {
		"/* Color Palette */",
		":root {",
		"    --primary: #3b82f6;",
		"    --secondary: #8b5cf6;",
		"    --accent: #06b6d4;",
		"    --neutral: #6b7280;",
		"    --base-100: #ffffff;",
		"    --base-200: #f8fafc;",
		"    --base-300: #e2e8f0;",
		"}",
	}
	vim.api.nvim_put(colors, "l", true, true)
end, { desc = "Color Palette" })

-- Typography Scale
map("n", "<leader>ts", function()
	local typography = {
		"/* Typography Scale */",
		".text-xs { font-size: 0.75rem; }",
		".text-sm { font-size: 0.875rem; }",
		".text-base { font-size: 1rem; }",
		".text-lg { font-size: 1.125rem; }",
		".text-xl { font-size: 1.25rem; }",
		".text-2xl { font-size: 1.5rem; }",
		".text-3xl { font-size: 1.875rem; }",
		".text-4xl { font-size: 2.25rem; }",
	}
	vim.api.nvim_put(typography, "l", true, true)
end, { desc = "Typography Scale" })
