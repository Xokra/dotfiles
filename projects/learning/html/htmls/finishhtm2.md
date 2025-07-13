-- ~/.config/nvim/lua/zedocean/plugins/html-templates.lua

return {
"L3MON4D3/LuaSnip",
dependencies = {
"rafamadriz/friendly-snippets",
},
config = function()
local luasnip = require("luasnip")
local s = luasnip.snippet
local t = luasnip.text_node
local i = luasnip.insert_node
local f = luasnip.function_node

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

    -- Template generation functions
    local function generate_html_template(style_type)
      local templates = {
        modern = {
          css = [[

/_ Modern Design System _/

- {

  margin: 0;

  padding: 0;
  box-sizing: border-box;
  }

:root {
--primary: #6366f1;
--secondary: #8b5cf6;

--accent: #f59e0b;
--background: #0f172a;
--surface: #1e293b;

--text: #f1f5f9;
--text-secondary: #94a3b8;

--border: #334155;
--shadow: rgba(0, 0, 0, 0.25);
}

body {
font-family: 'Inter', system-ui, sans-serif;
background: linear-gradient(135deg, var(--background) 0%, #1e1b4b 100%);
color: var(--text);
line-height: 1.6;
min-height: 100vh;
}

.container {
max-width: 1200px;
margin: 0 auto;

padding: 0 2rem;
}

/_ Glass morphism effect _/
.glass {
background: rgba(255, 255, 255, 0.1);

backdrop-filter: blur(10px);
border: 1px solid rgba(255, 255, 255, 0.2);
border-radius: 16px;
}

/_ Animations _/
@keyframes slideUp {
from { transform: translateY(30px); opacity: 0; }
to { transform: translateY(0); opacity: 1; }
}

.animate-slide-up {
animation: slideUp 0.6s ease-out;
}

/_ Button styles _/
.btn {

display: inline-block;
padding: 0.75rem 1.5rem;
border-radius: 8px;
font-weight: 600;
text-decoration: none;
transition: all 0.3s ease;
border: none;
cursor: pointer;
}

.btn-primary {
background: linear-gradient(135deg, var(--primary), var(--secondary));
color: white;
}

.btn-primary:hover {
transform: translateY(-2px);
box-shadow: 0 10px 25px rgba(99, 102, 241, 0.4);
}

/_ Header _/
.header {
padding: 2rem 0;
position: sticky;
top: 0;
z-index: 100;

background: rgba(15, 23, 42, 0.9);
backdrop-filter: blur(10px);
}

.nav {

display: flex;
justify-content: space-between;
align-items: center;
}

.logo {
font-size: 1.5rem;
font-weight: 700;
color: var(--primary);
}

.nav-menu {
display: flex;
gap: 2rem;
list-style: none;
}

.nav-link {
color: var(--text);
text-decoration: none;
transition: color 0.3s ease;
}

.nav-link:hover {
color: var(--primary);
}

/_ Hero Section _/
.hero {
padding: 4rem 0;
text-align: center;
}

.hero h1 {
font-size: 3.5rem;
font-weight: 800;
margin-bottom: 1rem;
background: linear-gradient(135deg, var(--primary), var(--secondary));
-webkit-background-clip: text;
-webkit-text-fill-color: transparent;
background-clip: text;

}

.hero p {
font-size: 1.25rem;
color: var(--text-secondary);
margin-bottom: 2rem;
max-width: 600px;
margin-left: auto;
margin-right: auto;
}

/_ Cards _/
.card {
background: var(--surface);
border-radius: 12px;
padding: 2rem;
border: 1px solid var(--border);
transition: all 0.3s ease;
}

.card:hover {
transform: translateY(-5px);
box-shadow: 0 20px 40px var(--shadow);
}

/_ Responsive _/
@media (max-width: 768px) {

.hero h1 {

    font-size: 2.5rem;

}

.nav-menu {
flex-direction: column;
gap: 1rem;

}

.container {
padding: 0 1rem;
}
}]],
html = [[<!DOCTYPE html>

<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Modern Website</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="style.css">
</head>
<body>
    <header class="header">
        <nav class="nav container">
            <div class="logo">YourLogo</div>
            <ul class="nav-menu">
                <li><a href="#home" class="nav-link">Home</a></li>
                <li><a href="#about" class="nav-link">About</a></li>
                <li><a href="#services" class="nav-link">Services</a></li>
                <li><a href="#contact" class="nav-link">Contact</a></li>

            </ul>
        </nav>
    </header>

    <main>
        <section class="hero animate-slide-up">
            <div class="container">
                <h1>Build Something Amazing</h1>
                <p>Create stunning websites with modern design principles and cutting-edge technology</p>

                <a href="#contact" class="btn btn-primary">Get Started</a>

            </div>
        </section>

        <section class="features" style="padding: 4rem 0;">
            <div class="container">

                <div style="display: grid; grid-template-columns: repeat(auto-fit, minmax(300px, 1fr)); gap: 2rem;">
                    <div class="card glass">
                        <h3 style="color: var(--primary); margin-bottom: 1rem;">Modern Design</h3>
                        <p>Clean, contemporary aesthetics that engage your audience</p>
                    </div>
                    <div class="card glass">
                        <h3 style="color: var(--primary); margin-bottom: 1rem;">Responsive</h3>
                        <p>Perfect on all devices, from mobile to desktop</p>
                    </div>

                    <div class="card glass">
                        <h3 style="color: var(--primary); margin-bottom: 1rem;">Fast Performance</h3>
                        <p>Optimized code for lightning-fast loading times</p>
                    </div>
                </div>
            </div>
        </section>
    </main>


    <footer style="background: var(--surface); padding: 2rem 0; margin-top: 4rem;">
        <div class="container" style="text-align: center;">
            <p>&copy; 2025 Your Company. All rights reserved.</p>

        </div>
    </footer>

</body>
</html>]]
        },


        classic = {
          css = [[

/_ Classic Professional Design _/

- {
  margin: 0;
  padding: 0;
  box-sizing: border-box;
  }

body {
font-family: 'Georgia', serif;
background-color: #f8f9fa;
color: #333;
line-height: 1.8;
}

.container {
max-width: 1100px;
margin: 0 auto;
padding: 0 20px;

}

/_ Header _/
.header {
background: #fff;
box-shadow: 0 2px 10px rgba(0,0,0,0.1);
position: sticky;
top: 0;
z-index: 100;
}

.nav {
display: flex;
justify-content: space-between;
align-items: center;
padding: 1rem 0;

}

.logo {
font-size: 1.8rem;
font-weight: bold;
color: #2c3e50;
}

.nav-menu {

display: flex;
gap: 2rem;
list-style: none;
}

.nav-link {
color: #555;
text-decoration: none;
font-weight: 500;

transition: color 0.3s ease;
}

.nav-link:hover {
color: #3498db;
}

/_ Hero Section _/
.hero {
background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
color: white;
padding: 4rem 0;
text-align: center;
}

.hero h1 {
font-size: 2.8rem;
margin-bottom: 1rem;
font-weight: 300;
}

.hero p {
font-size: 1.2rem;
margin-bottom: 2rem;
opacity: 0.9;
}

/_ Button _/
.btn {
display: inline-block;
padding: 12px 30px;

background: #3498db;
color: white;
text-decoration: none;
border-radius: 5px;
font-weight: 600;
transition: background 0.3s ease;
}

.btn:hover {
background: #2980b9;
}

/_ Content Sections _/
.section {

padding: 3rem 0;
}

.section-title {
font-size: 2.2rem;
text-align: center;
margin-bottom: 3rem;
color: #2c3e50;
}

.features {
background: white;
}

.features-grid {
display: grid;
grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));

gap: 2rem;

}

.feature-card {
text-align: center;
padding: 2rem;

border-radius: 8px;
box-shadow: 0 5px 15px rgba(0,0,0,0.1);

transition: transform 0.3s ease;
}

.feature-card:hover {

transform: translateY(-5px);
}

.feature-icon {

font-size: 3rem;
color: #3498db;
margin-bottom: 1rem;
}

/_ Footer _/

.footer {
background: #2c3e50;

color: white;
text-align: center;
padding: 2rem 0;
}

@media (max-width: 768px) {
.hero h1 {
font-size: 2.2rem;
}

.nav-menu {
flex-direction: column;
gap: 1rem;
}
}]],
html = [[<!DOCTYPE html>

<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Professional Website</title>
    <link rel="stylesheet" href="style.css">
</head>
<body>

    <header class="header">
        <nav class="nav container">
            <div class="logo">Your Company</div>
            <ul class="nav-menu">
                <li><a href="#home" class="nav-link">Home</a></li>
                <li><a href="#about" class="nav-link">About</a></li>
                <li><a href="#services" class="nav-link">Services</a></li>
                <li><a href="#contact" class="nav-link">Contact</a></li>
            </ul>
        </nav>
    </header>

    <main>

        <section class="hero">
            <div class="container">
                <h1>Professional Excellence</h1>

                <p>Delivering quality solutions with timeless design and proven results</p>
                <a href="#contact" class="btn">Learn More</a>
            </div>
        </section>

        <section class="features section">

            <div class="container">
                <h2 class="section-title">Our Services</h2>

                <div class="features-grid">
                    <div class="feature-card">
                        <div class="feature-icon">🎯</div>
                        <h3>Strategic Planning</h3>
                        <p>Comprehensive strategies tailored to your business goals</p>
                    </div>
                    <div class="feature-card">
                        <div class="feature-icon">⚡</div>
                        <h3>Efficient Solutions</h3>

                        <p>Streamlined processes that deliver results on time</p>
                    </div>

                    <div class="feature-card">
                        <div class="feature-icon">🏆</div>
                        <h3>Quality Assurance</h3>
                        <p>Rigorous testing and quality control measures</p>

                    </div>
                </div>
            </div>

        </section>

    </main>


    <footer class="footer">
        <div class="container">
            <p>&copy; 2025 Your Company. All rights reserved.</p>
        </div>
    </footer>

</body>

</html>]]
        },
        
        minimal = {
          css = [[
/* Minimal Clean Design */
* {
  margin: 0;
  padding: 0;
  box-sizing: border-box;
}

body {
font-family: 'Helvetica Neue', Arial, sans-serif;
background: #ffffff;
color: #2d3748;

line-height: 1.6;
}

.container {
max-width: 800px;
margin: 0 auto;
padding: 0 1rem;

}

/_ Typography _/
h1, h2, h3 {
font-weight: 300;
letter-spacing: -0.02em;
}

h1 {
font-size: 2.5rem;
margin-bottom: 1rem;
}

h2 {
font-size: 1.8rem;
margin-bottom: 1.5rem;
}

/_ Header _/
.header {

padding: 2rem 0;
border-bottom: 1px solid #e2e8f0;
}

.nav {

display: flex;
justify-content: space-between;
align-items: center;
}

.logo {
font-size: 1.2rem;
font-weight: 600;
color: #1a202c;
}

.nav-menu {
display: flex;
gap: 2rem;
list-style: none;
}

.nav-link {
color: #4a5568;
text-decoration: none;
font-size: 0.9rem;
transition: color 0.2s ease;

}

.nav-link:hover {
color: #1a202c;
}

/_ Hero _/
.hero {

padding: 4rem 0;
text-align: center;
}

.hero h1 {
color: #1a202c;
margin-bottom: 1rem;
}

.hero p {
color: #4a5568;

font-size: 1.1rem;

margin-bottom: 2rem;
}

/_ Button _/
.btn {
display: inline-block;
padding: 0.75rem 1.5rem;

background: #1a202c;
color: white;
text-decoration: none;
border-radius: 3px;
font-size: 0.9rem;
transition: background 0.2s ease;
}

.btn:hover {
background: #2d3748;
}

/_ Content _/

.section {
padding: 3rem 0;
}

.grid {

display: grid;
grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
gap: 2rem;
}

.card {
padding: 1.5rem;
border: 1px solid #e2e8f0;
border-radius: 4px;
}

.card h3 {
margin-bottom: 0.5rem;
color: #1a202c;
}

.card p {
color: #4a5568;

font-size: 0.9rem;

}

/_ Footer _/
.footer {
border-top: 1px solid #e2e8f0;
padding: 2rem 0;
text-align: center;
}

.footer p {
color: #718096;

font-size: 0.8rem;

}

@media (max-width: 600px) {
.hero h1 {
font-size: 2rem;
}

.nav-menu {

    display: none;

}
}]],
html = [[<!DOCTYPE html>

<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Minimal Site</title>
    <link rel="stylesheet" href="style.css">
</head>
<body>

    <header class="header">
        <nav class="nav container">
            <div class="logo">Brand</div>

            <ul class="nav-menu">

                <li><a href="#home" class="nav-link">Home</a></li>
                <li><a href="#work" class="nav-link">Work</a></li>
                <li><a href="#about" class="nav-link">About</a></li>
                <li><a href="#contact" class="nav-link">Contact</a></li>
            </ul>
        </nav>
    </header>

    <main>

        <section class="hero">
            <div class="container">

                <h1>Simple. Clean. Effective.</h1>
                <p>We focus on what matters most: delivering exceptional results through thoughtful design</p>
                <a href="#work" class="btn">View Work</a>
            </div>

        </section>


        <section class="section">
            <div class="container">
                <div class="grid">
                    <div class="card">
                        <h3>Design</h3>
                        <p>Clean, purposeful design that communicates your message clearly</p>

                    </div>
                    <div class="card">
                        <h3>Development</h3>

                        <p>Modern, efficient code that performs flawlessly across all devices</p>

                    </div>

                    <div class="card">
                        <h3>Strategy</h3>
                        <p>Thoughtful planning that aligns with your business objectives</p>
                    </div>

                </div>
            </div>
        </section>
    </main>

    <footer class="footer">
        <div class="container">
            <p>&copy; 2025 Brand. All rights reserved.</p>

        </div>
    </footer>

</body>
</html>]]

        }
      }



      return templates[style_type] or templates.modern
    end


    -- Template creation commands
    local function create_project_template(style)
      local template = generate_html_template(style)



      -- Create directory structure

      local project_name = vim.fn.input("Project name: ")
      if project_name == "" then

        vim.notify("Project name required!", vim.log.levels.ERROR)

        return
      end

      local project_dir = vim.fn.getcwd() .. "/" .. project_name

      vim.fn.mkdir(project_dir, "p")

      -- Create HTML file
      local html_file = project_dir .. "/index.html"

      local html_content = template.html
      vim.fn.writefile(vim.split(html_content, "\n"), html_file)



      -- Create CSS file

      local css_file = project_dir .. "/style.css"

      local css_content = template.css
      vim.fn.writefile(vim.split(css_content, "\n"), css_file)

      -- Create assets directory

      vim.fn.mkdir(project_dir .. "/assets", "p")
      vim.fn.mkdir(project_dir .. "/assets/images", "p")
      vim.fn.mkdir(project_dir .. "/assets/js", "p")

      -- Create basic JavaScript file

      local js_content = [[

// Main JavaScript file
document.addEventListener('DOMContentLoaded', function() {
console.log('Website loaded successfully!');

    // Smooth scrolling for navigation links
    document.querySelectorAll('a[href^="#"]').forEach(anchor => {
        anchor.addEventListener('click', function (e) {
            e.preventDefault();
            const target = document.querySelector(this.getAttribute('href'));
            if (target) {
                target.scrollIntoView({
                    behavior: 'smooth',
                    block: 'start'
                });
            }
        });
    });

});]]

      local js_file = project_dir .. "/assets/js/main.js"
      vim.fn.writefile(vim.split(js_content, "\n"), js_file)

      -- Open the HTML file
      vim.cmd("edit " .. html_file)


      vim.notify("Project '" .. project_name .. "' created with " .. style .. " template!", vim.log.levels.INFO)
    end


    -- Key mappings for template generation

    map("n", "<leader>htm", function()
      create_project_template("modern")
    end, { desc = "Create Modern HTML Template" })

    map("n", "<leader>htc", function()
      create_project_template("classic")
    end, { desc = "Create Classic HTML Template" })

    map("n", "<leader>htn", function()

      create_project_template("minimal")

    end, { desc = "Create Minimal HTML Template" })

    -- Quick component snippets

    map("n", "<leader>hh", function()
      local component = vim.fn.input("Component (nav/hero/card/footer): ")
      local snippets = {
        nav = [[<nav class="nav container">
    <div class="logo">Your Logo</div>
    <ul class="nav-menu">
        <li><a href="#home" class="nav-link">Home</a></li>

        <li><a href="#about" class="nav-link">About</a></li>
        <li><a href="#services" class="nav-link">Services</a></li>

        <li><a href="#contact" class="nav-link">Contact</a></li>

    </ul>

</nav>]],
        hero = [[<section class="hero">
    <div class="container">
        <h1>Your Headline</h1>
        <p>Your compelling description goes here</p>

        <a href="#contact" class="btn btn-primary">Get Started</a>

    </div>

</section>]],

        card = [[<div class="card">
    <h3>Card Title</h3>
    <p>Card description goes here</p>

</div>]],
        footer = [[<footer class="footer">
    <div class="container">

        <p>&copy; 2025 Your Company. All rights reserved.</p>

    </div>

</footer>]]

      }

      if snippets[component] then

        vim.api.nvim_put(vim.split(snippets[component], "\n"), "l", true, true)
      else

        vim.notify("Component not found! Available: nav, hero, card, footer", vim.log.levels.WARN)

      end
    end, { desc = "Insert HTML Component" })

    -- Live server shortcut

    map("n", "<leader>hs", function()
      local file = vim.fn.expand("%:p")
      if vim.fn.executable("python3") == 1 then

        vim.fn.system("cd " .. vim.fn.expand("%:h") .. " && python3 -m http.server 8000 &")
        vim.notify("Live server started at http://localhost:8000", vim.log.levels.INFO)
      else
        vim.notify("Python3 not found! Install it for live server.", vim.log.levels.ERROR)

      end
    end, { desc = "Start Live Server" })

    -- Open in browser
    map("n", "<leader>hb", function()
      local file = vim.fn.expand("%:p")
      if vim.fn.has("wsl") == 1 then

        vim.fn.system('wslview "' .. file .. '"')

      else
        vim.fn.system('xdg-open "' .. file .. '"')
      end
    end, { desc = "Open in Browser" })

end
}

🎯 What You Just Got:
3 Professional Template Styles:

Modern (<leader>htm) - Dark theme, glassmorphism, gradients, animations
Classic (<leader>htc) - Professional, traditional business look
Minimal (<leader>htn) - Clean, typography-focused, ultra-simple

Key Features:

Instant Project Creation - Full folder structure with HTML/CSS/JS
Component Shortcuts (<leader>hh) - Quick nav, hero, card, footer insertion
Live Server (<leader>hs) - Python-based local development server
Browser Opening (<leader>hb) - Direct file opening in browser

File Structure Created:
project-name/
├── index.html
├── style.css
├── assets/
│ ├── images/
│ └── js/
│ └── main.js
🔧 Installation Instructions:

Save the code as ~/.config/nvim/lua/zedocean/plugins/html-templates.lua
Restart Neovim or run :Lazy sync
Ready to use! Try <leader>htm to create your first modern template

🚀 Next Phase Strategy:
Since we're working systematically, here's what the next Claude.ai chat should focus on:
Prompt for Next Chat:
I'm continuing a systematic freelance HTML/CSS setup in Neovim. Phase 1 (HTML template system) is complete.

Now I need Phase 2: "CSS Component Library & Styling Shortcuts System"

Create a comprehensive CSS component library with:

- Pre-built components (buttons, forms, modals, carousels)
- CSS Grid/Flexbox shortcuts
- Color palette management
- Responsive design utilities
- Animation library
- Neovim keybindings for instant insertion

My setup: Neovim with lazy.nvim, existing keybindings use <leader> prefix, I want the same helper function style:
local function map(mode, lhs, rhs, opts)...

Focus ONLY on CSS components and styling shortcuts. Make it production-ready for client work.
Current Progress:

✅ Phase 1: HTML Template System (COMPLETED)
⏳ Phase 2: CSS Component Library (NEXT)
🔄 Phase 3: JavaScript Snippets & Interactions
🔄 Phase 4: Project Management & Client Workflow
🔄 Phase 5: Performance & Deployment Tools

This systematic approach will give you a professional freelance toolkit where each template can be customized quickly with different components, ensuring you can deliver unique, high-quality sites to clients efficiently!
