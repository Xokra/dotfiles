-- lua/plugins/luasnip.lua
return {
	"L3MON4D3/LuaSnip",

	version = "v2.*",
	build = "make install_jsregexp",
	dependencies = {
		"rafamadriz/friendly-snippets",
		"saadparwaiz1/cmp_luasnip",
	},
	config = function()
		local ls = require("luasnip")
		local s = ls.snippet
		local t = ls.text_node
		local i = ls.insert_node
		local f = ls.function_node
		local c = ls.choice_node
		local d = ls.dynamic_node
		local sn = ls.snippet_node
		local fmt = require("luasnip.util.fmt").fmt
		local rep = require("luasnip.extras").rep

		-- Load existing snippets
		require("luasnip.loaders.from_vscode").lazy_load()

		-- Custom HTML snippets
		ls.add_snippets("html", {
			-- Basic HTML5 template
			s("html5", {
				t({
					"<!DOCTYPE html>",
					'<html lang="en">',
					"<head>",
					'    <meta charset="UTF-8">',
					'    <meta name="viewport" content="width=device-width, initial-scale=1.0">',
					"    <title>",
				}),
				i(1, "Document"),
				t({
					"</title>",
					'    <link rel="stylesheet" href="style.css">',
					"</head>",
					"<body>",
					"    ",
				}),
				i(2, "<!-- Content here -->"),
				t({
					"",
					'    <script src="script.js"></script>',
					"</body>",
					"</html>",
				}),
			}),

			-- Landing page template
			s("landing", {
				t({
					"<!DOCTYPE html>",

					'<html lang="en">',

					"<head>",
					'    <meta charset="UTF-8">',
					'    <meta name="viewport" content="width=device-width, initial-scale=1.0">',
					"    <title>",
				}),
				i(1, "Landing Page"),
				t({
					"</title>",
					'    <link rel="stylesheet" href="style.css">',
					"</head>",

					"<body>",
					"    <!-- Header -->",
					'    <header class="header">',
					'        <nav class="nav">',
					'            <div class="logo">',
				}),
				i(2, "Logo"),
				t({
					"</div>",
					'            <ul class="nav-links">',
					'                <li><a href="#home">Home</a></li>',
					'                <li><a href="#about">About</a></li>',
					'                <li><a href="#services">Services</a></li>',
					'                <li><a href="#contact">Contact</a></li>',
					"            </ul>",
					"        </nav>",

					"    </header>",
					"",
					"    <!-- Hero Section -->",
					'    <section class="hero" id="home">',
					'        <div class="hero-content">',
					"            <h1>",
				}),

				i(3, "Welcome to Our Service"),
				t({
					"</h1>",
					"            <p>",
				}),
				i(4, "Your success is our priority"),
				t({
					"</p>",
					'            <button class="cta-button">Get Started</button>',

					"        </div>",
					"    </section>",
					"",
					"    <!-- About Section -->",
					'    <section class="about" id="about">',
					"        <h2>About Us</h2>",
					"        <p>",
				}),

				i(5, "About content here"),
				t({
					"</p>",
					"    </section>",
					"",
					"    <!-- Services Section -->",
					'    <section class="services" id="services">',
					"        <h2>Our Services</h2>",

					'        <div class="service-grid">',
					'            <div class="service-card">',
					"                <h3>Service 1</h3>",
					"                <p>Service description</p>",
					"            </div>",

					'            <div class="service-card">',
					"                <h3>Service 2</h3>",
					"                <p>Service description</p>",

					"            </div>",
					'            <div class="service-card">',
					"                <h3>Service 3</h3>",
					"                <p>Service description</p>",
					"            </div>",
					"        </div>",
					"    </section>",

					"",
					"    <!-- Contact Section -->",
					'    <section class="contact" id="contact">',
					"        <h2>Contact Us</h2>",
					'        <form class="contact-form">',
					'            <input type="text" placeholder="Your Name" required>',
					'            <input type="email" placeholder="Your Email" required>',
					'            <textarea placeholder="Your Message" required></textarea>',
					'            <button type="submit">Send Message</button>',
					"        </form>",
					"    </section>",

					"",
					"    <!-- Footer -->",
					'    <footer class="footer">',
					"        <p>&copy; 2024 ",
				}),
				i(6, "Company Name"),
				t({
					". All rights reserved.</p>",
					"    </footer>",
					"",
					'    <script src="script.js"></script>',

					"</body>",
					"</html>",
				}),
			}),

			-- Common HTML components
			s("nav", {
				t({
					'<nav class="navbar">',
					'    <div class="nav-container">',
					'        <div class="nav-logo">',
				}),
				i(1, "Logo"),

				t({

					"</div>",
					'        <ul class="nav-menu">',
					'            <li class="nav-item">',

					'                <a href="#" class="nav-link">',
				}),
				i(2, "Home"),
				t({
					"</a>",
					"            </li>",
					'            <li class="nav-item">',
					'                <a href="#" class="nav-link">',
				}),
				i(3, "About"),
				t({
					"</a>",
					"            </li>",

					"        </ul>",
					"    </div>",
					"</nav>",
				}),
			}),

			s("card", {
				t({
					'<div class="card">',
					'    <div class="card-header">',
					"        <h3>",
				}),
				i(1, "Card Title"),
				t({
					"</h3>",
					"    </div>",
					'    <div class="card-body">',
					"        <p>",
				}),
				i(2, "Card content goes here"),
				t({
					"</p>",
					"    </div>",
					'    <div class="card-footer">',
					'        <button class="btn">',
				}),
				i(3, "Action"),
				t({
					"</button>",
					"    </div>",
					"</div>",
				}),
			}),

			s("form", {
				t({
					'<form class="form">',
					'    <div class="form-group">',
					'        <label for="',
				}),
				i(1, "input1"),
				t('">' .. i(2, "Label") .. "</label>"),
				t({
					"",
					'        <input type="',
				}),
				i(3, "text"),

				t('" id="' .. rep(1) .. '" name="' .. rep(1) .. '" required>'),
				t({
					"",
					"    </div>",
					'    <button type="submit">',
				}),
				i(4, "Submit"),
				t({
					"</button>",
					"</form>",
				}),
			}),
		})

		-- CSS snippets
		ls.add_snippets("css", {
			-- CSS Reset

			s("reset", {
				t({
					"/* CSS Reset */",

					"* {",
					"    margin: 0;",
					"    padding: 0;",
					"    box-sizing: border-box;",
					"}",
					"",
					"body {",
					"    font-family: Arial, sans-serif;",
					"    line-height: 1.6;",
					"    color: #333;",
					"}",
					"",

					"a {",
					"    text-decoration: none;",
					"    color: inherit;",
					"}",
					"",
					"ul {",
					"    list-style: none;",
					"}",
					"",
					"img {",
					"    max-width: 100%;",
					"    height: auto;",

					"}",
				}),
			}),

			-- Flexbox center
			s("flexcenter", {
				t({
					"display: flex;",
					"justify-content: center;",

					"align-items: center;",
				}),
			}),

			-- Grid layout
			s("grid", {
				t({
					"display: grid;",
					"grid-template-columns: repeat(",
				}),

				i(1, "auto-fit"),

				t(", minmax("),
				i(2, "250px"),
				t(", 1fr));"),
				t({
					"",
					"gap: ",
				}),
				i(3, "2rem"),

				t(";"),
			}),

			-- Responsive breakpoints
			s("media", {
				t("@media (max-width: "),
				i(1, "768px"),
				t({
					") {",
					"    ",
				}),
				i(2, "/* Styles here */"),
				t({
					"",
					"}",
				}),
			}),

			-- Button styles
			s("button", {
				t({
					".btn {",
					"    display: inline-block;",
					"    padding: ",
				}),

				i(1, "12px 24px"),
				t({
					";",
					"    background-color: ",
				}),
				i(2, "#007bff"),
				t({
					";",
					"    color: white;",
					"    border: none;",
					"    border-radius: 4px;",
					"    cursor: pointer;",

					"    transition: background-color 0.3s ease;",
					"}",
					"",
					".btn:hover {",
					"    background-color: ",
				}),
				i(3, "#0056b3"),
				t({
					";",
					"}",
				}),
			}),
		})

		-- Keybindings
		vim.keymap.set({ "i", "s" }, "<C-k>", function()
			if ls.expand_or_jumpable() then
				ls.expand_or_jump()
			end
		end, { silent = true })

		vim.keymap.set({ "i", "s" }, "<C-j>", function()
			if ls.jumpable(-1) then
				ls.jump(-1)
			end
		end, { silent = true })
	end,
}
