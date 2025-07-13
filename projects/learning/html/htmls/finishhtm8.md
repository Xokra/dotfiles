-- ~/.config/nvim/lua/zedocean/plugins/html-css-snippets.lua

return {

"L3MON4D3/LuaSnip",
event = "InsertEnter",

dependencies = {
"rafamadriz/friendly-snippets",
},
config = function()

    local ls = require("luasnip")

    local s = ls.snippet
    local t = ls.text_node
    local i = ls.insert_node
    local f = ls.function_node
    local c = ls.choice_node
    local d = ls.dynamic_node
    local rep = require("luasnip.extras").rep

    -- Helper function for mapping
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


    -- HTML Snippets
    ls.add_snippets("html", {
      -- Modern HTML5 Boilerplate
      s("html5", {
        t({"<!DOCTYPE html>", "<html lang=\""}), i(1, "en"), t({"\">", "<head>", "  <meta charset=\"UTF-8\">", "  <meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\">", "  <title>"}), i(2, "Document"), t({"</title>", "  <link rel=\"stylesheet\" href=\""}), i(3, "style.css"), t({"\">", "</head>", "<body>", "  "}), i(4, "<!-- Content goes here -->"), t({"", "</body>", "</html>"})
      }),

      -- Glassmorphism Card
      s("glass-card", {
        t({"<div class=\"glass-card\">", "  <div class=\"glass-content\">", "    <h2>"}), i(1, "Title"), t({"</h2>", "    <p>"}), i(2, "Content"), t({"</p>", "  </div>", "</div>"})
      }),

      -- Hero Section Templates
      s("hero-modern", {
        t({"<section class=\"hero-section\">", "  <div class=\"hero-container\">", "    <div class=\"hero-content\">", "      <h1 class=\"hero-title\">"}), i(1, "Your Title"), t({"</h1>", "      <p class=\"hero-subtitle\">"}), i(2, "Your subtitle"), t({"</p>", "      <div class=\"hero-buttons\">", "        <button class=\"btn btn-primary\">"}), i(3, "Get Started"), t({"</button>", "        <button class=\"btn btn-secondary\">"}), i(4, "Learn More"), t({"</button>", "      </div>", "    </div>", "    <div class=\"hero-visual\">", "      "}), i(5, "<!-- Visual element -->"), t({"", "    </div>", "  </div>", "</section>"})
      }),

      -- Navigation Bar
      s("nav-modern", {
        t({"<nav class=\"navbar\">", "  <div class=\"nav-container\">", "    <div class=\"nav-logo\">", "      <a href=\"#\">"}), i(1, "Logo"), t({"</a>", "    </div>", "    <ul class=\"nav-menu\">", "      <li><a href=\"#\">"}), i(2, "Home"), t({"</a></li>", "      <li><a href=\"#\">"}), i(3, "About"), t({"</a></li>", "      <li><a href=\"#\">"}), i(4, "Services"), t({"</a></li>", "      <li><a href=\"#\">"}), i(5, "Contact"), t({"</a></li>", "    </ul>", "    <div class=\"nav-toggle\">", "      <span></span>", "      <span></span>", "      <span></span>", "    </div>", "  </div>", "</nav>"})
      }),

      -- Card Grid System
      s("card-grid", {
        t({"<div class=\"card-grid\">", "  <div class=\"card\">", "    <div class=\"card-image\">", "      <img src=\""}), i(1, "image1.jpg"), t({"\" alt=\""}), i(2, "Alt text"), t({"\">", "    </div>", "    <div class=\"card-content\">", "      <h3>"}), i(3, "Card Title"), t({"</h3>", "      <p>"}), i(4, "Card description"), t({"</p>", "      <button class=\"card-btn\">"}), i(5, "Learn More"), t({"</button>", "    </div>", "  </div>", "</div>"})

      }),

      -- Contact Form
      s("contact-form", {
        t({"<form class=\"contact-form\">", "  <div class=\"form-group\">", "    <label for=\"name\">Name</label>", "    <input type=\"text\" id=\"name\" name=\"name\" required>", "  </div>", "  <div class=\"form-group\">", "    <label for=\"email\">Email</label>", "    <input type=\"email\" id=\"email\" name=\"email\" required>", "  </div>", "  <div class=\"form-group\">", "    <label for=\"message\">Message</label>", "    <textarea id=\"message\" name=\"message\" rows=\"5\" required></textarea>", "  </div>", "  <button type=\"submit\" class=\"submit-btn\">"}), i(1, "Send Message"), t({"</button>", "</form>"})
      }),
    })

    -- CSS Snippets
    ls.add_snippets("css", {
      -- CSS Reset

      s("reset", {
        t({"* {", "  margin: 0;", "  padding: 0;", "  box-sizing: border-box;", "}", "", "body {", "  font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif;", "  line-height: 1.6;", "  color: #333;", "}"})

      }),

      -- Glassmorphism Effect
      s("glass", {
        t({".glass-card {", "  background: rgba(255, 255, 255, 0.1);", "  backdrop-filter: blur(10px);", "  border-radius: 20px;", "  border: 1px solid rgba(255, 255, 255, 0.2);", "  padding: 2rem;", "  box-shadow: 0 8px 32px rgba(0, 0, 0, 0.1);", "  transition: all 0.3s ease;", "}", "", ".glass-card:hover {", "  transform: translateY(-5px);", "  box-shadow: 0 15px 40px rgba(0, 0, 0, 0.2);", "}"})
      }),


      -- Modern Button Styles
      s("btn-modern", {
        t({".btn {", "  padding: 12px 30px;", "  border: none;", "  border-radius: 50px;", "  font-weight: 600;", "  font-size: 16px;", "  cursor: pointer;", "  transition: all 0.3s ease;", "  position: relative;", "  overflow: hidden;", "}", "", ".btn-primary {", "  background: linear-gradient(45deg, #667eea 0%, #764ba2 100%);", "  color: white;", "}", "", ".btn-primary:hover {", "  transform: translateY(-2px);", "  box-shadow: 0 10px 25px rgba(102, 126, 234, 0.4);", "}"})
      }),


      -- Flex Layout Utilities
      s("flex-center", {
        t({".flex-center {", "  display: flex;", "  justify-content: center;", "  align-items: center;", "}"})
      }),


      -- Grid System
      s("grid-responsive", {
        t({".grid {", "  display: grid;", "  grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));", "  gap: 2rem;", "  padding: 2rem;", "}"})
      }),

      -- Animations
      s("fadeIn", {
        t({"@keyframes fadeIn {", "  from { opacity: 0; transform: translateY(20px); }", "  to { opacity: 1; transform: translateY(0); }", "}", "", ".fade-in {", "  animation: fadeIn 0.6s ease-out;", "}"})
      }),

      -- Responsive Mixins
      s("responsive", {
        t({"/* Mobile First */", "@media (min-width: 768px) {", "  "}), i(1, "/* Tablet styles */"), t({"", "}", "", "@media (min-width: 1024px) {", "  "}), i(2, "/* Desktop styles */"), t({"", "}", "", "@media (min-width: 1200px) {", "  "}), i(3, "/* Large desktop styles */"), t({"", "}"})
      }),

      -- Modern Hero Section
      s("hero-css", {
        t({".hero-section {", "  min-height: 100vh;", "  background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);", "  display: flex;", "  align-items: center;", "  position: relative;", "  overflow: hidden;", "}", "", ".hero-container {", "  max-width: 1200px;", "  margin: 0 auto;", "  padding: 0 2rem;", "  display: grid;", "  grid-template-columns: 1fr 1fr;", "  gap: 4rem;", "  align-items: center;", "}", "", ".hero-title {", "  font-size: clamp(2.5rem, 5vw, 4rem);", "  font-weight: 700;", "  color: white;", "  margin-bottom: 1rem;", "  line-height: 1.2;", "}"})
      }),

      -- Card Hover Effects
      s("card-hover", {
        t({".card {", "  background: white;", "  border-radius: 15px;", "  padding: 2rem;", "  box-shadow: 0 4px 20px rgba(0, 0, 0, 0.1);", "  transition: all 0.3s ease;", "  cursor: pointer;", "}", "", ".card:hover {", "  transform: translateY(-10px);", "  box-shadow: 0 20px 40px rgba(0, 0, 0, 0.2);", "}"})
      }),
    })


    -- Key mappings for snippet navigation
    map("i", "<C-l>", function()
      if ls.expand_or_jumpable() then
        ls.expand_or_jump()
      end

    end, { desc = "Expand snippet or jump to next" })

    map("i", "<C-h>", function()
      if ls.jumpable(-1) then

        ls.jump(-1)

      end
    end, { desc = "Jump to previous snippet position" })


    map("s", "<C-l>", function()
      if ls.expand_or_jumpable() then
        ls.expand_or_jump()
      end
    end, { desc = "Expand snippet or jump to next" })


    map("s", "<C-h>", function()
      if ls.jumpable(-1) then
        ls.jump(-1)
      end
    end, { desc = "Jump to previous snippet position" })

    -- Quick snippet selection
    map("i", "<C-s>", function()
      if ls.choice_active() then
        ls.change_choice(1)
      end
    end, { desc = "Cycle through snippet choices" })

    -- Load existing snippets
    require("luasnip.loaders.from_vscode").lazy_load()

end,
}

Phase 1: HTML/CSS Snippet System ✅
I've created a comprehensive snippet system that will significantly speed up your HTML/CSS development. This system includes:
Key Features:

Modern HTML5 templates with semantic structure
Glassmorphism effects for cutting-edge design
Responsive grid systems and flex utilities
Modern button styles with hover effects
Hero sections and navigation bars
Contact forms and card components
CSS animations and responsive mixins

Usage:

Save the code as ~/.config/nvim/lua/zedocean/plugins/html-css-snippets.lua
Type snippet triggers like html5, glass-card, hero-modern in HTML files
Use <C-l> and <C-h> to navigate between snippet placeholders
CSS snippets include glass, btn-modern, flex-center, grid-responsive

Next Phase Instructions for New Claude Session:
CONTEXT: I'm building a competitive HTML/CSS freelance toolkit. Phase 1 (HTML/CSS snippet system) has been completed with a comprehensive LuaSnip setup including modern templates, glassmorphism effects, responsive systems, and navigation shortcuts.

CURRENT STATUS:
✅ Phase 1: HTML/CSS Snippet System - COMPLETE
📋 Phase 2: Template Generator System - NEXT

YOUR TASK (Phase 2): Create a Neovim command system that generates complete HTML/CSS project templates with different style variations:

REQUIREMENTS:

1. Create telescope-integrated template picker
2. Generate complete project structures (HTML + CSS + assets)
3. Include 5 style variations: Minimalist, Glassmorphism, Dark Mode, Gradient, Corporate
4. Auto-generate folder structure with proper file organization
5. Include responsive design patterns
6. Add live preview integration

DELIVERABLES:

- Lua plugin for template generation
- Telescope integration for template selection
- Complete project structure generator
- Style variation system

NEXT CHAIN: After completing Phase 2, create prompt for Phase 3 (Live Development Server Integration) following the same format.

CONTEXT FILES: The user has lazy.nvim setup, telescope configured, and the snippet system from Phase 1 already implemented.
Action Required: Start a new Claude chat and paste the above instructions to continue with Phase 2!
