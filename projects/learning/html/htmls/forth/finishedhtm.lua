-- ~/.config/nvim/lua/zedocean/plugins/html-templates.lua

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


local M = {}


-- Template configurations
local templates = {
  modern_glassmorphism = {
    name = "Modern Glassmorphism",
    description = "Modern design with glass effects and vibrant colors",
    category = "modern"
  },
  classic_professional = {
    name = "Classic Professional",
    description = "Traditional, clean professional layout",

    category = "classic"
  },
  minimalist_functional = {
    name = "Minimalist Functional",
    description = "Clean, minimal design focused on functionality",

    category = "functional"

  },

  bold_experimental = {
    name = "Bold Experimental",
    description = "Cutting-edge design with animations and effects",
    category = "experimental"
  },
  corporate_informative = {
    name = "Corporate Informative",

    description = "Information-heavy design for business use",
    category = "corporate"
  },
  creative_emotional = {

    name = "Creative Emotional",
    description = "Artistic design focused on emotional impact",
    category = "emotional"
  }
}

-- Generate HTML structure
local function generate_html_structure(template_type, project_name)
  local html_content = string.format([[
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>%s - %s</title>
    <link rel="stylesheet" href="styles.css">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
</head>
<body>
    <header class="header">

        <nav class="nav">

            <div class="nav-brand">
                <h1>%s</h1>
            </div>
            <ul class="nav-menu">
                <li><a href="#home">Home</a></li>
                <li><a href="#about">About</a></li>
                <li><a href="#services">Services</a></li>
                <li><a href="#contact">Contact</a></li>
            </ul>
            <div class="nav-toggle">
                <span></span>
                <span></span>
                <span></span>
            </div>

        </nav>
    </header>


    <main>
        <section id="home" class="hero">
            <div class="hero-content">
                <h2 class="hero-title">Welcome to %s</h2>
                <p class="hero-subtitle">Your success is our priority</p>
                <button class="cta-button">Get Started</button>
            </div>
        </section>

        <section id="about" class="about">
            <div class="container">
                <h2>About Us</h2>
                <div class="about-grid">
                    <div class="about-text">

                        <p>We provide exceptional services tailored to your needs.</p>
                    </div>
                    <div class="about-image">
                        <div class="placeholder-image">Image Placeholder</div>
                    </div>
                </div>
            </div>
        </section>

        <section id="services" class="services">
            <div class="container">

                <h2>Our Services</h2>
                <div class="services-grid">
                    <div class="service-card">
                        <i class="fas fa-laptop-code"></i>

                        <h3>Web Development</h3>
                        <p>Custom websites built for your business</p>
                    </div>
                    <div class="service-card">
                        <i class="fas fa-mobile-alt"></i>
                        <h3>Mobile Design</h3>
                        <p>Responsive designs for all devices</p>
                    </div>
                    <div class="service-card">
                        <i class="fas fa-search"></i>
                        <h3>SEO Optimization</h3>
                        <p>Improve your online visibility</p>

                    </div>
                </div>
            </div>
        </section>


        <section id="contact" class="contact">
            <div class="container">
                <h2>Get In Touch</h2>
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
        <div class="container">
            <p>&copy; 2024 %s. All rights reserved.</p>
        </div>

    </footer>

    <script src="script.js"></script>
</body>
</html>
]], project_name, templates[template_type].name, project_name, project_name, project_name)

  return html_content
end


-- Generate CSS based on template type

local function generate_css_content(template_type)
  local base_css = [[
* {
    margin: 0;
    padding: 0;

    box-sizing: border-box;
}

body {
    font-family: 'Inter', sans-serif;
    line-height: 1.6;
    color: var(--text-color);
    background: var(--bg-color);
}

.container {
    max-width: 1200px;
    margin: 0 auto;
    padding: 0 20px;
}

/* Navigation */
.header {
    position: fixed;
    top: 0;

    width: 100%;
    z-index: 1000;
    background: var(--header-bg);
    backdrop-filter: blur(10px);

    border-bottom: 1px solid var(--border-color);
}

.nav {
    display: flex;
    justify-content: space-between;
    align-items: center;
    padding: 1rem 2rem;
}

.nav-brand h1 {

    font-size: 1.5rem;
    font-weight: 600;
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

.nav-toggle {
    display: none;
    flex-direction: column;
    cursor: pointer;
}

.nav-toggle span {
    width: 25px;
    height: 3px;
    background: var(--text-color);
    margin: 3px 0;

    transition: 0.3s;
}

/* Hero Section */
.hero {
    height: 100vh;
    display: flex;
    align-items: center;
    justify-content: center;
    text-align: center;

    background: var(--hero-bg);
    position: relative;
    overflow: hidden;
}

.hero-content {
    z-index: 2;
    max-width: 800px;

    padding: 0 2rem;

}


.hero-title {
    font-size: 3.5rem;
    font-weight: 700;
    margin-bottom: 1rem;

    color: var(--hero-title-color);
}

.hero-subtitle {
    font-size: 1.25rem;

    margin-bottom: 2rem;
    color: var(--hero-subtitle-color);

}


.cta-button {
    padding: 1rem 2rem;
    font-size: 1.1rem;
    font-weight: 600;
    background: var(--primary-color);
    color: white;
    border: none;
    border-radius: var(--border-radius);
    cursor: pointer;
    transition: all 0.3s ease;
}

.cta-button:hover {
    background: var(--primary-hover);
    transform: translateY(-2px);
}

/* Sections */
section {
    padding: 5rem 0;
}

h2 {
    font-size: 2.5rem;
    text-align: center;
    margin-bottom: 3rem;
    color: var(--heading-color);
}

/* About Section */

.about-grid {
    display: grid;
    grid-template-columns: 1fr 1fr;
    gap: 3rem;

    align-items: center;
}

.about-text {
    font-size: 1.1rem;
    line-height: 1.8;

}


.placeholder-image {

    height: 300px;
    background: var(--placeholder-bg);
    border-radius: var(--border-radius);

    display: flex;
    align-items: center;
    justify-content: center;
    color: var(--placeholder-text);
    font-weight: 500;
}

/* Services Section */
.services {

    background: var(--section-bg);

}


.services-grid {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
    gap: 2rem;
}

.service-card {
    background: var(--card-bg);
    padding: 2rem;
    border-radius: var(--border-radius);

    text-align: center;
    transition: transform 0.3s ease;
    border: 1px solid var(--border-color);
}


.service-card:hover {
    transform: translateY(-5px);
}

.service-card i {
    font-size: 3rem;
    color: var(--primary-color);
    margin-bottom: 1rem;
}


.service-card h3 {
    font-size: 1.5rem;
    margin-bottom: 1rem;
    color: var(--heading-color);
}

/* Contact Section */
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
    border: 1px solid var(--border-color);
    border-radius: var(--border-radius);
    font-size: 1rem;
    background: var(--input-bg);

    color: var(--text-color);
}


.contact-form textarea {
    min-height: 120px;
    resize: vertical;
}

.contact-form button {
    padding: 1rem;
    background: var(--primary-color);
    color: white;
    border: none;
    border-radius: var(--border-radius);
    font-size: 1rem;
    font-weight: 600;
    cursor: pointer;
    transition: background 0.3s ease;
}

.contact-form button:hover {

    background: var(--primary-hover);
}


/* Footer */
.footer {
    background: var(--footer-bg);
    color: var(--footer-text);
    text-align: center;

    padding: 2rem 0;

}


/* Responsive Design */
@media (max-width: 768px) {
    .nav-menu {
        display: none;
    }
    
    .nav-toggle {
        display: flex;
    }
    
    .hero-title {
        font-size: 2.5rem;

    }
    

    .about-grid {
        grid-template-columns: 1fr;
    }
    
    .services-grid {
        grid-template-columns: 1fr;
    }
}
]]

  local theme_variables = {
    modern_glassmorphism = [[
:root {
    --primary-color: #667eea;

    --primary-hover: #5a67d8;
    --bg-color: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
    --text-color: #2d3748;
    --heading-color: #1a202c;
    --header-bg: rgba(255, 255, 255, 0.1);
    --hero-bg: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
    --hero-title-color: #ffffff;
    --hero-subtitle-color: #e2e8f0;
    --section-bg: rgba(255, 255, 255, 0.05);
    --card-bg: rgba(255, 255, 255, 0.1);
    --border-color: rgba(255, 255, 255, 0.2);
    --border-radius: 15px;

    --placeholder-bg: rgba(255, 255, 255, 0.1);
    --placeholder-text: #a0aec0;
    --input-bg: rgba(255, 255, 255, 0.1);
    --footer-bg: rgba(0, 0, 0, 0.1);
    --footer-text: #e2e8f0;
}


body {
    background: var(--bg-color);
    min-height: 100vh;
}

.service-card {

    backdrop-filter: blur(10px);
    border: 1px solid rgba(255, 255, 255, 0.2);
}


.hero::before {

    content: '';
    position: absolute;
    top: 0;
    left: 0;
    right: 0;
    bottom: 0;
    background: url('data:image/svg+xml,<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 1000 1000"><defs><radialGradient id="a" cx="50%" cy="50%" r="50%"><stop offset="0%" style="stop-color:rgba(255,255,255,0.1)"/><stop offset="100%" style="stop-color:rgba(255,255,255,0)"/></radialGradient></defs><circle cx="200" cy="300" r="100" fill="url(%23a)"/><circle cx="700" cy="200" r="150" fill="url(%23a)"/><circle cx="500" cy="600" r="120" fill="url(%23a)"/></svg>');
    opacity: 0.6;
}
]],
    classic_professional = [[

:root {
    --primary-color: #2563eb;
    --primary-hover: #1d4ed8;

    --bg-color: #ffffff;
    --text-color: #374151;
    --heading-color: #111827;
    --header-bg: rgba(255, 255, 255, 0.95);
    --hero-bg: #f8fafc;
    --hero-title-color: #111827;

    --hero-subtitle-color: #6b7280;

    --section-bg: #f9fafb;
    --card-bg: #ffffff;
    --border-color: #e5e7eb;
    --border-radius: 8px;
    --placeholder-bg: #f3f4f6;
    --placeholder-text: #9ca3af;
    --input-bg: #ffffff;
    --footer-bg: #111827;
    --footer-text: #d1d5db;
}
]],
    minimalist_functional = [[
:root {
    --primary-color: #000000;
    --primary-hover: #333333;
    --bg-color: #ffffff;
    --text-color: #333333;
    --heading-color: #000000;
    --header-bg: rgba(255, 255, 255, 0.95);

    --hero-bg: #ffffff;
    --hero-title-color: #000000;
    --hero-subtitle-color: #666666;
    --section-bg: #fafafa;

    --card-bg: #ffffff;
    --border-color: #e0e0e0;
    --border-radius: 4px;
    --placeholder-bg: #f5f5f5;
    --placeholder-text: #999999;
    --input-bg: #ffffff;
    --footer-bg: #000000;
    --footer-text: #ffffff;
}
]],

    bold_experimental = [[
:root {
    --primary-color: #f59e0b;
    --primary-hover: #d97706;
    --bg-color: #0f172a;
    --text-color: #e2e8f0;
    --heading-color: #f1f5f9;
    --header-bg: rgba(15, 23, 42, 0.9);
    --hero-bg: linear-gradient(45deg, #0f172a 0%, #1e293b 50%, #334155 100%);
    --hero-title-color: #f59e0b;
    --hero-subtitle-color: #cbd5e1;
    --section-bg: #1e293b;
    --card-bg: #334155;
    --border-color: #475569;
    --border-radius: 12px;
    --placeholder-bg: #475569;
    --placeholder-text: #94a3b8;
    --input-bg: #334155;
    --footer-bg: #0f172a;
    --footer-text: #cbd5e1;
}

@keyframes float {
    0%, 100% { transform: translateY(0px); }
    50% { transform: translateY(-20px); }
}

.service-card {

    animation: float 6s ease-in-out infinite;
}

.service-card:nth-child(2) {
    animation-delay: -2s;
}

.service-card:nth-child(3) {
    animation-delay: -4s;
}

.hero::before {
    content: '';
    position: absolute;
    top: 0;
    left: 0;
    right: 0;
    bottom: 0;
    background: radial-gradient(circle at 20% 80%, rgba(245, 158, 11, 0.1) 0%, transparent 50%),
                radial-gradient(circle at 80% 20%, rgba(245, 158, 11, 0.1) 0%, transparent 50%);
}
]],
    corporate_informative = [[
:root {
    --primary-color: #1f2937;
    --primary-hover: #374151;
    --bg-color: #ffffff;

    --text-color: #4b5563;
    --heading-color: #111827;
    --header-bg: rgba(255, 255, 255, 0.95);
    --hero-bg: #f9fafb;
    --hero-title-color: #111827;
    --hero-subtitle-color: #6b7280;
    --section-bg: #ffffff;
    --card-bg: #f9fafb;
    --border-color: #d1d5db;
    --border-radius: 6px;
    --placeholder-bg: #f3f4f6;
    --placeholder-text: #9ca3af;
    --input-bg: #ffffff;
    --footer-bg: #1f2937;
    --footer-text: #d1d5db;
}
]],
    creative_emotional = [[
:root {
    --primary-color: #ec4899;
    --primary-hover: #db2777;
    --bg-color: linear-gradient(135deg, #fdf2f8 0%, #fce7f3 100%);
    --text-color: #374151;
    --heading-color: #1f2937;
    --header-bg: rgba(253, 242, 248, 0.9);
    --hero-bg: linear-gradient(135deg, #fdf2f8 0%, #fce7f3 50%, #fbcfe8 100%);
    --hero-title-color: #ec4899;
    --hero-subtitle-color: #6b7280;
    --section-bg: rgba(252, 231, 243, 0.5);
    --card-bg: rgba(253, 242, 248, 0.8);
    --border-color: rgba(236, 72, 153, 0.2);
    --border-radius: 20px;
    --placeholder-bg: rgba(252, 231, 243, 0.5);
    --placeholder-text: #9ca3af;
    --input-bg: rgba(253, 242, 248, 0.8);
    --footer-bg: rgba(236, 72, 153, 0.1);
    --footer-text: #4b5563;
}

body {
    background: var(--bg-color);
    min-height: 100vh;
}

.service-card {
    transition: all 0.3s ease;
    box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.1);
}


.service-card:hover {
    box-shadow: 0 20px 25px -5px rgba(0, 0, 0, 0.1);
}
]]
  }


  return theme_variables[template_type] .. base_css
end

-- Generate JavaScript file
local function generate_js_content()
  return [[
// Mobile Navigation Toggle

const navToggle = document.querySelector('.nav-toggle');
const navMenu = document.querySelector('.nav-menu');

navToggle.addEventListener('click', () => {
    navMenu.classList.toggle('active');
});

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

// Form submission handler
const contactForm = document.querySelector('.contact-form');
contactForm.addEventListener('submit', function(e) {

    e.preventDefault();
    alert('Thank you for your message! We will get back to you soon.');
    this.reset();
});

// Header background on scroll
window.addEventListener('scroll', function() {
    const header = document.querySelector('.header');
    if (window.scrollY > 100) {
        header.style.background = 'rgba(255, 255, 255, 0.95)';
    } else {
        header.style.background = 'rgba(255, 255, 255, 0.1)';
    }
});
]]
end

-- Create project structure
local function create_project_structure(template_type, project_name)
  local project_path = vim.fn.expand("~/projects/" .. project_name)
  
  -- Create project directory
  vim.fn.mkdir(project_path, "p")
  
  -- Generate and write files
  local html_content = generate_html_structure(template_type, project_name)

  local css_content = generate_css_content(template_type)
  local js_content = generate_js_content()
  
  -- Write files
  vim.fn.writefile(vim.split(html_content, '\n'), project_path .. "/index.html")

  vim.fn.writefile(vim.split(css_content, '\n'), project_path .. "/styles.css")
  vim.fn.writefile(vim.split(js_content, '\n'), project_path .. "/script.js")
  
  -- Create README
  local readme_content = string.format([[
# %s

Template: %s
Description: %s

## Files Structure

- index.html - Main HTML file
- styles.css - CSS styles
- script.js - JavaScript functionality

## Usage

1. Open index.html in your browser
2. Customize the content and styling as needed

3. Deploy to your preferred hosting platform


## Template Category: %s
]], project_name, templates[template_type].name, templates[template_type].description, templates[template_type].category)
  
  vim.fn.writefile(vim.split(readme_content, '\n'), project_path .. "/README.md")
  
  return project_path
end


-- Interactive template selection
local function select_template()
  local template_names = {}
  local template_keys = {}
  
  for key, template in pairs(templates) do
    table.insert(template_names, string.format("%s (%s)", template.name, template.category))
    table.insert(template_keys, key)
  end
  
  vim.ui.select(template_names, {
    prompt = "Select a template:",
    format_item = function(item)
      return item
    end,
  }, function(choice, idx)
    if choice then
      local template_key = template_keys[idx]
      vim.ui.input({
        prompt = "Enter project name: ",
        default = "my-project"
      }, function(project_name)
        if project_name and project_name ~= "" then
          local project_path = create_project_structure(template_key, project_name)
          vim.notify(string.format("Project created: %s", project_path), vim.log.levels.INFO)
          
          -- Open the project
          vim.cmd("edit " .. project_path .. "/index.html")
          vim.cmd("vsplit " .. project_path .. "/styles.css")
        end
      end)
    end
  end)
end

-- Quick template functions
local function create_glassmorphism_template()
  vim.ui.input({
    prompt = "Enter project name: ",
    default = "glassmorphism-project"

  }, function(project_name)
    if project_name and project_name ~= "" then
      local project_path = create_project_structure("modern_glassmorphism", project_name)
      vim.notify(string.format("Glassmorphism project created: %s", project_path), vim.log.levels.INFO)
      vim.cmd("edit " .. project_path .. "/index.html")
    end
  end)
end

-- Setup function
function M.setup()
  -- Create user commands
  vim.api.nvim_create_user_command("HtmlTemplate", select_template, {})
  vim.api.nvim_create_user_command("HtmlGlass", create_glassmorphism_template, {})
  
  -- Set up keymaps
  map("n", "<leader>ht", select_template, { desc = "HTML Template Generator" })
  map("n", "<leader>hg", create_glassmorphism_template, { desc = "Create Glassmorphism Template" })
  
  -- Quick access to templates directory
  map("n", "<leader>hp", function()
    vim.cmd("edit ~/projects/")
  end, { desc = "Open Projects Directory" })
  
  vim.notify("HTML Template Generator loaded! Use <leader>ht to start", vim.log.levels.INFO)
end


return M
]]>
