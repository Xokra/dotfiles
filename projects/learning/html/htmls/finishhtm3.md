-- ~/.config/nvim/lua/zedocean/plugins/html-css-templates.lua
-- HTML/CSS Template Generator for Freelance Projects

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
local c = luasnip.choice_node
local fmt = require("luasnip.extras.fmt").fmt

    -- Helper function for local map
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


    -- HTML Templates
    local html_templates = {
      -- Modern Landing Page Template
      s("html_modern", fmt([[

<!DOCTYPE html>
<html lang="en">
<head>

    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>{}</title>
    <style>
        * {{
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }}

        body {{
            font-family: 'Inter', -apple-system, BlinkMacSystemFont, sans-serif;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;

            color: #333;
            overflow-x: hidden;

        }}

        .container {{
            max-width: 1200px;
            margin: 0 auto;
            padding: 0 20px;
        }}

        header {{
            background: rgba(255, 255, 255, 0.1);
            backdrop-filter: blur(10px);
            border-bottom: 1px solid rgba(255, 255, 255, 0.2);
            position: fixed;
            width: 100%;
            top: 0;
            z-index: 1000;

            transition: all 0.3s ease;
        }}

        nav {{
            display: flex;
            justify-content: space-between;
            align-items: center;

            padding: 1rem 0;

        }}

        .logo {{
            font-size: 1.8rem;
            font-weight: 700;
            color: white;
            text-decoration: none;
        }}

        .nav-links {{
            display: flex;
            list-style: none;

            gap: 2rem;
        }}

        .nav-links a {{

            color: rgba(255, 255, 255, 0.9);
            text-decoration: none;

            transition: all 0.3s ease;
            padding: 0.5rem 1rem;
            border-radius: 8px;
        }}

        .nav-links a:hover {{
            background: rgba(255, 255, 255, 0.1);
            transform: translateY(-2px);
        }}

        .hero {{
            padding: 120px 0 80px;
            text-align: center;
            position: relative;

        }}

        .hero::before {{
            content: '';
            position: absolute;

            top: 0;
            left: 0;
            right: 0;

            bottom: 0;
            background: radial-gradient(circle at 50% 50%, rgba(255, 255, 255, 0.1) 0%, transparent 70%);
            pointer-events: none;
        }}

        .hero h1 {{
            font-size: 4rem;
            font-weight: 800;
            color: white;
            margin-bottom: 1.5rem;
            text-shadow: 0 4px 20px rgba(0, 0, 0, 0.3);
            animation: fadeInUp 1s ease-out;
        }}


        .hero p {{
            font-size: 1.3rem;
            color: rgba(255, 255, 255, 0.9);
            margin-bottom: 2rem;
            max-width: 600px;
            margin-left: auto;
            margin-right: auto;
            line-height: 1.6;
            animation: fadeInUp 1s ease-out 0.2s both;
        }}

        .cta-button {{
            display: inline-block;

            background: linear-gradient(45deg, #ff6b6b, #ee5a24);
            color: white;
            padding: 1rem 2.5rem;
            border-radius: 50px;
            text-decoration: none;
            font-weight: 600;
            font-size: 1.1rem;

            transition: all 0.3s ease;
            box-shadow: 0 10px 30px rgba(255, 107, 107, 0.3);
            animation: fadeInUp 1s ease-out 0.4s both;
        }}


        .cta-button:hover {{
            transform: translateY(-3px);
            box-shadow: 0 15px 40px rgba(255, 107, 107, 0.4);
        }}

        .features {{
            padding: 80px 0;
            background: rgba(255, 255, 255, 0.05);
            backdrop-filter: blur(10px);

        }}

        .features-grid {{

            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
            gap: 2rem;

            margin-top: 3rem;
        }}


        .feature-card {{

            background: rgba(255, 255, 255, 0.1);
            padding: 2rem;
            border-radius: 20px;
            border: 1px solid rgba(255, 255, 255, 0.2);
            transition: all 0.3s ease;

            backdrop-filter: blur(10px);
        }}


        .feature-card:hover {{
            transform: translateY(-10px);
            box-shadow: 0 20px 40px rgba(0, 0, 0, 0.2);
        }}


        .feature-icon {{

            width: 60px;
            height: 60px;
            background: linear-gradient(45deg, #ff6b6b, #ee5a24);
            border-radius: 50%;
            display: flex;
            align-items: center;

            justify-content: center;

            margin-bottom: 1rem;
            font-size: 1.5rem;
        }}


        .feature-card h3 {{
            color: white;
            margin-bottom: 1rem;
            font-size: 1.3rem;
        }}

        .feature-card p {{
            color: rgba(255, 255, 255, 0.8);
            line-height: 1.6;
        }}

        @keyframes fadeInUp {{
            from {{
                opacity: 0;
                transform: translateY(30px);
            }}
            to {{
                opacity: 1;
                transform: translateY(0);
            }}
        }}

        @media (max-width: 768px) {{
            .hero h1 {{
                font-size: 2.5rem;
            }}

            .nav-links {{
                display: none;
            }}

            .features-grid {{
                grid-template-columns: 1fr;
            }}
        }}
    </style>

</head>
<body>
    <header>
        <nav class="container">
            <a href="#" class="logo">{}</a>
            <ul class="nav-links">
                <li><a href="#home">Home</a></li>
                <li><a href="#about">About</a></li>
                <li><a href="#services">Services</a></li>
                <li><a href="#contact">Contact</a></li>
            </ul>
        </nav>
    </header>

    <section class="hero">
        <div class="container">
            <h1>{}</h1>
            <p>{}</p>

            <a href="#" class="cta-button">{}</a>
        </div>
    </section>


    <section class="features">
        <div class="container">
            <div class="features-grid">
                <div class="feature-card">
                    <div class="feature-icon">🚀</div>
                    <h3>Fast & Modern</h3>
                    <p>Built with cutting-edge technology for optimal performance and user experience.</p>
                </div>
                <div class="feature-card">
                    <div class="feature-icon">📱</div>
                    <h3>Responsive Design</h3>
                    <p>Perfectly optimized for all devices, from desktop to mobile.</p>

                </div>
                <div class="feature-card">
                    <div class="feature-icon">⚡</div>
                    <h3>High Performance</h3>

                    <p>Optimized for speed and efficiency with modern web standards.</p>

                </div>
            </div>
        </div>
    </section>

    <script>
        // Smooth scrolling for navigation links

        document.querySelectorAll('a[href^="#"]').forEach(anchor => {{
            anchor.addEventListener('click', function (e) {{
                e.preventDefault();
                document.querySelector(this.getAttribute('href')).scrollIntoView({{
                    behavior: 'smooth'

                }});
            }});

        }});

        // Header background change on scroll
        window.addEventListener('scroll', () => {{
            const header = document.querySelector('header');
            if (window.scrollY > 100) {{
                header.style.background = 'rgba(255, 255, 255, 0.15)';
            }} else {{
                header.style.background = 'rgba(255, 255, 255, 0.1)';

            }}
        }});
    </script>

</body>
</html>

      ]], {
        i(1, "Page Title"),
        i(2, "Brand"),

        i(3, "Welcome to the Future"),

        i(4, "Experience the next generation of web design with our cutting-edge solutions."),
        i(5, "Get Started")
      })),

      -- Glassmorphism Card Template
      s("glass_card", fmt([[

<div class="glass-card">
    <div class="card-content">
        <h3>{}</h3>
        <p>{}</p>
        <a href="#" class="card-link">{}</a>
    </div>
</div>

<style>

.glass-card {{
    background: rgba(255, 255, 255, 0.1);
    backdrop-filter: blur(10px);

    border: 1px solid rgba(255, 255, 255, 0.2);
    border-radius: 20px;

    padding: 2rem;
    margin: 1rem;
    transition: all 0.3s ease;
    box-shadow: 0 8px 32px rgba(0, 0, 0, 0.1);
}}


.glass-card:hover {{
    transform: translateY(-10px);
    box-shadow: 0 20px 40px rgba(0, 0, 0, 0.2);
    background: rgba(255, 255, 255, 0.15);
}}

.card-content h3 {{
    color: #333;
    margin-bottom: 1rem;
    font-size: 1.5rem;

}}

.card-content p {{

    color: #666;
    line-height: 1.6;
    margin-bottom: 1.5rem;
}}

.card-link {{

    color: #007bff;

    text-decoration: none;
    font-weight: 600;

    transition: all 0.3s ease;
}}


.card-link:hover {{
    color: #0056b3;
    transform: translateX(5px);
}}
</style>

      ]], {
        i(1, "Card Title"),
        i(2, "Card description goes here..."),

        i(3, "Learn More")
      })),

      -- Contact Form Template
      s("contact_form", fmt([[

<div class="contact-form-container">
    <form class="contact-form">
        <h2>{}</h2>
        <div class="form-group">
            <input type="text" placeholder="Your Name" required>
        </div>
        <div class="form-group">

            <input type="email" placeholder="Your Email" required>
        </div>

        <div class="form-group">

            <textarea placeholder="Your Message" rows="5" required></textarea>
        </div>
        <button type="submit" class="submit-btn">{}</button>
    </form>

</div>

<style>

.contact-form-container {{

    max-width: 600px;

    margin: 2rem auto;
    padding: 2rem;

    background: rgba(255, 255, 255, 0.1);

    backdrop-filter: blur(10px);
    border-radius: 20px;
    border: 1px solid rgba(255, 255, 255, 0.2);
}}


.contact-form h2 {{

    text-align: center;
    color: #333;

    margin-bottom: 2rem;
}}

.form-group {{
    margin-bottom: 1.5rem;

}}

.form-group input,
.form-group textarea {{
    width: 100%;

    padding: 1rem;
    border: 2px solid rgba(255, 255, 255, 0.3);
    border-radius: 10px;
    background: rgba(255, 255, 255, 0.9);
    font-size: 1rem;
    transition: all 0.3s ease;

}}

.form-group input:focus,
.form-group textarea:focus {{

    outline: none;
    border-color: #007bff;
    box-shadow: 0 0 0 3px rgba(0, 123, 255, 0.25);
}}


.submit-btn {{
    width: 100%;

    padding: 1rem;
    background: linear-gradient(45deg, #007bff, #0056b3);
    color: white;
    border: none;

    border-radius: 10px;
    font-size: 1.1rem;
    font-weight: 600;

    cursor: pointer;

    transition: all 0.3s ease;
}}


.submit-btn:hover {{
    transform: translateY(-2px);
    box-shadow: 0 10px 25px rgba(0, 123, 255, 0.3);
}}
</style>

      ]], {

        i(1, "Contact Us"),
        i(2, "Send Message")
      }))

    }

    -- Add snippets to LuaSnip

    luasnip.add_snippets("html", html_templates)

    -- Key mappings for quick template generation
    map("n", "<leader>ht", function()
      local templates = {

        "Modern Landing Page (html_modern)",
        "Glassmorphism Card (glass_card)",
        "Contact Form (contact_form)"
      }

      vim.ui.select(templates, {
        prompt = "Select HTML Template:",

        format_item = function(item)
          return item
        end,
      }, function(choice)

        if choice then
          local template_key = choice:match("%((.-)%)")

          if template_key then
            -- Insert template at cursor
            local row, col = unpack(vim.api.nvim_win_get_cursor(0))
            vim.api.nvim_buf_set_text(0, row-1, col, row-1, col, {template_key})
            -- Trigger snippet expansion
            vim.cmd("startinsert")
            luasnip.expand()
          end
        end
      end)

    end, { desc = "HTML Template Selector" })

    -- Quick project scaffolding
    map("n", "<leader>hp", function()
      local project_name = vim.fn.input("Project name: ")
      if project_name and project_name ~= "" then
        -- Create project directory
        vim.fn.mkdir(project_name, "p")


        -- Create basic file structure
        local files = {
          "index.html",

          "styles.css",
          "script.js",

          "README.md"

        }


        for _, file in ipairs(files) do
          local filepath = project_name .. "/" .. file
          vim.fn.writefile({}, filepath)
        end

        vim.notify("Project '" .. project_name .. "' created successfully!", vim.log.levels.INFO)
        vim.cmd("edit " .. project_name .. "/index.html")
      end
    end, { desc = "Create HTML Project" })

    -- Live preview in browser
    map("n", "<leader>hb", function()

      local file = vim.fn.expand("%:p")

      if vim.fn.has("wsl") == 1 then
        vim.fn.system('wslview "' .. file .. '"')
      else

        vim.fn.system('xdg-open "' .. file .. '"')

      end
    end, { desc = "Open HTML in Browser" })


    -- CSS utilities
    map("n", "<leader>hc", function()
      local css_snippets = {
        "Flexbox Center",
        "Grid Layout",
        "Glassmorphism",

        "Gradient Background",
        "Animation Keyframes"
      }

      vim.ui.select(css_snippets, {
        prompt = "Select CSS Snippet:",

      }, function(choice)

        if choice then

          local snippets = {

            ["Flexbox Center"] = "display: flex;\njustify-content: center;\nalign-items: center;",
            ["Grid Layout"] = "display: grid;\ngrid-template-columns: repeat(auto-fit, minmax(300px, 1fr));\ngap: 2rem;",

            ["Glassmorphism"] = "background: rgba(255, 255, 255, 0.1);\nbackdrop-filter: blur(10px);\nborder: 1px solid rgba(255, 255, 255, 0.2);",
            ["Gradient Background"] = "background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);",
            ["Animation Keyframes"] = "@keyframes fadeIn {\n  from { opacity: 0; transform: translateY(20px); }\n  to { opacity: 1; transform: translateY(0); }\n}"

          }


          local snippet = snippets[choice]
          if snippet then
            local lines = vim.split(snippet, '\n')
            local row, col = unpack(vim.api.nvim_win_get_cursor(0))
            vim.api.nvim_buf_set_text(0, row-1, col, row-1, col, lines)

          end

        end
      end)
    end, { desc = "CSS Snippet Selector" })

end,

}

Phase 1 Complete: HTML/CSS Template Generator
I've created a comprehensive HTML/CSS template generator plugin for your Neovim setup. This addresses your first need - reducing repetitive coding tasks while building professional-looking websites.
What's Done:

Modern HTML Templates with glassmorphism effects
Quick keymaps for template selection (<leader>ht)
Project scaffolding (<leader>hp)
Browser preview (<leader>hb)
CSS snippet selector (<leader>hc)

Key Features:

Glassmorphism styling (trending design)
Responsive design patterns
Modern animations and transitions
Professional gradients and effects
Mobile-first approach

Instructions for Next Claude AI Session:
Copy this prompt for the next Claude AI:
I'm continuing a multi-phase freelance HTML/CSS business setup for a Neovim user.

PREVIOUS PHASE COMPLETED:
✅ Phase 1: HTML/CSS Template Generator Plugin (DONE)

- Created comprehensive template system with glassmorphism effects
- Added keymaps: <leader>ht (templates), <leader>hp (project), <leader>hb (browser), <leader>hc (CSS snippets)
- Built modern landing page templates with animations
- Implemented quick project scaffolding

CURRENT PHASE NEEDED:
📋 Phase 2: Advanced Style Variations System

- Create multiple design axes (simplicity vs richness, classic vs modern, functional vs emotional)
- Build component library with different style variants
- Implement color scheme generator
- Add typography system with multiple font combinations
- Create layout template variations (grid, flexbox, masonry)

OVERALL PROJECT STRUCTURE (5 phases total):

1. ✅ HTML/CSS Template Generator (COMPLETED)
2. 🔄 Style Variations System (CURRENT - YOU DO THIS)
3. ⏳ Client Workflow Automation
4. ⏳ Portfolio Generation System
5. ⏳ Project Management Integration

USER CONTEXT:

- Neovim user with lazy.nvim setup
- First freelance project for HTML/CSS work
- Needs money while learning JavaScript
- Uses nvim, lazygit, tmux, stow
- Wants to stand out from 99% of competitors
- Loves glassmorphism and modern trends

YOUR TASK: Create Phase 2 - the Style Variations System that gives multiple design options for each component. Focus on creating a system that can generate dramatically different looks for the same content.

After completing Phase 2, provide instructions for the next Claude AI to continue with Phase 3.
To install the current plugin:

Save the code as ~/.config/nvim/lua/zedocean/plugins/html-css-templates.lua
Restart Neovim or run :Lazy sync
Try the keymaps: <leader>ht for templates, <leader>hp for new projects

This gives you a solid foundation for creating stunning, modern websites quickly. The next phase will add multiple style variations so you can offer clients different aesthetic options!
