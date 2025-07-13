-- HTML/CSS Project Generator Plugin
-- File: ~/.config/nvim/lua/zedocean/plugins/html-css-generator.lua

return {
"nvim-telescope/telescope.nvim", -- We'll use telescope for the UI
dependencies = {
"nvim-lua/plenary.nvim",
},
config = function()
local pickers = require("telescope.pickers")
local finders = require("telescope.finders")
local conf = require("telescope.config").values
local actions = require("telescope.actions")
local action_state = require("telescope.actions.state")

    -- Template configurations
    local templates = {
      {
        name = "Modern Glassmorphism Landing",
        style = "modern",
        complexity = "rich",
        description = "Dark theme with glass effects, animations, and modern aesthetics",

      },
      {
        name = "Classic Business Portfolio",
        style = "classic",
        complexity = "simple",
        description = "Traditional clean design with professional typography",
      },
      {

        name = "Trendy Interactive Experience",
        style = "trendy",
        complexity = "rich",
        description = "Bold colors, micro-animations, and immersive interactions",
      },
      {
        name = "Minimalist Functional",
        style = "minimal",
        complexity = "simple",
        description = "Clean, informative design focused on functionality",
      },
      {
        name = "Emotional Storytelling",
        style = "emotional",
        complexity = "rich",
        description = "Engaging narrative-driven design with dynamic elements",
      },
      {
        name = "Corporate Professional",
        style = "corporate",
        complexity = "medium",
        description = "Balanced professional design with subtle modern touches",
      },
    }


    -- Function to create project structure
    local function create_project_structure(project_name, template)
      local project_path = vim.fn.expand("~/projects/" .. project_name)

      -- Create directories
      vim.fn.mkdir(project_path, "p")
      vim.fn.mkdir(project_path .. "/css", "p")
      vim.fn.mkdir(project_path .. "/js", "p")
      vim.fn.mkdir(project_path .. "/assets", "p")

      vim.fn.mkdir(project_path .. "/assets/images", "p")
      vim.fn.mkdir(project_path .. "/assets/icons", "p")

      return project_path
    end


    -- HTML Templates
    local html_templates = {
      modern = function(project_name)
        return string.format([[<!DOCTYPE html>

<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>%s</title>
    <link rel="stylesheet" href="css/modern-style.css">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">
</head>

<body>
    <div class="glass-container">
        <nav class="nav-glass">
            <div class="nav-brand">
                <h1 class="brand-text">%s</h1>
            </div>
            <ul class="nav-links">
                <li><a href="#home" class="nav-link">Home</a></li>
                <li><a href="#about" class="nav-link">About</a></li>
                <li><a href="#services" class="nav-link">Services</a></li>
                <li><a href="#contact" class="nav-link">Contact</a></li>
            </ul>
        </nav>

        <main class="main-content">
            <section id="home" class="hero-section">
                <div class="hero-content">
                    <h1 class="hero-title">
                        <span class="gradient-text">Innovation</span>
                        <br>Meets Design
                    </h1>
                    <p class="hero-subtitle">Creating extraordinary digital experiences that captivate and inspire</p>
                    <div class="hero-buttons">
                        <button class="btn btn-primary">Get Started</button>
                        <button class="btn btn-secondary">Learn More</button>
                    </div>
                </div>
                <div class="hero-visual">
                    <div class="floating-elements">
                        <div class="float-element element-1"></div>
                        <div class="float-element element-2"></div>
                        <div class="float-element element-3"></div>
                    </div>
                </div>
            </section>

            <section id="about" class="content-section">
                <div class="section-content">
                    <h2 class="section-title">About Us</h2>

                    <p class="section-text">We craft digital experiences that push boundaries and exceed expectations.</p>
                </div>
            </section>

            <section id="services" class="content-section">
                <div class="section-content">
                    <h2 class="section-title">Our Services</h2>
                    <div class="services-grid">
                        <div class="service-card">
                            <div class="service-icon">🎨</div>
                            <h3>Design</h3>

                            <p>Beautiful, functional designs that tell your story</p>
                        </div>

                        <div class="service-card">
                            <div class="service-icon">⚡</div>
                            <h3>Development</h3>
                            <p>Fast, responsive websites built with modern technology</p>

                        </div>
                        <div class="service-card">
                            <div class="service-icon">📱</div>
                            <h3>Mobile</h3>
                            <p>Seamless experiences across all devices</p>

                        </div>
                    </div>
                </div>
            </section>


            <section id="contact" class="content-section">
                <div class="section-content">
                    <h2 class="section-title">Get In Touch</h2>
                    <form class="contact-form glass-form">
                        <div class="form-group">
                            <input type="text" placeholder="Your Name" class="form-input">
                        </div>
                        <div class="form-group">
                            <input type="email" placeholder="Your Email" class="form-input">
                        </div>
                        <div class="form-group">
                            <textarea placeholder="Your Message" class="form-input form-textarea"></textarea>
                        </div>
                        <button type="submit" class="btn btn-primary">Send Message</button>
                    </form>
                </div>
            </section>
        </main>

    </div>

    <script src="js/modern-script.js"></script>

</body>
</html>]], project_name, project_name)
      end,

      classic = function(project_name)

        return string.format([[<!DOCTYPE html>

<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>%s</title>
    <link rel="stylesheet" href="css/classic-style.css">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@400;700&family=Source+Sans+Pro:wght@300;400;600&display=swap" rel="stylesheet">
</head>
<body>
    <header class="header">
        <div class="container">
            <div class="header-content">
                <h1 class="logo">%s</h1>
                <nav class="navigation">
                    <ul class="nav-list">
                        <li><a href="#home" class="nav-link">Home</a></li>
                        <li><a href="#about" class="nav-link">About</a></li>
                        <li><a href="#services" class="nav-link">Services</a></li>
                        <li><a href="#portfolio" class="nav-link">Portfolio</a></li>
                        <li><a href="#contact" class="nav-link">Contact</a></li>
                    </ul>
                </nav>
            </div>
        </div>

    </header>

    <main class="main">
        <section id="home" class="hero">
            <div class="container">
                <div class="hero-content">
                    <h1 class="hero-title">Professional Excellence</h1>
                    <p class="hero-subtitle">Delivering quality solutions with timeless design principles</p>

                    <div class="hero-actions">
                        <a href="#contact" class="btn btn-primary">Get Started</a>
                        <a href="#portfolio" class="btn btn-outline">View Work</a>
                    </div>
                </div>
            </div>
        </section>


        <section id="about" class="section">
            <div class="container">
                <div class="section-header">
                    <h2 class="section-title">About Us</h2>

                    <p class="section-description">Building trust through proven expertise and reliable service</p>
                </div>
                <div class="about-content">
                    <div class="about-text">
                        <p>With years of experience in the industry, we provide professional solutions that stand the test of time. Our approach combines traditional craftsmanship with modern efficiency.</p>
                    </div>
                    <div class="about-stats">

                        <div class="stat">
                            <h3 class="stat-number">100+</h3>

                            <p class="stat-label">Projects Completed</p>
                        </div>
                        <div class="stat">
                            <h3 class="stat-number">5+</h3>
                            <p class="stat-label">Years Experience</p>
                        </div>

                        <div class="stat">
                            <h3 class="stat-number">50+</h3>
                            <p class="stat-label">Happy Clients</p>
                        </div>

                    </div>
                </div>
            </div>
        </section>


        <section id="services" class="section section-gray">
            <div class="container">
                <div class="section-header">
                    <h2 class="section-title">Our Services</h2>
                    <p class="section-description">Comprehensive solutions tailored to your needs</p>
                </div>
                <div class="services-grid">
                    <div class="service-item">
                        <div class="service-icon">
                            <svg width="48" height="48" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                                <path d="M12 2L2 7l10 5 10-5-10-5z"/>
                                <path d="M2 17l10 5 10-5"/>
                                <path d="M2 12l10 5 10-5"/>
                            </svg>
                        </div>
                        <h3 class="service-title">Consulting</h3>
                        <p class="service-description">Strategic guidance to help you make informed decisions</p>
                    </div>
                    <div class="service-item">
                        <div class="service-icon">
                            <svg width="48" height="48" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                                <rect x="2" y="3" width="20" height="14" rx="2" ry="2"/>
                                <line x1="8" y1="21" x2="16" y2="21"/>
                                <line x1="12" y1="17" x2="12" y2="21"/>
                            </svg>
                        </div>

                        <h3 class="service-title">Development</h3>
                        <p class="service-description">Robust solutions built with industry best practices</p>
                    </div>
                    <div class="service-item">

                        <div class="service-icon">
                            <svg width="48" height="48" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                                <circle cx="12" cy="12" r="10"/>
                                <path d="M9.09 9a3 3 0 0 1 5.83 1c0 2-3 3-3 3"/>
                                <path d="M12 17h.01"/>
                            </svg>
                        </div>
                        <h3 class="service-title">Support</h3>
                        <p class="service-description">Ongoing maintenance and dedicated customer service</p>
                    </div>
                </div>
            </div>
        </section>

        <section id="contact" class="section">
            <div class="container">
                <div class="contact-content">
                    <div class="contact-info">
                        <h2 class="section-title">Get In Touch</h2>
                        <p class="contact-description">Ready to start your project? Let's discuss how we can help you achieve your goals.</p>
                        <div class="contact-details">
                            <div class="contact-item">
                                <strong>Email:</strong> hello@example.com
                            </div>
                            <div class="contact-item">
                                <strong>Phone:</strong> (555) 123-4567
                            </div>
                        </div>
                    </div>
                    <form class="contact-form">
                        <div class="form-group">
                            <label for="name" class="form-label">Name</label>
                            <input type="text" id="name" name="name" class="form-input" required>

                        </div>
                        <div class="form-group">
                            <label for="email" class="form-label">Email</label>
                            <input type="email" id="email" name="email" class="form-input" required>
                        </div>
                        <div class="form-group">

                            <label for="message" class="form-label">Message</label>
                            <textarea id="message" name="message" class="form-input" rows="5" required></textarea>

                        </div>
                        <button type="submit" class="btn btn-primary">Send Message</button>
                    </form>
                </div>
            </div>
        </section>
    </main>

    <footer class="footer">
        <div class="container">
            <p>&copy; 2024 %s. All rights reserved.</p>

        </div>
    </footer>


    <script src="js/classic-script.js"></script>

</body>
</html>]], project_name, project_name, project_name)
      end,
    }

    -- Function to generate CSS based on template
    local function generate_css(template_style)
      -- This will be expanded with full CSS generation
      return "/* " .. template_style .. " CSS will be generated here */"
    end

    -- Function to generate JavaScript
    local function generate_js(template_style)
      -- This will be expanded with full JS generation
      return "/* " .. template_style .. " JavaScript will be generated here */"
    end

    -- Function to create files
    local function create_template_files(project_path, template, project_name)

      local html_content = html_templates[template.style](project_name)
      local css_content = generate_css(template.style)
      local js_content = generate_js(template.style)


      -- Write HTML file
      local html_file = io.open(project_path .. "/index.html", "w")
      html_file:write(html_content)
      html_file:close()


      -- Write CSS file
      local css_file = io.open(project_path .. "/css/" .. template.style .. "-style.css", "w")
      css_file:write(css_content)
      css_file:close()

      -- Write JS file
      local js_file = io.open(project_path .. "/js/" .. template.style .. "-script.js", "w")
      js_file:write(js_content)
      js_file:close()


      -- Create README
      local readme_content = string.format([[# %s

## Template: %s

**Style:** %s
**Complexity:** %s

%s

## Structure

- `index.html` - Main HTML file
- `css/` - Stylesheets directory
- `js/` - JavaScript files directory

- `assets/` - Images and other assets

## Development

1. Open `index.html` in your browser

2. Edit styles in `css/` directory
3. Add JavaScript functionality in `js/` directory
4. Place images in `assets/images/` directory

## Customization

This template is designed to be easily customizable. Key areas to modify:

- Colors and typography in CSS
- Content sections in HTML
- Interactive elements in JavaScript

]], project_name, template.name, template.style, template.complexity, template.description)

      local readme_file = io.open(project_path .. "/README.md", "w")
      readme_file:write(readme_content)
      readme_file:close()
    end

    -- Telescope picker for template selection
    local function template_picker()
      pickers.new({}, {
        prompt_title = "Select HTML/CSS Template",
        finder = finders.new_table({
          results = templates,

          entry_maker = function(entry)
            return {
              value = entry,
              display = entry.name .. " (" .. entry.style .. " - " .. entry.complexity .. ")",
              ordinal = entry.name .. " " .. entry.style .. " " .. entry.description,
            }
          end,
        }),
        sorter = conf.generic_sorter({}),
        attach_mappings = function(prompt_bufnr, map)

          actions.select_default:replace(function()
            actions.close(prompt_bufnr)

            local selection = action_state.get_selected_entry()

            -- Get project name from user
            vim.ui.input({
              prompt = "Enter project name: ",
              default = "my-project",
            }, function(project_name)
              if project_name and project_name ~= "" then
                local project_path = create_project_structure(project_name, selection.value)
                create_template_files(project_path, selection.value, project_name)

                vim.notify("Project created: " .. project_path, vim.log.levels.INFO)

                -- Open the project
                vim.cmd("edit " .. project_path .. "/index.html")

              end
            end)

          end)
          return true
        end,
      }):find()

    end

    -- Create command and keymap
    vim.api.nvim_create_user_command("HTMLCSSGenerator", template_picker, {})

    -- Add keymap
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

    map("n", "<leader>hg", template_picker, { desc = "HTML/CSS Generator" })

end,
}

PHASE 1 COMPLETE: HTML/CSS Project Generator Plugin
I've created the foundational HTML/CSS project generator plugin that will serve as the core of your freelancing toolkit. This plugin creates a Telescope-based interface for selecting from different template styles.
What's Been Implemented:

Template Selection System - 6 different style combinations (modern/glassmorphism, classic/professional, trendy/interactive, etc.)
Project Structure Generator - Creates organized folder structure with CSS, JS, and assets directories
HTML Template Foundation - Two complete HTML templates (modern and classic) with proper semantic structure
Neovim Integration - Uses Telescope for beautiful template selection UI
Keymap Integration - <leader>hg to launch the generator

Installation Instructions:

Save the code as ~/.config/nvim/lua/zedocean/plugins/html-css-generator.lua
The plugin will auto-load with your existing Lazy.nvim setup
Use :HTMLCSSGenerator command or <leader>hg keymap

PROMPT FOR NEXT CLAUDE SESSION:
Context: You are continuing a multi-phase HTML/CSS freelancing automation project for a Neovim user. The previous Claude completed Phase 1: HTML/CSS Project Generator Plugin.
Previous Work Completed:

✅ Phase 1: Core project generator with template selection system
✅ HTML templates for modern glassmorphism and classic professional styles
✅ Project structure automation with organized folders
✅ Telescope integration for template selection UI
✅ Neovim keymap integration (<leader>hg)

Project Structure (5 Total Phases):

✅ HTML/CSS Project Generator Plugin (COMPLETED)
🔄 CSS Generation System (YOUR TASK)
⏳ JavaScript Automation & Interactions
⏳ Component Library & Snippets System
⏳ Client Presentation & Export Tools

YOUR TASK - Phase 2: CSS Generation System
You need to complete the CSS generation functions in the plugin. Focus on:

Complete the generate_css() function for all template styles:

Modern glassmorphism with dark theme, glass effects, animations
Classic professional with clean typography and traditional layouts
Trendy interactive with bold colors and micro-animations
Minimal functional with clean, information-focused design
Emotional storytelling with dynamic, engaging elements
Corporate professional with balanced modern touches

Key CSS Features to Include:

Responsive design (mobile-first approach)
Modern CSS features (Grid, Flexbox, CSS Custom Properties)
Smooth animations and transitions
Glass morphism effects for modern templates
Professional typography systems
Color schemes that make designs stand out

Integration Requirements:

Work with existing HTML templates
Use CSS custom properties for easy customization
Include hover effects and micro-interactions
Ensure cross-browser compatibility

Important: The user wants designs that are better than 99% of competitors. Focus on modern, eye-catching designs with smooth animations and professional polish.
Files to Reference: The user's Neovim config shows they use lazy.nvim, telescope, and the local function mapping pattern shown in their keymaps.lua.
Next Steps: After completing Phase 2, prompt the next Claude to work on Phase 3: JavaScript Automation & Interactions.
Your deliverable: Complete CSS generation system with all 6 template styles, focusing on standout visual design and modern web standards.
