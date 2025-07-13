-- Create this file: ~/.config/nvim/lua/zedocean/plugins/html-css-snippets.lua

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

    local r = ls.restore_node
    local fmt = require("luasnip.extras.fmt").fmt
    local rep = require("luasnip.extras").rep


    -- Helper function for current year
    local function get_year()
      return os.date("%Y")
    end

    -- Helper function for project name from directory

    local function get_project_name()
      local cwd = vim.fn.getcwd()
      return vim.fn.fnamemodify(cwd, ":t")
    end

    -- HTML Snippets
    ls.add_snippets("html", {

      -- Modern HTML5 Boilerplate
      s("html5modern", fmt([[

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="{}">
    <meta name="author" content="{}">
    <title>{}</title>


    <!-- Preload critical fonts -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">

    <!-- Favicon -->
    <link rel="icon" type="image/svg+xml" href="/favicon.svg">

    <!-- Styles -->

    <link rel="stylesheet" href="styles.css">

    <!-- Critical CSS for above-the-fold content -->
    <style>
        /* Critical CSS will be inlined here */
        * {{ box-sizing: border-box; }}
        body {{ margin: 0; font-family: 'Inter', -apple-system, BlinkMacSystemFont, sans-serif; }}
    </style>

</head>

<body>
    <!-- Skip to main content for accessibility -->
    <a href="#main" class="skip-link">Skip to main content</a>
    
    <!-- Header -->
    <header class="header">
        <nav class="nav">
            <div class="nav-container">
                <div class="nav-logo">
                    <a href="/" aria-label="Home">
                        <span class="logo-text">{}</span>
                    </a>
                </div>
                <ul class="nav-menu">
                    <li><a href="#about">About</a></li>

                    <li><a href="#services">Services</a></li>
                    <li><a href="#portfolio">Portfolio</a></li>
                    <li><a href="#contact">Contact</a></li>
                </ul>
                <button class="nav-toggle" aria-label="Toggle navigation">
                    <span class="hamburger"></span>
                </button>
            </div>
        </nav>
    </header>

    <!-- Main Content -->
    <main id="main" class="main">
        <section class="hero">
            <div class="container">
                <div class="hero-content">
                    <h1 class="hero-title">{}</h1>
                    <p class="hero-subtitle">{}</p>
                    <div class="hero-buttons">
                        <a href="#contact" class="btn btn-primary">Get Started</a>
                        <a href="#portfolio" class="btn btn-secondary">View Work</a>

                    </div>
                </div>
            </div>
        </section>


        <!-- Additional sections go here -->
        <section class="section" id="about">
            <div class="container">
                <h2 class="section-title">About</h2>
                <div class="section-content">
                    {}
                </div>
            </div>
        </section>
    </main>

    <!-- Footer -->

    <footer class="footer">
        <div class="container">

            <div class="footer-content">
                <div class="footer-section">
                    <h3 class="footer-title">{}</h3>
                    <p class="footer-text">Creating exceptional web experiences.</p>
                </div>
                <div class="footer-section">
                    <h3 class="footer-title">Quick Links</h3>
                    <ul class="footer-links">
                        <li><a href="#about">About</a></li>
                        <li><a href="#services">Services</a></li>
                        <li><a href="#contact">Contact</a></li>
                    </ul>
                </div>
                <div class="footer-section">
                    <h3 class="footer-title">Connect</h3>

                    <div class="social-links">
                        <a href="#" aria-label="Twitter">Twitter</a>
                        <a href="#" aria-label="LinkedIn">LinkedIn</a>
                        <a href="#" aria-label="GitHub">GitHub</a>
                    </div>
                </div>
            </div>

            <div class="footer-bottom">
                <p>&copy; {} {}. All rights reserved.</p>
            </div>
        </div>
    </footer>


    <!-- Scripts -->
    <script src="script.js"></script>

</body>

</html>
      ]], {
        i(1, "Website description"),
        i(2, "Your Name"),
        i(3, "Page Title"),
        i(4, "Brand Name"),
        i(5, "Hero Title"),
        i(6, "Hero subtitle text"),
        i(7, "About section content"),
        i(8, "Brand Name"),
        f(get_year, {}),
        i(9, "Brand Name"),
        i(0)

      })),


      -- Glassmorphism Landing Page
      s("glassmorphism", fmt([[

<!DOCTYPE html>
<html lang="en">
<head>

    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>{}</title>
    <link rel="stylesheet" href="glassmorphism.css">

</head>
<body>
    <div class="background-gradient">
        <div class="floating-shapes">
            <div class="shape shape-1"></div>
            <div class="shape shape-2"></div>
            <div class="shape shape-3"></div>
        </div>
    </div>

    <header class="glass-header">

        <nav class="glass-nav">
            <div class="nav-brand">

                <span class="brand-text">{}</span>
            </div>
            <ul class="nav-links">
                <li><a href="#home">Home</a></li>
                <li><a href="#about">About</a></li>
                <li><a href="#services">Services</a></li>
                <li><a href="#contact">Contact</a></li>
            </ul>
        </nav>
    </header>


    <main class="glass-main">
        <section class="hero-glass">
            <div class="glass-card hero-card">
                <h1 class="hero-title">{}</h1>

                <p class="hero-description">{}</p>
                <div class="hero-buttons">
                    <button class="glass-btn primary">Get Started</button>
                    <button class="glass-btn secondary">Learn More</button>
                </div>
            </div>
        </section>

        <section class="features-glass">
            <div class="glass-card features-card">
                <h2 class="section-title">Features</h2>
                <div class="features-grid">

                    <div class="feature-item">
                        <div class="feature-icon">🚀</div>

                        <h3>Fast</h3>
                        <p>Lightning-fast performance</p>
                    </div>
                    <div class="feature-item">
                        <div class="feature-icon">🔒</div>
                        <h3>Secure</h3>
                        <p>Enterprise-grade security</p>
                    </div>
                    <div class="feature-item">

                        <div class="feature-icon">⚡</div>
                        <h3>Efficient</h3>
                        <p>Optimized for productivity</p>
                    </div>
                </div>
            </div>
        </section>
    </main>


    <footer class="glass-footer">

        <div class="glass-card footer-card">
            <p>&copy; {} {}. All rights reserved.</p>
        </div>

    </footer>

</body>
</html>
      ]], {
        i(1, "Glassmorphism Site"),
        i(2, "Brand"),
        i(3, "Welcome to the Future"),
        i(4, "Experience the next generation of web design"),
        f(get_year, {}),
        i(5, "Brand Name"),
        i(0)
      })),

      -- Portfolio Template
      s("portfolio", fmt([[

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>{} - Portfolio</title>
    <link rel="stylesheet" href="portfolio.css">
</head>
<body>
    <header class="portfolio-header">
        <nav class="portfolio-nav">
            <div class="nav-logo">

                <h1>{}</h1>
            </div>
            <ul class="nav-menu">
                <li><a href="#home">Home</a></li>
                <li><a href="#about">About</a></li>
                <li><a href="#portfolio">Portfolio</a></li>
                <li><a href="#contact">Contact</a></li>
            </ul>
        </nav>
    </header>


    <main>
        <section id="home" class="hero-section">
            <div class="hero-content">

                <h1 class="hero-title">Hi, I'm {}</h1>
                <p class="hero-subtitle">{}</p>
                <a href="#portfolio" class="cta-button">View My Work</a>
            </div>
        </section>

        <section id="about" class="about-section">

            <div class="container">
                <h2>About Me</h2>
                <div class="about-content">
                    <div class="about-text">
                        <p>{}</p>
                    </div>
                    <div class="about-skills">
                        <h3>Skills</h3>
                        <div class="skills-grid">
                            <div class="skill-item">HTML/CSS</div>

                            <div class="skill-item">JavaScript</div>
                            <div class="skill-item">React</div>

                            <div class="skill-item">Node.js</div>
                        </div>
                    </div>
                </div>

            </div>
        </section>

        <section id="portfolio" class="portfolio-section">
            <div class="container">
                <h2>My Portfolio</h2>
                <div class="portfolio-grid">
                    <div class="portfolio-item">
                        <div class="portfolio-image">
                            <img src="project1.jpg" alt="Project 1">

                        </div>
                        <div class="portfolio-info">
                            <h3>Project One</h3>
                            <p>Description of project one</p>
                            <div class="portfolio-links">
                                <a href="#" class="portfolio-link">Live Demo</a>
                                <a href="#" class="portfolio-link">Code</a>
                            </div>
                        </div>
                    </div>
                    {}
                </div>
            </div>

        </section>

        <section id="contact" class="contact-section">
            <div class="container">
                <h2>Get In Touch</h2>
                <div class="contact-content">
                    <div class="contact-info">
                        <h3>Let's work together</h3>
                        <p>I'm always interested in new opportunities and collaborations.</p>
                        <div class="contact-methods">

                            <div class="contact-method">
                                <span class="contact-icon">📧</span>
                                <a href="mailto:{}">{}</a>
                            </div>
                            <div class="contact-method">
                                <span class="contact-icon">💼</span>
                                <a href="#">LinkedIn</a>
                            </div>
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
                        <button type="submit" class="submit-btn">Send Message</button>

                    </form>

                </div>
            </div>
        </section>
    </main>

    <footer class="portfolio-footer">

        <div class="container">
            <p>&copy; {} {}. All rights reserved.</p>

        </div>
    </footer>

</body>
</html>
      ]], {
        i(1, "Your Name"),
        i(2, "Your Name"),
        i(3, "Your Name"),
        i(4, "Your professional title/description"),
        i(5, "About me text"),
        i(6, "Additional portfolio items"),
        i(7, "your@email.com"),
        rep(7),
        f(get_year, {}),
        i(8, "Your Name"),

        i(0)
      })),

      -- Component snippets
      s("navbar", fmt([[

<nav class="navbar">
    <div class="nav-container">
        <div class="nav-logo">

            <a href="/">{}</a>
        </div>
        <ul class="nav-menu">

            <li class="nav-item">

                <a href="#home" class="nav-link">Home</a>
            </li>
            <li class="nav-item">
                <a href="#about" class="nav-link">About</a>
            </li>
            <li class="nav-item">
                <a href="#services" class="nav-link">Services</a>

            </li>
            <li class="nav-item">
                <a href="#contact" class="nav-link">Contact</a>
            </li>

        </ul>
        <button class="nav-toggle">
            <span class="bar"></span>
            <span class="bar"></span>

            <span class="bar"></span>
        </button>
    </div>

</nav>
      ]], {
        i(1, "Brand Name"),
        i(0)
      })),

      s("hero", fmt([[

<section class="hero">
    <div class="hero-container">
        <div class="hero-content">
            <h1 class="hero-title">{}</h1>
            <p class="hero-subtitle">{}</p>
            <div class="hero-buttons">
                <a href="#contact" class="btn btn-primary">{}</a>
                <a href="#about" class="btn btn-secondary">{}</a>
            </div>
        </div>
        <div class="hero-image">
            <img src="{}" alt="Hero Image">
        </div>
    </div>

</section>
      ]], {
        i(1, "Hero Title"),
        i(2, "Hero subtitle description"),
        i(3, "Primary CTA"),
        i(4, "Secondary CTA"),
        i(5, "hero-image.jpg"),
        i(0)
      })),

      s("card", fmt([[

<div class="card">
    <div class="card-header">

        <h3 class="card-title">{}</h3>
    </div>

    <div class="card-body">
        <p class="card-text">{}</p>

    </div>
    <div class="card-footer">
        <a href="#" class="btn btn-primary">{}</a>
    </div>

</div>
      ]], {
        i(1, "Card Title"),

        i(2, "Card content"),
        i(3, "Action Button"),
        i(0)
      })),


    })

    -- CSS Snippets

    ls.add_snippets("css", {

      -- Modern CSS Reset
      s("reset", fmt([[

/_ Modern CSS Reset _/
_, _::before, \*::after {{
box-sizing: border-box;

}}

- {{
      margin: 0;
      padding: 0;
  }}

html, body {{
    height: 100%;
}}

body {{
    line-height: 1.5;
    -webkit-font-smoothing: antialiased;
}}

img, picture, video, canvas, svg {{

    display: block;
    max-width: 100%;

}}

input, button, textarea, select {{
    font: inherit;
}}

p, h1, h2, h3, h4, h5, h6 {{
    overflow-wrap: break-word;
}}

#root, #\_\_next {{

    isolation: isolate;

}}

/_ Custom Properties _/
:root {{
--primary-color: {};
--secondary-color: {};
--accent-color: {};
--text-color: {};
--text-light: {};
--background-color: {};
--surface-color: {};
--border-color: {};

    --font-family-primary: {};
    --font-family-secondary: {};

    --font-size-xs: 0.75rem;
    --font-size-sm: 0.875rem;
    --font-size-base: 1rem;
    --font-size-lg: 1.125rem;
    --font-size-xl: 1.25rem;
    --font-size-2xl: 1.5rem;
    --font-size-3xl: 1.875rem;
    --font-size-4xl: 2.25rem;
    --font-size-5xl: 3rem;


    --spacing-xs: 0.25rem;
    --spacing-sm: 0.5rem;
    --spacing-md: 1rem;
    --spacing-lg: 1.5rem;
    --spacing-xl: 2rem;
    --spacing-2xl: 3rem;
    --spacing-3xl: 4rem;

    --border-radius-sm: 0.125rem;
    --border-radius-md: 0.375rem;
    --border-radius-lg: 0.5rem;
    --border-radius-xl: 0.75rem;
    --border-radius-full: 9999px;

    --shadow-sm: 0 1px 2px 0 rgb(0 0 0 / 0.05);
    --shadow-md: 0 4px 6px -1px rgb(0 0 0 / 0.1), 0 2px 4px -2px rgb(0 0 0 / 0.1);

    --shadow-lg: 0 10px 15px -3px rgb(0 0 0 / 0.1), 0 4px 6px -4px rgb(0 0 0 / 0.1);
    --shadow-xl: 0 20px 25px -5px rgb(0 0 0 / 0.1), 0 8px 10px -6px rgb(0 0 0 / 0.1);


    --transition-fast: 150ms ease;
    --transition-base: 250ms ease;
    --transition-slow: 350ms ease;

}}

/_ Body Styles _/
body {{

    font-family: var(--font-family-primary);
    font-size: var(--font-size-base);
    line-height: 1.6;
    color: var(--text-color);
    background-color: var(--background-color);

}}

/_ Utility Classes _/
.container {{
    max-width: 1200px;
    margin: 0 auto;
    padding: 0 var(--spacing-md);
}}

.visually-hidden {{
    position: absolute;
    width: 1px;
    height: 1px;
    padding: 0;
    margin: -1px;
    overflow: hidden;
    clip: rect(0, 0, 0, 0);
    white-space: nowrap;
    border: 0;
}}

.skip-link {{
position: absolute;

    top: -40px;
    left: 6px;
    background: var(--primary-color);

    color: white;
    padding: 8px;
    text-decoration: none;

    z-index: 100;
    border-radius: var(--border-radius-md);

}}

.skip-link:focus {{
    top: 6px;
}}

{}
]], {
i(1, "#3B82F6"),
i(2, "#64748B"),
i(3, "#F59E0B"),

        i(4, "#1F2937"),
        i(5, "#6B7280"),
        i(6, "#FFFFFF"),

        i(7, "#F8FAFC"),
        i(8, "#E5E7EB"),
        i(9, "'Inter', -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif"),
        i(10, "'JetBrains Mono', 'Fira Code', monospace"),
        i(0)
      })),

      -- Glassmorphism Styles

      s("glassmorphism", fmt([[

/_ Glassmorphism Styles _/
.glass-effect {{
background: rgba(255, 255, 255, 0.25);
backdrop-filter: blur(10px);
-webkit-backdrop-filter: blur(10px);

    border-radius: var(--border-radius-lg);
    border: 1px solid rgba(255, 255, 255, 0.18);
    box-shadow: 0 8px 32px 0 rgba(31, 38, 135, 0.37);

}}

.glass-card {{
background: rgba(255, 255, 255, 0.1);
backdrop-filter: blur(15px);
-webkit-backdrop-filter: blur(15px);
border-radius: var(--border-radius-xl);
border: 1px solid rgba(255, 255, 255, 0.2);

    padding: var(--spacing-xl);
    transition: all var(--transition-base);

}}

.glass-card:hover {{
    background: rgba(255, 255, 255, 0.15);
    transform: translateY(-2px);
    box-shadow: 0 20px 40px 0 rgba(31, 38, 135, 0.4);
}}

.glass-btn {{

    background: rgba(255, 255, 255, 0.2);
    backdrop-filter: blur(10px);
    -webkit-backdrop-filter: blur(10px);
    border: 1px solid rgba(255, 255, 255, 0.3);

    border-radius: var(--border-radius-full);
    padding: var(--spacing-sm) var(--spacing-lg);
    color: white;
    text-decoration: none;
    font-weight: 500;

    transition: all var(--transition-base);
    cursor: pointer;

}}

.glass-btn:hover {{
    background: rgba(255, 255, 255, 0.3);
    transform: translateY(-1px);
}}

.glass-btn.primary {{
    background: rgba({}, 0.3);
    border-color: rgba({}, 0.5);
}}

.glass-btn.secondary {{
background: rgba({}, 0.2);

    border-color: rgba({}, 0.4);

}}

/_ Background Gradient _/
.background-gradient {{
position: fixed;
top: 0;
left: 0;
width: 100%;
height: 100%;

    background: linear-gradient(135deg, {}, {});
    z-index: -1;

}}

/_ Floating Shapes _/
.floating-shapes {{
position: fixed;
top: 0;
left: 0;
width: 100%;

    height: 100%;
    pointer-events: none;
    z-index: -1;

}}

.shape {{
    position: absolute;
    border-radius: 50%;
    opacity: 0.1;
    animation: float 6s ease-in-out infinite;
}}

.shape-1 {{
width: 80px;
height: 80px;
background: {};

    top: 20%;
    left: 10%;
    animation-delay: 0s;

}}

.shape-2 {{
    width: 60px;
    height: 60px;
    background: {};
    top: 60%;
    right: 20%;
    animation-delay: 2s;
}}

.shape-3 {{
    width: 100px;
    height: 100px;
    background: {};
    bottom: 20%;
    left: 60%;
    animation-delay: 4s;
}}

@keyframes float {{
    0%, 100% {{
        transform: translateY(0px);
    }}
50% {{
transform: translateY(-20px);
