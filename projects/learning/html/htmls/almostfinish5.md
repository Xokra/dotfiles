-- ~/.config/nvim/lua/zedocean/plugins/html-templates.lua
-- HTML/CSS Template Generator for Freelance Projects

return {

"zedocean/html-templates", -- This will be your custom plugin
dir = vim.fn.expand("~/.config/nvim/lua/zedocean/html-templates"), -- Local plugin directory
config = function()
-- Template storage
local templates = {
-- MODERN MINIMALIST STYLES
modern_minimal = {
name = "Modern Minimal",
description = "Clean, minimalist design with subtle animations",

        style = "modern",
        complexity = "simple",
        files = {
          ["index.html"] = [[<!DOCTYPE html>

<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>{{PROJECT_NAME}}</title>
    <link rel="stylesheet" href="styles.css">
</head>
<body>
    <nav class="navbar">

        <div class="nav-container">
            <h1 class="logo">{{PROJECT_NAME}}</h1>
            <ul class="nav-menu">
                <li><a href="#home">Home</a></li>
                <li><a href="#about">About</a></li>
                <li><a href="#services">Services</a></li>
                <li><a href="#contact">Contact</a></li>
            </ul>
        </div>
    </nav>


    <main>
        <section id="home" class="hero">

            <div class="hero-content">
                <h2 class="hero-title">Welcome to {{PROJECT_NAME}}</h2>
                <p class="hero-subtitle">Modern solutions for modern problems</p>
                <button class="cta-button">Get Started</button>
            </div>
        </section>

        <section id="about" class="section">
            <div class="container">
                <h2>About Us</h2>
                <p>Your content here...</p>

            </div>
        </section>

        <section id="services" class="section">
            <div class="container">
                <h2>Our Services</h2>
                <div class="service-grid">
                    <div class="service-card">
                        <h3>Service 1</h3>
                        <p>Description here</p>

                    </div>
                    <div class="service-card">
                        <h3>Service 2</h3>
                        <p>Description here</p>
                    </div>
                    <div class="service-card">
                        <h3>Service 3</h3>
                        <p>Description here</p>
                    </div>
                </div>
            </div>
        </section>

        <section id="contact" class="section">
            <div class="container">
                <h2>Contact Us</h2>
                <form class="contact-form">
                    <input type="text" placeholder="Name" required>
                    <input type="email" placeholder="Email" required>
                    <textarea placeholder="Message" required></textarea>
                    <button type="submit">Send Message</button>
                </form>

            </div>
        </section>
    </main>

    <footer class="footer">
        <div class="container">
            <p>&copy; 2025 {{PROJECT_NAME}}. All rights reserved.</p>
        </div>
    </footer>

</body>

</html>]],
          ["styles.css"] = [[/* Modern Minimal CSS */
* {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
}

:root {

    --primary-color: #2563eb;
    --secondary-color: #1e40af;
    --accent-color: #3b82f6;
    --text-color: #1f2937;
    --light-bg: #f9fafb;
    --white: #ffffff;
    --gray-100: #f3f4f6;
    --gray-200: #e5e7eb;
    --shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.1);
    --shadow-lg: 0 10px 15px -3px rgba(0, 0, 0, 0.1);

}

body {
font-family: 'Inter', -apple-system, BlinkMacSystemFont, sans-serif;
line-height: 1.6;
color: var(--text-color);
background-color: var(--white);
}

.container {
max-width: 1200px;
margin: 0 auto;
padding: 0 20px;
}

/_ Navigation _/
.navbar {
background: var(--white);
box-shadow: var(--shadow);
position: fixed;
top: 0;
width: 100%;
z-index: 1000;
transition: all 0.3s ease;
}

.nav-container {
display: flex;
justify-content: space-between;

    align-items: center;
    padding: 1rem 2rem;
    max-width: 1200px;
    margin: 0 auto;

}

.logo {
font-size: 1.5rem;
font-weight: 700;
color: var(--primary-color);
}

.nav-menu {
display: flex;
list-style: none;
gap: 2rem;
}

.nav-menu a {
text-decoration: none;
color: var(--text-color);
font-weight: 500;
transition: color 0.3s ease;
}

.nav-menu a:hover {
color: var(--primary-color);
}

/_ Hero Section _/
.hero {
height: 100vh;
display: flex;
align-items: center;
justify-content: center;
background: linear-gradient(135deg, var(--light-bg) 0%, var(--white) 100%);
text-align: center;
}

.hero-content {
max-width: 600px;
animation: fadeInUp 1s ease-out;
}

.hero-title {
font-size: 3.5rem;
font-weight: 800;
margin-bottom: 1rem;
color: var(--text-color);
}

.hero-subtitle {
font-size: 1.25rem;
margin-bottom: 2rem;
color: #6b7280;
}

.cta-button {
background: var(--primary-color);
color: var(--white);
border: none;
padding: 1rem 2rem;
font-size: 1.1rem;
font-weight: 600;
border-radius: 8px;
cursor: pointer;
transition: all 0.3s ease;
box-shadow: var(--shadow);
}

.cta-button:hover {
background: var(--secondary-color);
transform: translateY(-2px);
box-shadow: var(--shadow-lg);
}

/_ Sections _/
.section {
padding: 5rem 0;
}

.section h2 {
font-size: 2.5rem;
font-weight: 700;
text-align: center;
margin-bottom: 3rem;
color: var(--text-color);

}

/_ Service Grid _/
.service-grid {
display: grid;
grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
gap: 2rem;
margin-top: 3rem;
}

.service-card {

    background: var(--white);
    padding: 2rem;
    border-radius: 12px;
    box-shadow: var(--shadow);
    transition: all 0.3s ease;

}

.service-card:hover {
transform: translateY(-5px);
box-shadow: var(--shadow-lg);
}

.service-card h3 {
font-size: 1.5rem;
font-weight: 600;
margin-bottom: 1rem;

    color: var(--primary-color);

}

/_ Contact Form _/
.contact-form {
max-width: 600px;
margin: 0 auto;
display: flex;

    flex-direction: column;
    gap: 1.5rem;

}

.contact-form input,
.contact-form textarea {
padding: 1rem;
border: 2px solid var(--gray-200);

    border-radius: 8px;
    font-size: 1rem;
    transition: border-color 0.3s ease;

}

.contact-form input:focus,
.contact-form textarea:focus {
outline: none;
border-color: var(--primary-color);
}

.contact-form button {
background: var(--primary-color);
color: var(--white);
border: none;
padding: 1rem;
font-size: 1.1rem;
font-weight: 600;
border-radius: 8px;
cursor: pointer;
transition: background 0.3s ease;
}

.contact-form button:hover {

    background: var(--secondary-color);

}

/_ Footer _/
.footer {
background: var(--light-bg);
padding: 2rem 0;
text-align: center;
border-top: 1px solid var(--gray-200);
}

/_ Animations _/
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

/_ Responsive Design _/
@media (max-width: 768px) {
.nav-menu {

        display: none;
    }

    .hero-title {
        font-size: 2.5rem;
    }

    .hero-subtitle {
        font-size: 1.1rem;
    }

    .service-grid {
        grid-template-columns: 1fr;
    }

}]]
}
},

      -- CLASSIC PROFESSIONAL STYLE
      classic_professional = {
        name = "Classic Professional",
        description = "Traditional, trustworthy design for business",
        style = "classic",
        complexity = "simple",

        files = {
          ["index.html"] = [[<!DOCTYPE html>

<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>{{PROJECT_NAME}}</title>
    <link rel="stylesheet" href="styles.css">
    <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@400;700&family=Source+Sans+Pro:wght@300;400;600&display=swap" rel="stylesheet">

</head>
<body>
    <header class="header">
        <div class="container">
            <div class="header-content">
                <h1 class="company-name">{{PROJECT_NAME}}</h1>
                <p class="tagline">Excellence in Every Detail</p>
            </div>
        </div>
    </header>

    <nav class="main-nav">
        <div class="container">

            <ul class="nav-list">

                <li><a href="#home">Home</a></li>

                <li><a href="#about">About</a></li>
                <li><a href="#services">Services</a></li>
                <li><a href="#portfolio">Portfolio</a></li>
                <li><a href="#contact">Contact</a></li>
            </ul>

        </div>
    </nav>

    <main>
        <section id="home" class="hero-section">
            <div class="container">
                <div class="hero-content">

                    <h2 class="hero-headline">Professional Services You Can Trust</h2>
                    <p class="hero-description">With over a decade of experience, we deliver exceptional results that exceed expectations.</p>
                    <a href="#contact" class="btn btn-primary">Get Started Today</a>
                </div>
            </div>
        </section>


        <section id="about" class="content-section">

            <div class="container">
                <h2 class="section-title">About Our Company</h2>
                <div class="about-content">

                    <div class="about-text">
                        <p>Since our founding, we have been committed to providing the highest quality services to our clients. Our team of experienced professionals brings expertise and dedication to every project.</p>
                        <p>We believe in building lasting relationships through trust, reliability, and exceptional service delivery.</p>

                    </div>
                    <div class="about-stats">
                        <div class="stat">
                            <h3>500+</h3>
                            <p>Projects Completed</p>
                        </div>
                        <div class="stat">
                            <h3>10+</h3>
                            <p>Years Experience</p>
                        </div>
                        <div class="stat">
                            <h3>100%</h3>
                            <p>Client Satisfaction</p>
                        </div>
                    </div>
                </div>
            </div>
        </section>

        <section id="services" class="services-section">
            <div class="container">

                <h2 class="section-title">Our Services</h2>
                <div class="services-grid">

                    <div class="service-item">
                        <h3>Consulting</h3>

                        <p>Strategic guidance and expert advice tailored to your business needs.</p>
                    </div>
                    <div class="service-item">
                        <h3>Implementation</h3>
                        <p>Professional execution of solutions with attention to detail and quality.</p>
                    </div>
                    <div class="service-item">
                        <h3>Support</h3>
                        <p>Ongoing assistance and maintenance to ensure continued success.</p>
                    </div>

                </div>
            </div>
        </section>

        <section id="contact" class="contact-section">
            <div class="container">
                <h2 class="section-title">Contact Us</h2>
                <div class="contact-content">
                    <div class="contact-info">
                        <h3>Get in Touch</h3>

                        <p>Ready to discuss your project? We'd love to hear from you.</p>
                        <div class="contact-details">
                            <p><strong>Phone:</strong> (555) 123-4567</p>
                            <p><strong>Email:</strong> info@{{PROJECT_NAME}}.com</p>
                            <p><strong>Address:</strong> 123 Business St, City, State 12345</p>
                        </div>
                    </div>
                    <form class="contact-form">
                        <div class="form-group">

                            <label for="name">Name</label>
                            <input type="text" id="name" name="name" required>
                        </div>

                        <div class="form-group">
                            <label for="email">Email</label>
                            <input type="email" id="email" name="email" required>
                        </div>
                        <div class="form-group">
                            <label for="message">Message</label>
                            <textarea id="message" name="message" rows="5" required></textarea>
                        </div>
                        <button type="submit" class="btn btn-primary">Send Message</button>
                    </form>
                </div>
            </div>
        </section>
    </main>


    <footer class="footer">
        <div class="container">

            <p>&copy; 2025 {{PROJECT_NAME}}. All rights reserved.</p>
        </div>
    </footer>

</body>
</html>]],
          ["styles.css"] = [[/* Classic Professional CSS */
* {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
}

:root {
--primary-color: #2c3e50;
--secondary-color: #34495e;
--accent-color: #3498db;
--text-color: #2c3e50;
--light-text: #7f8c8d;
--border-color: #bdc3c7;
--light-bg: #ecf0f1;

    --white: #ffffff;
    --gold: #f39c12;

}

body {
font-family: 'Source Sans Pro', Arial, sans-serif;
line-height: 1.6;
color: var(--text-color);
background-color: var(--white);

}

.container {

    max-width: 1200px;
    margin: 0 auto;
    padding: 0 20px;

}

/_ Header _/
.header {

    background: var(--primary-color);
    color: var(--white);
    padding: 2rem 0;
    text-align: center;

}

.company-name {
font-family: 'Playfair Display', serif;

    font-size: 2.5rem;
    font-weight: 700;
    margin-bottom: 0.5rem;

}

.tagline {
font-size: 1.1rem;
font-weight: 300;
color: #ecf0f1;
}

/_ Navigation _/

.main-nav {
background: var(--white);
border-bottom: 3px solid var(--primary-color);
box-shadow: 0 2px 5px rgba(0,0,0,0.1);
}

.nav-list {
display: flex;
justify-content: center;
list-style: none;

    padding: 0;

}

.nav-list li {
margin: 0 1rem;
}

.nav-list a {
display: block;
padding: 1rem 1.5rem;
text-decoration: none;
color: var(--text-color);
font-weight: 600;
text-transform: uppercase;
letter-spacing: 1px;
transition: all 0.3s ease;
}

.nav-list a:hover {
background: var(--primary-color);
color: var(--white);
}

/_ Hero Section _/
.hero-section {

    background: linear-gradient(135deg, var(--light-bg) 0%, var(--white) 100%);
    padding: 6rem 0;
    text-align: center;

}

.hero-headline {
font-family: 'Playfair Display', serif;
font-size: 3rem;
font-weight: 700;
margin-bottom: 1.5rem;
color: var(--primary-color);

}

.hero-description {
font-size: 1.2rem;
margin-bottom: 2rem;
color: var(--light-text);

    max-width: 600px;
    margin-left: auto;
    margin-right: auto;

}

/_ Buttons _/
.btn {
display: inline-block;
padding: 1rem 2rem;
text-decoration: none;
border-radius: 5px;
font-weight: 600;
text-transform: uppercase;

    letter-spacing: 1px;
    transition: all 0.3s ease;
    border: none;
    cursor: pointer;
    font-size: 1rem;

}

.btn-primary {
background: var(--primary-color);

    color: var(--white);

}

.btn-primary:hover {
background: var(--secondary-color);
transform: translateY(-2px);
}

/_ Content Sections _/

.content-section {
padding: 5rem 0;
}

.section-title {
font-family: 'Playfair Display', serif;
font-size: 2.5rem;
font-weight: 700;
text-align: center;
margin-bottom: 3rem;
color: var(--primary-color);
}

.about-content {
display: grid;
grid-template-columns: 2fr 1fr;
gap: 3rem;
align-items: center;
}

.about-text p {
margin-bottom: 1.5rem;
font-size: 1.1rem;
line-height: 1.8;
}

.about-stats {

    display: flex;
    flex-direction: column;
    gap: 2rem;

}

.stat {
text-align: center;
padding: 1.5rem;
background: var(--light-bg);
border-radius: 10px;
}

.stat h3 {
font-size: 2rem;
font-weight: 700;
color: var(--primary-color);
margin-bottom: 0.5rem;
}

/_ Services Section _/
.services-section {
background: var(--light-bg);
padding: 5rem 0;
}

.services-grid {

    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
    gap: 2rem;

}

.service-item {
background: var(--white);
padding: 2.5rem;
border-radius: 10px;
box-shadow: 0 5px 15px rgba(0,0,0,0.1);
text-align: center;
transition: transform 0.3s ease;
}

.service-item:hover {

    transform: translateY(-5px);

}

.service-item h3 {
font-size: 1.5rem;
font-weight: 600;

    margin-bottom: 1rem;
    color: var(--primary-color);

}

.service-item p {
color: var(--light-text);
line-height: 1.8;
}

/_ Contact Section _/
.contact-section {
padding: 5rem 0;
}

.contact-content {
display: grid;
grid-template-columns: 1fr 1fr;

    gap: 4rem;

}

.contact-info h3 {

    font-size: 1.8rem;
    margin-bottom: 1rem;
    color: var(--primary-color);

}

.contact-info p {
margin-bottom: 1.5rem;
font-size: 1.1rem;
line-height: 1.8;
}

.contact-details p {
margin-bottom: 0.5rem;

}

/_ Form Styles _/

.contact-form {
background: var(--light-bg);
padding: 2rem;
border-radius: 10px;
}

.form-group {
margin-bottom: 1.5rem;
}

.form-group label {
display: block;

    margin-bottom: 0.5rem;
    font-weight: 600;
    color: var(--primary-color);

}

.form-group input,
.form-group textarea {
width: 100%;
padding: 1rem;
border: 2px solid var(--border-color);
border-radius: 5px;
font-size: 1rem;
transition: border-color 0.3s ease;
}

.form-group input:focus,
.form-group textarea:focus {
outline: none;

    border-color: var(--primary-color);

}

/_ Footer _/
.footer {
background: var(--primary-color);
color: var(--white);
padding: 2rem 0;
text-align: center;

}

/_ Responsive Design _/
@media (max-width: 768px) {
.nav-list {
flex-direction: column;
text-align: center;
}

    .nav-list li {
        margin: 0;
    }

    .hero-headline {
        font-size: 2rem;
    }

    .about-content,
    .contact-content {
        grid-template-columns: 1fr;
    }

    .about-stats {
        flex-direction: row;
        justify-content: space-around;
    }

}]]
}
}
}

    -- Helper function to create project structure
    local function create_project_structure(project_name, template_key)
      local template = templates[template_key]
      if not template then
        vim.notify("Template not found: " .. template_key, vim.log.levels.ERROR)
        return
      end

      -- Create project directory
      local project_dir = vim.fn.getcwd() .. "/" .. project_name
      vim.fn.mkdir(project_dir, "p")

      -- Create files from template
      for filename, content in pairs(template.files) do
        local file_content = content:gsub("{{PROJECT_NAME}}", project_name)
        local file_path = project_dir .. "/" .. filename
        local file = io.open(file_path, "w")
        if file then
          file:write(file_content)
          file:close()
          vim.notify("Created: " .. file_path, vim.log.levels.INFO)
        else
          vim.notify("Failed to create: " .. file_path, vim.log.levels.ERROR)
        end
      end

      -- Open the project
      vim.cmd("cd " .. project_dir)
      vim.cmd("edit index.html")
      vim.cmd("vsplit styles.css")

      vim.notify("Project '" .. project_name .. "' created successfully!", vim.log.levels.INFO)
    end

    -- Function to list available templates
    local function list_templates()
      local template_list = {}
      for key, template in pairs(templates) do
        table.insert(template_list, {
          key = key,

          name = template.name,
          description = template.description,
          style = template.style,
          complexity = template.complexity
        })
      end
      return template_list
    end

    -- Function to show template picker
    local function show_template_picker()
      local template_list = list_templates()
      local choices = {}

      for _, template in ipairs(template_list) do
        table.insert(choices, string.format("%s - %s (%s, %s)",
          template.key, template.name, template.style, template.complexity))
      end

      vim.ui.select(choices, {
        prompt = "Select a template:",
        format_item = function(item)
          return item
        end
      }, function(choice)
        if choice then
          local template_key = choice:match("^([^%s]+)")

          vim.ui.input({
            prompt = "Project name: ",

            default = "my-project"
          }, function(project_name)
            if project_name and project_name ~= "" then

              create_project_structure(project_name, template_key)
            end
          end)
        end
      end)
    end


    -- Key mappings
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

    -- Main commands
    map("n", "<leader>ht", show_template_picker, { desc = "HTML Template Picker" })

    -- Quick template shortcuts
    map("n", "<leader>hm", function()
      vim.ui.input({
        prompt = "Project name: ",

        default = "modern-site"
      }, function(project_name)
        if project_name and project_name ~= "" then
          create_project_structure(project_name, "modern_minimal")
        end

      end)
    end, { desc = "Quick Modern Template" })


    map("n", "<leader>hc", function()
      vim.ui.input({
        prompt = "Project name: ",
        default = "classic-site"

      }, function(project_name)
        if project_name and project_name ~= "" then
          create_project_structure(project_name, "classic_professional")
        end
      end)

    end, { desc = "Quick Classic Template" })


    -- Live preview keymap
    map("n", "<leader>hp", function()
      local file = vim.fn.expand("%:p")
      if vim.fn.expand("%:e") == "html" then
        vim.fn.system('wslview "' .. file .. '"')
        vim.notify("Opening in browser...", vim.log.levels.INFO)
      else
        vim.notify("Not an HTML file", vim.log.levels.WARN)
      end
    end, { desc = "Preview HTML in Browser" })


    -- CSS hot reload helper
    map("n", "<leader>hr", function()
      local current_file = vim.fn.expand("%:t")
      if current_file == "styles.css" then
        vim.cmd("silent !echo 'CSS updated' > /dev/null")
        vim.notify("CSS changes saved - refresh browser", vim.log.levels.INFO)
      end
    end, { desc = "CSS Hot Reload Notification" })

    -- Create user commands
    vim.api.nvim_create_user_command("HTMLTemplate", show_template_picker, {})
    vim.api.nvim_create_user_command("HTMLModern", function(opts)
      local project_name = opts.args ~= "" and opts.args or "modern-site"
      create_project_structure(project_name, "modern_minimal")

    end, { nargs = "?" })
    vim.api.nvim_create_user_command("HTMLClassic", function(opts)
      local project_name = opts.args ~= "" and opts.args or "classic-site"
      create_project_structure(project_name, "classic_professional")
    end, { nargs = "?" })


    vim.notify("HTML Template Generator loaded! Use <leader>ht to start", vim.log.levels.INFO)

end
}

What I've Created for You
I've built a comprehensive HTML/CSS template generation system for Neovim that will dramatically speed up your freelance workflow. Here's what this plugin does:
Key Features:

Two Professional Templates Ready:

Modern Minimal: Clean, contemporary design with animations
Classic Professional: Traditional, trustworthy business design

Smart Key Mappings:

<leader>ht - Template picker with descriptions
<leader>hm - Quick modern template
<leader>hc - Quick classic template
<leader>hp - Live preview in browser
<leader>hr - CSS hot reload notification

Instant Project Setup:

Creates complete project structure
Opens files in split windows
Automatically replaces
