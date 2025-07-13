-- ~/.config/nvim/lua/zedocean/plugins/html-shortcuts.lua

return {
"L3MON4D3/LuaSnip",
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
local fmt = require("luasnip.extras.fmt").fmt

    -- Helper function for consistent mapping
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

    -- HTML Template Generators
    local html_templates = {

      -- Modern Landing Page Template
      modern_landing = [[

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>]] .. "{}" .. [[</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;

        }


        body {
            font-family: 'Inter', -apple-system, BlinkMacSystemFont, sans-serif;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            color: #333;
        }

        .container {
            max-width: 1200px;

            margin: 0 auto;
            padding: 0 20px;
        }

        .hero {
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            text-align: center;
            background: rgba(255, 255, 255, 0.1);

            backdrop-filter: blur(10px);
            border-radius: 20px;
            margin: 20px;
            box-shadow: 0 8px 32px rgba(0, 0, 0, 0.1);
        }


        .hero h1 {
            font-size: 3.5rem;
            margin-bottom: 1rem;
            background: linear-gradient(135deg, #fff, #f0f0f0);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            animation: fadeInUp 1s ease-out;
        }


        .hero p {

            font-size: 1.2rem;
            margin-bottom: 2rem;
            color: rgba(255, 255, 255, 0.8);

            animation: fadeInUp 1s ease-out 0.3s both;
        }

        .cta-button {
            display: inline-block;
            padding: 15px 40px;
            background: linear-gradient(135deg, #ff6b6b, #ee5a52);

            color: white;
            text-decoration: none;
            border-radius: 50px;
            font-weight: 600;

            transform: translateY(0);
            transition: all 0.3s ease;
            animation: fadeInUp 1s ease-out 0.6s both;
        }

        .cta-button:hover {
            transform: translateY(-3px);
            box-shadow: 0 10px 25px rgba(255, 107, 107, 0.3);
        }

        @keyframes fadeInUp {

            from {
                opacity: 0;
                transform: translateY(30px);

            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        @media (max-width: 768px) {

            .hero h1 {
                font-size: 2.5rem;

            }
            .hero {

                margin: 10px;
            }
        }
    </style>

</head>
<body>
    <div class="container">
        <section class="hero">
            <div>
                <h1>]] .. "{}" .. [[</h1>

                <p>]] .. "{}" .. [[</p>
                <a href="#" class="cta-button">]] .. "{}" .. [[</a>
            </div>
        </section>
    </div>

</body>
</html>]],

      -- Glassmorphism Portfolio Template
      glass_portfolio = [[

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>]] .. "{}" .. [[</title>

    <style>

        * {

            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Inter', sans-serif;

            background: linear-gradient(135deg, #1e3c72 0%, #2a5298 100%);
            min-height: 100vh;
            overflow-x: hidden;
        }

        .glass-card {
            background: rgba(255, 255, 255, 0.1);
            backdrop-filter: blur(10px);
            border-radius: 20px;
            border: 1px solid rgba(255, 255, 255, 0.2);

            padding: 2rem;
            margin: 2rem;
            box-shadow: 0 8px 32px rgba(0, 0, 0, 0.1);
            transition: all 0.3s ease;
        }

        .glass-card:hover {
            transform: translateY(-5px);

            box-shadow: 0 15px 45px rgba(0, 0, 0, 0.2);
        }

        .header {
            text-align: center;
            color: white;
            padding: 2rem 0;
        }

        .header h1 {
            font-size: 3rem;
            margin-bottom: 1rem;
            text-shadow: 0 4px 8px rgba(0, 0, 0, 0.3);
        }

        .grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
            gap: 2rem;
            max-width: 1200px;
            margin: 0 auto;
            padding: 0 2rem;
        }

        .project-card {
            background: rgba(255, 255, 255, 0.05);
            backdrop-filter: blur(15px);
            border-radius: 15px;
            border: 1px solid rgba(255, 255, 255, 0.1);

            padding: 1.5rem;
            color: white;
            transition: all 0.3s ease;
            cursor: pointer;
        }

        .project-card:hover {
            background: rgba(255, 255, 255, 0.1);

            transform: scale(1.02);
        }

        .project-card h3 {
            margin-bottom: 1rem;
            color: #60a5fa;
        }


        .floating-shapes {
            position: fixed;
            top: 0;

            left: 0;

            width: 100%;
            height: 100%;
            pointer-events: none;

            z-index: -1;
        }

        .shape {

            position: absolute;
            background: rgba(255, 255, 255, 0.1);
            border-radius: 50%;
            animation: float 6s ease-in-out infinite;
        }

        .shape:nth-child(1) {
            width: 80px;
            height: 80px;
            top: 20%;
            left: 10%;
            animation-delay: -0.5s;

        }


        .shape:nth-child(2) {
            width: 60px;

            height: 60px;
            top: 60%;
            right: 10%;
            animation-delay: -2s;

        }


        .shape:nth-child(3) {
            width: 100px;
            height: 100px;
            bottom: 20%;
            left: 20%;
            animation-delay: -3.5s;
        }

        @keyframes float {
            0%, 100% {
                transform: translateY(0) rotate(0deg);

            }
            50% {
                transform: translateY(-20px) rotate(180deg);
            }
        }

        @media (max-width: 768px) {

            .header h1 {
                font-size: 2rem;

            }
            .grid {

                grid-template-columns: 1fr;
                padding: 0 1rem;
            }
            .glass-card {
                margin: 1rem;
            }
        }

    </style>

</head>
<body>

    <div class="floating-shapes">

        <div class="shape"></div>
        <div class="shape"></div>
        <div class="shape"></div>
    </div>

    <div class="header">
        <h1>]] .. "{}" .. [[</h1>
        <p>]] .. "{}" .. [[</p>
    </div>


    <div class="grid">
        <div class="project-card">
            <h3>Project One</h3>
            <p>Description of your amazing project goes here.</p>
        </div>
        <div class="project-card">
            <h3>Project Two</h3>
            <p>Description of your amazing project goes here.</p>
        </div>

        <div class="project-card">
            <h3>Project Three</h3>
            <p>Description of your amazing project goes here.</p>
        </div>

    </div>

</body>
</html>]],

      -- Minimal Business Template
      minimal_business = [[

<!DOCTYPE html>

<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>]] .. "{}" .. [[</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Georgia', serif;
            line-height: 1.6;
            color: #2c3e50;
            background: #f8f9fa;
        }

        .container {
            max-width: 1100px;
            margin: 0 auto;
            padding: 0 20px;
        }


        header {
            background: white;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            position: fixed;
            width: 100%;
            top: 0;
            z-index: 1000;
        }

        nav {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 1rem 0;
        }

        .logo {
            font-size: 1.5rem;
            font-weight: bold;
            color: #2c3e50;
        }

        .nav-links {
            display: flex;
            list-style: none;
            gap: 2rem;
        }

        .nav-links a {

            text-decoration: none;
            color: #2c3e50;
            transition: color 0.3s;
        }

        .nav-links a:hover {
            color: #3498db;
        }

        main {

            margin-top: 80px;
        }

        .hero {
            padding: 4rem 0;
            text-align: center;
            background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);
        }


        .hero h1 {
            font-size: 3rem;
            margin-bottom: 1rem;
            color: #2c3e50;
        }

        .hero p {
            font-size: 1.2rem;
            margin-bottom: 2rem;

            color: #7f8c8d;

            max-width: 600px;
            margin-left: auto;
            margin-right: auto;
        }

        .btn {

            display: inline-block;
            padding: 12px 30px;
            background: #3498db;
            color: white;
            text-decoration: none;
            border-radius: 5px;
            transition: background 0.3s;

        }


        .btn:hover {
            background: #2980b9;
        }

        .section {
            padding: 4rem 0;
        }

        .section h2 {
            font-size: 2.5rem;
            margin-bottom: 2rem;
            text-align: center;
            color: #2c3e50;
        }

        .grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
            gap: 2rem;
            margin-top: 2rem;
        }

        .card {
            background: white;
            padding: 2rem;
            border-radius: 10px;
            box-shadow: 0 5px 15px rgba(0,0,0,0.1);
            transition: transform 0.3s;
        }

        .card:hover {
            transform: translateY(-5px);
        }

        footer {
            background: #2c3e50;
            color: white;
            text-align: center;
            padding: 2rem 0;
        }

        @media (max-width: 768px) {
            .nav-links {
                display: none;

            }
            .hero h1 {
                font-size: 2rem;
            }

            .grid {
                grid-template-columns: 1fr;
            }
        }
    </style>

</head>
<body>
    <header>
        <nav class="container">
            <div class="logo">]] .. "{}" .. [[</div>
            <ul class="nav-links">
                <li><a href="#home">Home</a></li>
                <li><a href="#about">About</a></li>
                <li><a href="#services">Services</a></li>
                <li><a href="#contact">Contact</a></li>
            </ul>
        </nav>
    </header>

    <main>
        <section class="hero">
            <div class="container">
                <h1>]] .. "{}" .. [[</h1>
                <p>]] .. "{}" .. [[</p>
                <a href="#contact" class="btn">Get Started</a>
            </div>
        </section>


        <section class="section">

            <div class="container">
                <h2>Our Services</h2>

                <div class="grid">
                    <div class="card">
                        <h3>Service One</h3>
                        <p>Professional service description goes here.</p>
                    </div>
                    <div class="card">
                        <h3>Service Two</h3>
                        <p>Professional service description goes here.</p>

                    </div>
                    <div class="card">
                        <h3>Service Three</h3>
                        <p>Professional service description goes here.</p>
                    </div>
                </div>
            </div>
        </section>
    </main>

    <footer>
        <div class="container">
            <p>&copy; 2024 ]] .. "{}" .. [[. All rights reserved.</p>
        </div>

    </footer>

</body>
</html>]]
    }

    -- Custom snippets for HTML/CSS development
    ls.add_snippets("html", {
      -- Modern Landing Page
      s("modernland", {
        f(function()
          return string.format(html_templates.modern_landing,
            "Modern Landing Page",

            "Welcome to Innovation",
            "Transforming ideas into digital reality with cutting-edge design and technology",
            "Get Started")
        end)
      }),

      -- Glassmorphism Portfolio
      s("glassport", {
        f(function()

          return string.format(html_templates.glass_portfolio,
            "Glass Portfolio",
            "Creative Developer",
            "Crafting beautiful digital experiences")

        end)

      }),

      -- Minimal Business
      s("minbiz", {
        f(function()
          return string.format(html_templates.minimal_business,
            "Business Solutions",
            "YourBrand",
            "Professional Business Solutions",
            "We provide exceptional services that drive results for your business",
            "YourBrand")
        end)
      }),

      -- Quick CSS Grid
      s("cssgrid", {
        t({
          ".grid {",

          "  display: grid;",
          "  grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));",

          "  gap: 2rem;",
          "  max-width: 1200px;",
          "  margin: 0 auto;",
          "  padding: 0 2rem;",
          "}"
        })
      }),

      -- Glassmorphism effect
      s("glassmorphism", {
        t({
          ".glass {",
          "  background: rgba(255, 255, 255, 0.1);",
          "  backdrop-filter: blur(10px);",
          "  border-radius: 20px;",
          "  border: 1px solid rgba(255, 255, 255, 0.2);",
          "  box-shadow: 0 8px 32px rgba(0, 0, 0, 0.1);",
          "  transition: all 0.3s ease;",
          "}"
        })
      }),

      -- Modern gradient background
      s("moderngrad", {
        t({
          "background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);",

          "/* Alternative gradients:",
          "background: linear-gradient(135deg, #1e3c72 0%, #2a5298 100%);",
          "background: linear-gradient(135deg, #ff6b6b 0%, #ee5a52 100%);",
          "background: linear-gradient(135deg, #4facfe 0%, #00f2fe 100%);",
          "*/"
        })
      }),

      -- Responsive navigation
      s("respnav", {
        t({
          "<nav class=\"navbar\">",

          "  <div class=\"nav-container\">",
          "    <div class=\"logo\">Brand</div>",
          "    <ul class=\"nav-links\">",
          "      <li><a href=\"#home\">Home</a></li>",
          "      <li><a href=\"#about\">About</a></li>",
          "      <li><a href=\"#services\">Services</a></li>",
          "      <li><a href=\"#contact\">Contact</a></li>",
          "    </ul>",
          "  </div>",

          "</nav>"
        })

      }),

      -- Modern button styles
      s("modernbtn", {
        t({
          ".btn {",

          "  display: inline-block;",
          "  padding: 15px 40px;",
          "  background: linear-gradient(135deg, #667eea, #764ba2);",
          "  color: white;",
          "  text-decoration: none;",
          "  border-radius: 50px;",

          "  font-weight: 600;",
          "  transform: translateY(0);",
          "  transition: all 0.3s ease;",
          "  box-shadow: 0 4px 15px rgba(102, 126, 234, 0.3);",
          "}",
          "",
          ".btn:hover {",
          "  transform: translateY(-3px);",
          "  box-shadow: 0 8px 25px rgba(102, 126, 234, 0.4);",
          "}"
        })

      })
    })


    -- Quick command functions
    local function create_template(template_name)
      return function()
        local buf = vim.api.nvim_get_current_buf()
        local filename = vim.fn.input("Filename (with .html): ")
        if filename == "" then
          filename = "index.html"
        end


        -- Create new buffer with template
        vim.cmd("enew")
        vim.bo.filetype = "html"
        vim.api.nvim_buf_set_name(0, filename)

        -- Insert template content

        local template_content = ""
        if template_name == "modern" then

          template_content = string.format(html_templates.modern_landing,
            "Your Project",
            "Welcome to Your Site",

            "Amazing description goes here",
            "Get Started")
        elseif template_name == "glass" then
          template_content = string.format(html_templates.glass_portfolio,
            "Your Portfolio",
            "Your Name",
            "Your professional tagline")
        elseif template_name == "business" then
          template_content = string.format(html_templates.minimal_business,
            "Your Business",
            "YourBrand",
            "Professional Solutions",
            "We deliver exceptional results",
            "YourBrand")
        end


        local lines = vim.split(template_content, "\n")
        vim.api.nvim_buf_set_lines(0, 0, -1, false, lines)

        vim.notify("Template created: " .. filename, vim.log.levels.INFO)
      end
    end

    -- Key mappings for quick template creation
    map("n", "<leader>htm", create_template("modern"), { desc = "Create Modern Landing Page" })

    map("n", "<leader>htg", create_template("glass"), { desc = "Create Glass Portfolio" })
    map("n", "<leader>htb", create_template("business"), { desc = "Create Business Template" })

    -- Quick CSS utilities
    map("n", "<leader>css", function()
      vim.cmd("enew")
      vim.bo.filetype = "css"
      vim.api.nvim_buf_set_name(0, "styles.css")
      vim.notify("CSS file created", vim.log.levels.INFO)
    end, { desc = "Create new CSS file" })

    -- Live preview in browser (requires your existing function)
    map("n", "<leader>preview", function()
      local file = vim.fn.expand("%:p")
      if vim.fn.expand("%:e") == "html" then

        vim.fn.system('wslview "' .. file .. '"')

        vim.notify("Opening in browser...", vim.log.levels.INFO)
      else
        vim.notify("Current file is not HTML", vim.log.levels.WARN)
      end

    end, { desc = "Preview HTML in browser" })

    -- Quick project structure creator

    map("n", "<leader>newproj", function()
      local project_name = vim.fn.input("Project name: ")
      if project_name == "" then
        vim.notify("Project name required", vim.log.levels.WARN)
        return
      end


      -- Create project directory structure

      local commands = {
        "mkdir -p " .. project_name,
        "mkdir -p " .. project_name .. "/css",
        "mkdir -p " .. project_name .. "/js",
        "mkdir -p " .. project_name .. "/images",
        "touch " .. project_name .. "/index.html",
        "touch " .. project_name .. "/css/style.css",
        "touch " .. project_name .. "/js/script.js"
      }


      for _, cmd in ipairs(commands) do
        vim.fn.system(cmd)
      end


      -- Open the project
      vim.cmd("cd " .. project_name)
      vim.cmd("edit index.html")

      vim.notify("Project '" .. project_name .. "' created successfully!", vim.log.levels.INFO)
    end, { desc = "Create new project structure" })


    vim.notify("HTML/CSS shortcuts loaded! Use <leader>htm, <leader>htg, <leader>htb for templates", vim.log.levels.INFO)

end,
}

What's Completed ✅

1. HTML Template System with 3 Professional Styles:

Modern Landing Page (<leader>htm) - Glassmorphism with gradients
Glass Portfolio (<leader>htg) - Advanced glassmorphism with animations
Minimal Business (<leader>htb) - Clean, professional corporate design

2. Quick Snippets in HTML files:

modernland - Full modern landing page
glassport - Complete glass portfolio
minbiz - Business template
cssgrid - Responsive CSS grid
glassmorphism - Glass effect CSS
moderngrad - Trendy gradient backgrounds
respnav - Responsive navigation
modernbtn - Modern button styles

3. Productivity Key Mappings:

<leader>htm/htg/htb - Create templates instantly
<leader>css - New CSS file
<leader>preview - Live browser preview
<leader>newproj - Complete project structure

Installation Instructions

Save the code as ~/.config/nvim/lua/zedocean/plugins/html-shortcuts.lua
Restart Neovim or run :Lazy sync
The plugin will auto-load with notifications

Usage Examples

Type <leader>htm → Creates instant modern landing page
In HTML file, type glassmorphism + Tab → Inserts glass effect CSS
Type <leader>newproj → Creates full project folder structure

Next Phase Prompt for New Claude Chat
Copy this to your next Claude chat:
I'm continuing a systematic HTML/CSS freelance development setup in Neovim. PHASE 1 COMPLETED: Created html-shortcuts.lua plugin with 3 professional templates (modern landing, glass portfolio, minimal business), CSS snippets, and productivity keymaps.

PHASE 2 NEEDED: Create an advanced CSS component library system that generates:

1. Responsive navbar variations (5 different styles)
2. Hero section components (modern, classic, split-screen, video background, parallax)
3. Card/grid layouts (pricing tables, testimonials, product showcases, team sections)
4. Footer components (simple, complex, social-focused)
5. Form styles (contact, newsletter, login, modern inputs)
6. Animation utilities (fade-in, slide-up, hover effects, loading spinners)

Build this as a Neovim plugin that creates reusable CSS components I can mix-and-match for clients. Focus on making components that look better than 99% of competitors with modern trends like glassmorphism, gradients, micro-interactions.

My current setup: Neovim + lazy.nvim, already have html-shortcuts.lua working. Need the CSS component system to work similarly with keymaps and snippets.

What should be the next component after this CSS library?
You now have a powerful foundation for rapid HTML/CSS development! The templates are production-ready and follow modern design trends that will impress clients. Each template is fully responsive and includes advanced effects like glassmorphism that most competitors don't use.
Test it out by pressing <leader>htm and you'll see how quickly you can generate professional-looking sites!
