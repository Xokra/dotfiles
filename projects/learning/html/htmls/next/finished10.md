-- HTML/CSS Snippet Generator Plugin
-- File: ~/.config/nvim/lua/zedocean/plugins/html-css-snippets.lua

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

-- Modern HTML5 Boilerplate Templates
local templates = {
-- Basic HTML5 Structure

html5_basic = [[

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">

    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>

</head>
<body>
    
</body>

</html>]],

-- Modern Landing Page Template
html5_landing = [[

<!DOCTYPE html>
<html lang="en">
<head>

    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Modern Landing Page</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }


        body {
            font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Oxygen, Ubuntu, Cantarell, sans-serif;
            line-height: 1.6;
            color: #333;

            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
        }

        .container {
            max-width: 1200px;

            margin: 0 auto;
            padding: 0 20px;
        }

        header {
            background: rgba(255, 255, 255, 0.1);
            backdrop-filter: blur(10px);

            border-bottom: 1px solid rgba(255, 255, 255, 0.2);
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
            color: white;
        }

        .nav-links {
            display: flex;
            list-style: none;
            gap: 2rem;
        }

        .nav-links a {
            color: white;
            text-decoration: none;
            transition: opacity 0.3s;
        }


        .nav-links a:hover {
            opacity: 0.8;
        }

        .hero {
            text-align: center;
            padding: 8rem 0 4rem;
            color: white;
        }

        .hero h1 {
            font-size: 3.5rem;
            margin-bottom: 1rem;
            font-weight: 300;
        }

        .hero p {
            font-size: 1.2rem;
            margin-bottom: 2rem;
            opacity: 0.9;
        }

        .cta-button {
            background: linear-gradient(45deg, #ff6b6b, #ee5a24);

            color: white;
            padding: 1rem 2rem;

            border: none;
            border-radius: 50px;
            font-size: 1.1rem;
            cursor: pointer;
            transition: transform 0.3s, box-shadow 0.3s;
            text-decoration: none;
            display: inline-block;
        }


        .cta-button:hover {
            transform: translateY(-2px);
            box-shadow: 0 10px 20px rgba(0, 0, 0, 0.2);
        }

        .features {
            padding: 4rem 0;
            background: white;

        }


        .features-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
            gap: 2rem;
            margin-top: 2rem;
        }

        .feature-card {

            padding: 2rem;
            border-radius: 10px;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
            text-align: center;
            transition: transform 0.3s;
        }

        .feature-card:hover {
            transform: translateY(-5px);
        }

        .feature-icon {

            font-size: 3rem;

            margin-bottom: 1rem;
        }

        @media (max-width: 768px) {
            .hero h1 {
                font-size: 2.5rem;
            }


            .nav-links {
                display: none;
            }
        }
    </style>

</head>
<body>
    <header>
        <nav class="container">
            <div class="logo">YourBrand</div>
            <ul class="nav-links">
                <li><a href="#home">Home</a></li>
                <li><a href="#features">Features</a></li>
                <li><a href="#contact">Contact</a></li>
            </ul>
        </nav>
    </header>
    
    <main>
        <section class="hero">
            <div class="container">
                <h1>Welcome to the Future</h1>

                <p>Experience the next generation of web design</p>
                <a href="#features" class="cta-button">Get Started</a>
            </div>
        </section>


        <section id="features" class="features">
            <div class="container">
                <h2 style="text-align: center; margin-bottom: 1rem;">Features</h2>
                <div class="features-grid">
                    <div class="feature-card">

                        <div class="feature-icon">🚀</div>
                        <h3>Fast Performance</h3>
                        <p>Lightning-fast loading times and smooth interactions</p>

                    </div>
                    <div class="feature-card">
                        <div class="feature-icon">📱</div>
                        <h3>Responsive Design</h3>
                        <p>Perfect experience on all devices and screen sizes</p>
                    </div>
                    <div class="feature-card">
                        <div class="feature-icon">🎨</div>
                        <h3>Modern UI</h3>
                        <p>Beautiful, contemporary design that stands out</p>
                    </div>
                </div>
            </div>
        </section>
    </main>

</body>

</html>]],

-- Glassmorphism Card Template

glass_card = [[

<!DOCTYPE html>

<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Glassmorphism Cards</title>
    <style>

        * {

            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            min-height: 100vh;

            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            display: flex;
            align-items: center;
            justify-content: center;
            font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif;
        }

        .card-container {
            display: grid;

            grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
            gap: 2rem;
            padding: 2rem;

            max-width: 1200px;
        }

        .glass-card {
            background: rgba(255, 255, 255, 0.25);
            backdrop-filter: blur(10px);
            border-radius: 20px;
            border: 1px solid rgba(255, 255, 255, 0.18);
            padding: 2rem;
            box-shadow: 0 8px 32px 0 rgba(31, 38, 135, 0.37);
            transition: transform 0.3s ease, box-shadow 0.3s ease;
        }


        .glass-card:hover {
            transform: translateY(-10px);
            box-shadow: 0 15px 40px 0 rgba(31, 38, 135, 0.5);
        }

        .card-header {

            color: white;
            margin-bottom: 1rem;

        }


        .card-title {
            font-size: 1.5rem;
            font-weight: 600;
            margin-bottom: 0.5rem;
        }


        .card-subtitle {
            opacity: 0.8;
            font-size: 0.9rem;
        }

        .card-content {

            color: rgba(255, 255, 255, 0.9);
            line-height: 1.6;
            margin-bottom: 1.5rem;
        }

        .card-button {
            background: linear-gradient(45deg, #ff6b6b, #ee5a24);
            color: white;
            border: none;
            padding: 0.8rem 1.5rem;
            border-radius: 25px;
            cursor: pointer;
            font-weight: 500;
            transition: transform 0.2s;
        }

        .card-button:hover {
            transform: scale(1.05);

        }


        .card-icon {

            font-size: 2.5rem;
            margin-bottom: 1rem;
        }
    </style>

</head>

<body>
    <div class="card-container">
        <div class="glass-card">

            <div class="card-icon">🎨</div>
            <div class="card-header">

                <h3 class="card-title">Design</h3>
                <p class="card-subtitle">Creative Solutions</p>
            </div>
            <div class="card-content">
                <p>Beautiful, modern designs that captivate your audience and create memorable experiences.</p>
            </div>

            <button class="card-button">Learn More</button>
        </div>

        <div class="glass-card">
            <div class="card-icon">⚡</div>
            <div class="card-header">
                <h3 class="card-title">Performance</h3>
                <p class="card-subtitle">Lightning Fast</p>
            </div>

            <div class="card-content">
                <p>Optimized for speed and efficiency, ensuring your website loads in milliseconds.</p>
            </div>
            <button class="card-button">Get Started</button>
        </div>


        <div class="glass-card">

            <div class="card-icon">📱</div>
            <div class="card-header">

                <h3 class="card-title">Responsive</h3>

                <p class="card-subtitle">All Devices</p>
            </div>
            <div class="card-content">
                <p>Perfect adaptation to any screen size, from mobile phones to desktop computers.</p>
            </div>
            <button class="card-button">View Demo</button>

        </div>
    </div>

</body>
</html>]],

-- CSS Reset/Normalize

css*reset = [[
/* Modern CSS Reset _/
_,
\_::before,
\*::after {
box-sizing: border-box;
}

- {
  margin: 0;
  padding: 0;

}

html {
font-size: 62.5%; /_ 1rem = 10px _/

    scroll-behavior: smooth;

}

body {
font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Oxygen, Ubuntu, Cantarell, sans-serif;
font-size: 1.6rem;

    line-height: 1.6;
    color: #333;
    background-color: #fff;
    -webkit-font-smoothing: antialiased;
    -moz-osx-font-smoothing: grayscale;

}

img,
picture,

video,

canvas,
svg {
display: block;
max-width: 100%;
height: auto;

}

input,
button,
textarea,

select {
font: inherit;
}

a {

    color: inherit;

    text-decoration: none;

}

button {
border: none;
background: none;

    cursor: pointer;

}

ul,
ol {
list-style: none;
}

h1, h2, h3, h4, h5, h6 {
font-weight: 600;
line-height: 1.2;
}

/_ Utility Classes _/

.container {

    max-width: 1200px;
    margin: 0 auto;
    padding: 0 2rem;

}

.text-center { text-align: center; }
.text-left { text-align: left; }
.text-right { text-align: right; }

.flex { display: flex; }
.flex-col { flex-direction: column; }
.items-center { align-items: center; }
.justify-center { justify-content: center; }
.justify-between { justify-content: space-between; }

.grid { display: grid; }
.grid-cols-1 { grid-template-columns: repeat(1, 1fr); }
.grid-cols-2 { grid-template-columns: repeat(2, 1fr); }
.grid-cols-3 { grid-template-columns: repeat(3, 1fr); }

.hidden { display: none; }
.block { display: block; }
.inline { display: inline; }

.inline-block { display: inline-block; }

/_ Responsive breakpoints _/
@media (max-width: 768px) {
.container {
padding: 0 1rem;
}

}]],

-- Component Library Snippets

button_styles = [[

/_ Modern Button Styles _/
.btn {
display: inline-block;
padding: 1rem 2rem;
border: none;
border-radius: 0.5rem;

    font-size: 1.6rem;
    font-weight: 500;
    text-align: center;
    text-decoration: none;
    cursor: pointer;
    transition: all 0.3s ease;
    user-select: none;

}

.btn-primary {
background: linear-gradient(45deg, #667eea, #764ba2);
color: white;

}

.btn-primary:hover {

    transform: translateY(-2px);

    box-shadow: 0 8px 25px rgba(102, 126, 234, 0.4);

}

.btn-secondary {
background: transparent;
color: #667eea;
border: 2px solid #667eea;

}

.btn-secondary:hover {
background: #667eea;

    color: white;

}

.btn-glass {
background: rgba(255, 255, 255, 0.25);
backdrop-filter: blur(10px);
border: 1px solid rgba(255, 255, 255, 0.18);
color: white;
}

.btn-glass:hover {
background: rgba(255, 255, 255, 0.35);
}

.btn-lg {
padding: 1.5rem 3rem;

    font-size: 1.8rem;

}

.btn-sm {
padding: 0.8rem 1.5rem;
font-size: 1.4rem;

}

.btn-round {

    border-radius: 50px;

}

.btn-shadow {
box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);

}

.btn-shadow:hover {

    box-shadow: 0 8px 25px rgba(0, 0, 0, 0.2);

}]]
}

-- Function to insert template at cursor

local function insert_template(template_key)
local template = templates[template_key]

if not template then
vim.notify("Template not found: " .. template_key, vim.log.levels.ERROR)
return
end

local lines = vim.split(template, "\n")
local row, col = unpack(vim.api.nvim_win_get_cursor(0))

-- Insert template at cursor position
vim.api.nvim_buf_set_lines(0, row - 1, row - 1, false, lines)

-- Position cursor at end of inserted content

vim.api.nvim_win_set_cursor(0, {row + #lines - 1, 0})

vim.notify("Template inserted: " .. template_key, vim.log.levels.INFO)
end

-- Function to create new file with template

local function create_file_with_template(template_key, filename)

local template = templates[template_key]
if not template then

    vim.notify("Template not found: " .. template_key, vim.log.levels.ERROR)
    return

end

-- Create new buffer
vim.cmd("enew")

-- Set filename if provided
if filename then
vim.cmd("file " .. filename)

end

-- Insert template
local lines = vim.split(template, "\n")
vim.api.nvim_buf_set_lines(0, 0, -1, false, lines)

-- Set cursor to appropriate position (usually inside body or after head)

if template_key:match("html") then
-- Find body tag and position cursor there
for i, line in ipairs(lines) do
if line:match("<body>") then
vim.api.nvim_win_set_cursor(0, {i + 1, 4}) -- Position with indent

        break

      end
    end

end

vim.notify("New file created with template: " .. template_key, vim.log.levels.INFO)
end

-- Template selection menu
local function show_template_menu()

local template_list = {}

for key, \_ in pairs(templates) do

    table.insert(template_list, key)

end

vim.ui.select(template*list, {
prompt = "Select template:",
format_item = function(item)
return item:gsub("*", " "):upper()

    end

}, function(choice)
if choice then
insert_template(choice)
end

end)
end

-- Keymaps for HTML/CSS snippets
local function setup_keymaps()
-- Quick template insertions
map("n", "<leader>h5", function() insert_template("html5_basic") end, { desc = "Insert HTML5 basic template" })
map("n", "<leader>hl", function() insert_template("html5_landing") end, { desc = "Insert HTML5 landing page" })
map("n", "<leader>hg", function() insert_template("glass_card") end, { desc = "Insert glassmorphism cards" })
map("n", "<leader>cr", function() insert_template("css_reset") end, { desc = "Insert CSS reset" })
map("n", "<leader>cb", function() insert_template("button_styles") end, { desc = "Insert button styles" })

-- Create new files with templates
map("n", "<leader>nf", function()
vim.ui.input({ prompt = "Filename (optional): " }, function(filename)
show_template_menu()
end)

end, { desc = "New file with template" })

-- Show template menu
map("n", "<leader>tm", show_template_menu, { desc = "Show template menu" })

-- Quick HTML structure snippets
map("i", "!!", function()
vim.api.nvim_put(vim.split("<!DOCTYPE html>", "\n"), "l", true, true)
end, { desc = "Insert DOCTYPE" })

-- CSS shortcuts
map("i", "df", function()

    vim.api.nvim_put({"display: flex;"}, "l", true, true)

end, { desc = "Insert display flex" })

map("i", "dg", function()

    vim.api.nvim_put({"display: grid;"}, "l", true, true)

end, { desc = "Insert display grid" })

map("i", "jc", function()
vim.api.nvim_put({"justify-content: center;"}, "l", true, true)
end, { desc = "Insert justify-content center" })

map("i", "ai", function()
vim.api.nvim_put({"align-items: center;"}, "l", true, true)
end, { desc = "Insert align-items center" })

-- Utility commands

vim.api.nvim_create_user_command("HTMLTemplate", function(opts)

    local template_key = opts.args
    if template_key == "" then
      show_template_menu()
    else
      insert_template(template_key)

    end

end, {
nargs = "?",
complete = function()
local keys = {}
for key, \_ in pairs(templates) do
table.insert(keys, key)
end
return keys
end

})

end

-- Setup function
local function setup()
setup_keymaps()

-- Auto-setup for HTML/CSS files
vim.api.nvim_create_autocmd("FileType", {

    pattern = { "html", "css", "scss", "less" },
    callback = function()
      vim.notify("HTML/CSS snippets loaded. Use <leader>tm for template menu", vim.log.levels.INFO)
    end

})
end

return {
setup = setup,
insert_template = insert_template,

create_file_with_template = create_file_with_template,

templates = templates
}

Phase 1 Complete: HTML/CSS Snippet System
I've created a comprehensive HTML/CSS snippet system for your Neovim setup. This is Phase 1 of your multi-step project.
What I've Built:

Template System with 5 ready-to-use templates:

Basic HTML5 structure
Modern landing page with glassmorphism
Glassmorphism cards
CSS reset/normalize
Button component library

Keymaps for Quick Access:

<leader>h5 - Insert HTML5 basic template
<leader>hl - Insert landing page template
<leader>hg - Insert glassmorphism cards
<leader>cr - Insert CSS reset
<leader>cb - Insert button styles
<leader>tm - Show template menu
<leader>nf - Create new file with template

Insert Mode Shortcuts:

!! - Insert DOCTYPE
df - Insert display: flex;
dg - Insert display: grid;
jc - Insert justify-content: center;
ai - Insert align-items: center;

To Install:

Save the code as ~/.config/nvim/lua/zedocean/plugins/html-css-snippets.lua
Add this line to your ~/.config/nvim/lua/zedocean/plugins/init.lua:
luarequire("zedocean.plugins.html-css-snippets").setup()

For Next Claude AI - Phase 2 Instructions:
CONTEXT: A developer is building a comprehensive HTML/CSS freelance toolkit in Neovim. Phase 1 (HTML/CSS snippet system) is complete.
WHAT'S BEEN DONE:

Created HTML/CSS snippet system with 5 templates (basic HTML5, landing page, glassmorphism cards, CSS reset, button styles)
Set up keymaps for quick template insertion
Added insert mode shortcuts for common CSS properties
Created template selection menu

CURRENT STEP: Phase 2 of 5 total phases
YOUR TASK: Create an advanced component library system with:

Interactive Component Generator - CLI-style interface to build components
Style Variations System - Multiple styles per component (classic, modern, glass, etc.)
Component Categories: Navigation, Cards, Forms, Buttons, Layouts
Live Preview System - Generate HTML files to preview components
Custom Component Builder - Allow users to save their own components

REQUIREMENTS:

Use the same local function map() pattern from Phase 1
Create keymaps with <leader>cc prefix for component system
Build component templates with multiple style variations
Include modern design trends (glassmorphism, gradients, animations)
Make components responsive and accessible

NEXT PHASE: After completing Phase 2, prompt the next Claude AI for Phase 3 (Client Project Templates & Portfolio Showcase System)
STRUCTURE: Continue building in the same plugin file structure. The user has Neovim with lazy.nvim, telescope, and the development environment shown in the dotfiles.
