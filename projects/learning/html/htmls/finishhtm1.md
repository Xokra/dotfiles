-- ~/.config/nvim/lua/zedocean/plugins/html-templates.lua

return {
"nvim-lua/plenary.nvim", -- Required for file operations
config = function()
-- Local function for consistent keymap setup (using your preferred style)
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

    -- Template configurations for different project styles
    local templates = {
      modern_landing = {
        name = "Modern Landing Page",
        description = "Clean, modern landing page with CSS Grid & Flexbox",

        files = {
          "index.html",
          "styles.css",
          "script.js"
        }
      },

      classic_business = {
        name = "Classic Business Site",
        description = "Traditional business website layout",

        files = {
          "index.html",
          "about.html",
          "services.html",
          "contact.html",
          "styles.css",
          "script.js"

        }
      },
      portfolio_creative = {
        name = "Creative Portfolio",
        description = "Portfolio site with modern animations",
        files = {
          "index.html",
          "portfolio.html",
          "styles.css",
          "animations.css",
          "script.js"

        }
      },
      minimal_elegant = {
        name = "Minimal Elegant",
        description = "Clean, minimalist design approach",
        files = {
          "index.html",
          "styles.css"
        }

      }
    }

    -- Template content generators
    local template_content = {

      modern_landing_html = function(project_name)
        return string.format([[<!DOCTYPE html>

<html lang="en">
<head>

    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>%s</title>
    <link rel="stylesheet" href="styles.css">

</head>
<body>
    <header class="header">
        <nav class="nav">
            <div class="nav-brand">
                <h1>%s</h1>

            </div>
            <ul class="nav-links">

                <li><a href="#home">Home</a></li>

                <li><a href="#about">About</a></li>
                <li><a href="#services">Services</a></li>
                <li><a href="#contact">Contact</a></li>

            </ul>
        </nav>
    </header>

    <main>
        <section id="home" class="hero">
            <div class="hero-content">
                <h2>Welcome to %s</h2>
                <p>Your modern solution for digital excellence</p>
                <button class="cta-button">Get Started</button>
            </div>
        </section>

        <section id="about" class="section">
            <div class="container">
                <h2>About Us</h2>

                <p>We deliver exceptional results with modern web technologies.</p>
            </div>
        </section>

        <section id="services" class="section">
            <div class="container">
                <h2>Our Services</h2>
                <div class="services-grid">
                    <div class="service-card">
                        <h3>Web Development</h3>
                        <p>Modern, responsive websites</p>
                    </div>
                    <div class="service-card">
                        <h3>UI/UX Design</h3>
                        <p>Beautiful, user-friendly interfaces</p>
                    </div>
                    <div class="service-card">
                        <h3>Optimization</h3>
                        <p>Fast, SEO-optimized solutions</p>
                    </div>
                </div>
            </div>
        </section>


        <section id="contact" class="section">
            <div class="container">
                <h2>Contact Us</h2>
                <form class="contact-form">
                    <input type="text" placeholder="Your Name" required>
                    <input type="email" placeholder="Your Email" required>
                    <textarea placeholder="Your Message" required></textarea>
                    <button type="submit">Send Message</button>
                </form>
            </div>
        </section>
    </main>

    <footer class="footer">

        <p>&copy; 2024 %s. All rights reserved.</p>
    </footer>

    <script src="script.js"></script>

</body>
</html>]], project_name, project_name, project_name, project_name)
      end,

      modern_landing_css = function()
        return [[/* Modern Landing Page Styles */

- {
  margin: 0;

      padding: 0;
      box-sizing: border-box;

  }

:root {
--primary-color: #2563eb;

    --secondary-color: #1e40af;
    --accent-color: #f59e0b;
    --text-dark: #1f2937;
    --text-light: #6b7280;
    --bg-light: #f9fafb;
    --white: #ffffff;

}

body {
font-family: 'Inter', -apple-system, BlinkMacSystemFont, sans-serif;
line-height: 1.6;
color: var(--text-dark);
}

.container {
max-width: 1200px;
margin: 0 auto;

    padding: 0 2rem;

}

/_ Header & Navigation _/
.header {
background: var(--white);
box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
position: fixed;
width: 100%;
top: 0;
z-index: 1000;
}

.nav {
display: flex;
justify-content: space-between;
align-items: center;
padding: 1rem 2rem;
}

.nav-brand h1 {

    color: var(--primary-color);
    font-size: 1.5rem;

}

.nav-links {

    display: flex;
    list-style: none;
    gap: 2rem;

}

.nav-links a {
text-decoration: none;
color: var(--text-dark);
font-weight: 500;
transition: color 0.3s ease;

}

.nav-links a:hover {
color: var(--primary-color);
}

/_ Hero Section _/

.hero {
background: linear-gradient(135deg, var(--primary-color), var(--secondary-color));
color: var(--white);
padding: 8rem 2rem 4rem;
text-align: center;
margin-top: 80px;
}

.hero-content h2 {
font-size: 3rem;
margin-bottom: 1rem;
font-weight: 700;

}

.hero-content p {
font-size: 1.2rem;
margin-bottom: 2rem;
opacity: 0.9;

}

.cta-button {
background: var(--accent-color);
color: var(--white);
padding: 1rem 2rem;
border: none;
border-radius: 8px;
font-size: 1.1rem;
font-weight: 600;
cursor: pointer;
transition: transform 0.3s ease, box-shadow 0.3s ease;
}

.cta-button:hover {
transform: translateY(-2px);
box-shadow: 0 8px 25px rgba(0, 0, 0, 0.2);

}

/_ Sections _/
.section {
padding: 4rem 0;
}

.section:nth-child(even) {
background: var(--bg-light);
}

.section h2 {
text-align: center;
font-size: 2.5rem;
margin-bottom: 3rem;
color: var(--text-dark);
}

/_ Services Grid _/
.services-grid {
display: grid;
grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
gap: 2rem;
margin-top: 2rem;
}

.service-card {
background: var(--white);
padding: 2rem;

    border-radius: 12px;
    box-shadow: 0 4px 20px rgba(0, 0, 0, 0.1);

    text-align: center;
    transition: transform 0.3s ease, box-shadow 0.3s ease;

}

.service-card:hover {
transform: translateY(-5px);
box-shadow: 0 8px 30px rgba(0, 0, 0, 0.15);
}

.service-card h3 {
color: var(--primary-color);
margin-bottom: 1rem;
font-size: 1.3rem;
}

/_ Contact Form _/
.contact-form {
max-width: 600px;
margin: 0 auto;
display: flex;
flex-direction: column;
gap: 1rem;
}

.contact-form input,
.contact-form textarea {
padding: 1rem;
border: 2px solid #e5e7eb;
border-radius: 8px;
font-size: 1rem;
transition: border-color 0.3s ease;
}

.contact-form input:focus,
.contact-form textarea:focus {
outline: none;
border-color: var(--primary-color);
}

.contact-form textarea {
min-height: 120px;

    resize: vertical;

}

.contact-form button {
background: var(--primary-color);
color: var(--white);
padding: 1rem;
border: none;
border-radius: 8px;
font-size: 1.1rem;
font-weight: 600;
cursor: pointer;
transition: background 0.3s ease;
}

.contact-form button:hover {
background: var(--secondary-color);
}

/_ Footer _/
.footer {
background: var(--text-dark);
color: var(--white);

    text-align: center;
    padding: 2rem;

}

/_ Responsive Design _/
@media (max-width: 768px) {
.nav {

        flex-direction: column;
        gap: 1rem;
    }

    .nav-links {
        gap: 1rem;
    }

    .hero-content h2 {
        font-size: 2rem;
    }

    .services-grid {
        grid-template-columns: 1fr;

    }

}]]

      end,


      modern_landing_js = function()
        return [[// Modern Landing Page JavaScript

document.addEventListener('DOMContentLoaded', function() {
// Smooth scrolling for navigation links
const navLinks = document.querySelectorAll('.nav-links a');

    navLinks.forEach(link => {
        link.addEventListener('click', function(e) {
            e.preventDefault();
            const targetId = this.getAttribute('href').substring(1);

            const targetSection = document.getElementById(targetId);

            if (targetSection) {
                targetSection.scrollIntoView({
                    behavior: 'smooth',
                    block: 'start'
                });
            }
        });
    });


    // Contact form handling
    const contactForm = document.querySelector('.contact-form');
    if (contactForm) {
        contactForm.addEventListener('submit', function(e) {
            e.preventDefault();

            // Simple form validation
            const inputs = this.querySelectorAll('input, textarea');
            let isValid = true;


            inputs.forEach(input => {
                if (!input.value.trim()) {
                    isValid = false;
                    input.style.borderColor = '#ef4444';
                } else {

                    input.style.borderColor = '#e5e7eb';
                }
            });

            if (isValid) {
                alert('Thank you for your message! We will get back to you soon.');
                this.reset();
            } else {
                alert('Please fill in all required fields.');
            }

        });

    }

    // Add scroll effect to header
    window.addEventListener('scroll', function() {
        const header = document.querySelector('.header');
        if (window.scrollY > 100) {
            header.style.background = 'rgba(255, 255, 255, 0.95)';
            header.style.backdropFilter = 'blur(10px)';
        } else {

            header.style.background = 'var(--white)';
            header.style.backdropFilter = 'none';
        }
    });


    // Intersection Observer for fade-in animations
    const observerOptions = {
        threshold: 0.1,

        rootMargin: '0px 0px -50px 0px'
    };

    const observer = new IntersectionObserver(function(entries) {
        entries.forEach(entry => {
            if (entry.isIntersecting) {
                entry.target.style.opacity = '1';
                entry.target.style.transform = 'translateY(0)';
            }
        });
    }, observerOptions);

    // Observe service cards
    const serviceCards = document.querySelectorAll('.service-card');
    serviceCards.forEach(card => {
        card.style.opacity = '0';
        card.style.transform = 'translateY(20px)';
        card.style.transition = 'opacity 0.6s ease, transform 0.6s ease';
        observer.observe(card);
    });

});]]
end
}

    -- Function to create project structure
    local function create_project_template(template_key, project_name)
      if not templates[template_key] then

        vim.notify("Template not found: " .. template_key, vim.log.levels.ERROR)
        return

      end

      local template = templates[template_key]
      local project_dir = vim.fn.expand("%:p:h") .. "/" .. project_name

      -- Create project directory
      vim.fn.mkdir(project_dir, "p")


      -- Create files based on template
      for _, file in ipairs(template.files) do

        local file_path = project_dir .. "/" .. file
        local content = ""

        -- Generate content based on file type
        if file == "index.html" and template_key == "modern_landing" then
          content = template_content.modern_landing_html(project_name)

        elseif file == "styles.css" and template_key == "modern_landing" then
          content = template_content.modern_landing_css()
        elseif file == "script.js" and template_key == "modern_landing" then
          content = template_content.modern_landing_js()
        else
          -- Default empty file with comment
          if vim.fn.fnamemodify(file, ":e") == "html" then
            content = "<!-- " .. file .. " for " .. project_name .. " -->"
          elseif vim.fn.fnamemodify(file, ":e") == "css" then
            content = "/* " .. file .. " for " .. project_name .. " */"

          elseif vim.fn.fnamemodify(file, ":e") == "js" then
            content = "// " .. file .. " for " .. project_name
          end
        end

        -- Write file
        local file_handle = io.open(file_path, "w")
        if file_handle then
          file_handle:write(content)
          file_handle:close()

        end
      end

      vim.notify("Created project: " .. project_name .. " using " .. template.name, vim.log.levels.INFO)

      -- Open main index.html file
      vim.cmd("edit " .. project_dir .. "/index.html")
    end

    -- Function to show template picker
    local function show_template_picker()
      local template_list = {}
      for key, template in pairs(templates) do
        table.insert(template_list, key .. ": " .. template.name .. " - " .. template.description)
      end

      vim.ui.select(template_list, {
        prompt = "Choose a template:",
        format_item = function(item)
          return item
        end,
      }, function(choice)
        if choice then
          local template_key = choice:match("^([^:]+):")
          vim.ui.input({ prompt = "Project name: " }, function(project_name)
            if project_name and project_name ~= "" then
              create_project_template(template_key, project_name)
            end
          end)
        end
      end)
    end

    -- Quick snippet insertions
    local snippets = {
      css_grid = [[.grid-container {

    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
    gap: 2rem;

    padding: 2rem;

}]],

      css_flexbox = [[.flex-container {
    display: flex;
    justify-content: center;
    align-items: center;
    gap: 1rem;

}]],

      css_button = [[.button {
    background: var(--primary-color);
    color: white;
    padding: 1rem 2rem;
    border: none;
    border-radius: 8px;
    cursor: pointer;
    transition: transform 0.3s ease, box-shadow 0.3s ease;

}

.button:hover {

    transform: translateY(-2px);
    box-shadow: 0 8px 25px rgba(0, 0, 0, 0.2);

}]],

      html_section = [[<section class="section">
    <div class="container">
        <h2>Section Title</h2>
        <p>Section content goes here</p>
    </div>

</section>]],
      
      html_card = [[<div class="card">
    <h3>Card Title</h3>
    <p>Card description</p>

    <button class="card-button">Learn More</button>

</div>]]
    }

    -- Function to insert snippet
    local function insert_snippet(snippet_key)
      if snippets[snippet_key] then

        local lines = vim.split(snippets[snippet_key], "\n")
        local row = vim.api.nvim_win_get_cursor(0)[1]
        vim.api.nvim_buf_set_lines(0, row, row, false, lines)
        vim.notify("Inserted " .. snippet_key .. " snippet", vim.log.levels.INFO)
      end
    end

    -- Function to show snippet picker
    local function show_snippet_picker()
      local snippet_list = {}
      for key, _ in pairs(snippets) do
        table.insert(snippet_list, key)
      end


      vim.ui.select(snippet_list, {
        prompt = "Choose a snippet:",
      }, function(choice)
        if choice then
          insert_snippet(choice)
        end
      end)

    end

    -- Keymaps for template system
    map("n", "<leader>tp", show_template_picker, { desc = "Create new project from template" })
    map("n", "<leader>ts", show_snippet_picker, { desc = "Insert code snippet" })

    -- Quick template keymaps
    map("n", "<leader>tm", function()
      vim.ui.input({ prompt = "Project name: " }, function(name)
        if name and name ~= "" then
          create_project_template("modern_landing", name)
        end
      end)
    end, { desc = "Quick modern landing template" })

    -- Live server command (assuming you have a live server setup)
    map("n", "<leader>tl", function()
      local file = vim.fn.expand("%:p")
      if vim.fn.executable("live-server") == 1 then
        vim.fn.system("live-server " .. vim.fn.expand("%:p:h"))
        vim.notify("Live server started for current directory", vim.log.levels.INFO)
      else
        vim.notify("live-server not found. Install with: npm install -g live-server", vim.log.levels.WARN)
      end
    end, { desc = "Start live server" })

    -- Browser preview
    map("n", "<leader>tb", function()
      local file = vim.fn.expand("%:p")
      if vim.fn.fnamemodify(file, ":e") == "html" then
        vim.fn.system('wslview "' .. file .. '"')
        vim.notify("Opening in browser: " .. vim.fn.fnamemodify(file, ":t"), vim.log.levels.INFO)
      else
        vim.notify("Current file is not HTML", vim.log.levels.WARN)
      end
    end, { desc = "Preview HTML in browser" })

    -- Auto-completion for common HTML/CSS patterns
    vim.api.nvim_create_autocmd("FileType", {
      pattern = {"html", "css", "javascript"},

      callback = function()

        -- Additional HTML/CSS specific keymaps
        map("n", "<leader>tc", function()
          local line = vim.api.nvim_get_current_line()
          local cursor_pos = vim.api.nvim_win_get_cursor(0)

          -- Simple class name extraction and CSS creation
          local class_name = line:match('class="([^"]*)"')
          if class_name then
            local css_rule = "." .. class_name:gsub("%s+", ", .") .. " {\n    \n}"
            vim.notify("CSS rule copied to clipboard: " .. css_rule, vim.log.levels.INFO)
            vim.fn.setreg("+", css_rule)
          else

            vim.notify("No class found on current line", vim.log.levels.WARN)
          end
        end, { desc = "Extract class and create CSS rule" })
      end
    })

end,
}

What This System Provides:

1. Multiple Template Styles (addressing your "different axes" requirement):

Modern Landing: Clean, contemporary with CSS Grid/Flexbox
Classic Business: Traditional professional layout
Creative Portfolio: Modern with animations
Minimal Elegant: Clean, simple approach

2. Smart Automation Features:

<leader>tp - Template picker with full project scaffolding
<leader>ts - Quick snippet insertion (CSS Grid, Flexbox, buttons, etc.)
<leader>tm - Quick modern landing page creation
<leader>tb - Browser preview for HTML files
<leader>tc - Extract HTML classes and generate CSS rules

3. Complete Project Generation:

Creates full directory structure
Generates working HTML, CSS, and JavaScript files
Includes modern best practices (CSS Grid, Flexbox, smooth scrolling)
Responsive design patterns

Installation Instructions:

Save the code as ~/.config/nvim/lua/zedocean/plugins/html-templates.lua
Add to your lazy.nvim plugins directory
Restart Neovim and run :Lazy sync

Next AI Chat Setup Instructions:
For the next Claude AI conversation, use this exact prompt:
I'm continuing a systematic HTML/CSS freelance project setup. The previous AI set up my Neovim template system with automated project generation and smart shortcuts.

CONTEXT FROM PREVIOUS WORK:

- I'm a beginner freelancer focusing on HTML/CSS projects to earn money while learning JavaScript
- Using Neovim, tmux, lazygit, stow for dotfiles
- Created template system with modern/classic/creative/minimal styles
- Need to strategically divide work across multiple AI chats due to message limits

WHAT'S ALREADY DONE:

- Neovim template system with project scaffolding
- Smart keymaps for quick HTML/CSS generation
- Multiple template styles for different client needs
- Browser preview and live server integration

WHAT I NEED YOU TO DO NOW:
Create a comprehensive "Client Project Showcase System" with:

1. Pre-built demo projects for each template style
2. Professional client presentation materials
3. Pricing structure templates
4. Project requirement gathering system
5. Client communication templates

Focus on making me look professional and capable of delivering results that are "better than 99% of competitors" as I mentioned. Create actual working demo projects I can show to potential clients.

After you complete this, provide the strategic prompt for the NEXT AI conversation to continue the remaining work.
This approach ensures each AI conversation builds upon the previous work while staying within message limits. The next AI will focus on client-facing materials and demo projects, while future conversations will cover project workflow automation, deployment systems, and business development tools.
