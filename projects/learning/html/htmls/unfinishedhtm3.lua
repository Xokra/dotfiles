-- ~/.config/nvim/lua/zedocean/plugins/html-templates.lua

return {
  name = "html-templates",
  dir = vim.fn.stdpath("config") .. "/lua/zedocean/plugins/html-templates",

  config = function()
    local M = {}


    -- Template configurations
    local templates = {

      {
        name = "minimal-modern",

        display = "Minimal Modern",
        description = "Clean, modern design with subtle animations",
        primary_color = "#2563eb",
        secondary_color = "#f8fafc",

        accent_color = "#10b981"
      },
      {
        name = "rich-traditional",
        display = "Rich Traditional",
        description = "Elegant, classic design with rich typography",
        primary_color = "#92400e",
        secondary_color = "#fef3c7",

        accent_color = "#dc2626"
      },
      {
        name = "functional-dashboard",
        display = "Functional Dashboard",
        description = "Data-focused, clean interface design",
        primary_color = "#1e40af",
        secondary_color = "#f1f5f9",

        accent_color = "#059669"
      },
      {
        name = "experiential-luxury",

        display = "Experiential Luxury",
        description = "Immersive, premium feel with rich interactions",
        primary_color = "#7c2d12",
        secondary_color = "#fef7ed",

        accent_color = "#ea580c"
      },
      {
        name = "clean-business",
        display = "Clean Business",
        description = "Professional, trustworthy corporate design",
        primary_color = "#1e293b",
        secondary_color = "#f8fafc",
        accent_color = "#0ea5e9"
      },
      {

        name = "trendy-interactive",
        display = "Trendy Interactive",
        description = "Bold, modern with engaging micro-interactions",
        primary_color = "#7c3aed",
        secondary_color = "#faf5ff",
        accent_color = "#f59e0b"
      }
    }

    -- Function to create project structure
    local function create_project_structure(project_name, template_config)
      local project_path = vim.fn.getcwd() .. "/" .. project_name
      
      -- Create directories
      local dirs = {
        project_path,
        project_path .. "/assets",
        project_path .. "/assets/css",
        project_path .. "/assets/js",
        project_path .. "/assets/images",
        project_path .. "/assets/fonts"
      }

      
      for _, dir in ipairs(dirs) do
        vim.fn.mkdir(dir, "p")
      end
      
      return project_path
    end

    -- Function to generate HTML template
    local function generate_html_template(template_config, project_name)

      local html = string.format([[<!DOCTYPE html>

<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="%s - Professional web solution">
    <meta name="keywords" content="web design, professional, modern">

    <meta name="author" content="Your Name">
    
    <!-- Open Graph / Facebook -->
    <meta property="og:type" content="website">
    <meta property="og:url" content="">
    <meta property="og:title" content="%s">
    <meta property="og:description" content="%s - Professional web solution">
    <meta property="og:image" content="./assets/images/og-image.jpg">
    

    <!-- Twitter -->
    <meta property="twitter:card" content="summary_large_image">
    <meta property="twitter:url" content="">
    <meta property="twitter:title" content="%s">

    <meta property="twitter:description" content="%s - Professional web solution">
    <meta property="twitter:image" content="./assets/images/og-image.jpg">
    
    <title>%s</title>
    
    <!-- Preload critical resources -->
    <link rel="preload" href="./assets/css/style.css" as="style">
    <link rel="preload" href="./assets/js/main.js" as="script">
    

    <!-- Stylesheets -->
    <link rel="stylesheet" href="./assets/css/style.css">
    

    <!-- Favicon -->
    <link rel="icon" type="image/svg+xml" href="./assets/images/favicon.svg">
    <link rel="icon" type="image/png" href="./assets/images/favicon.png">

</head>
<body>
    <!-- Header -->
    <header class="header">
        <nav class="nav">
            <div class="nav-container">
                <div class="nav-logo">
                    <a href="#" class="logo">%s</a>
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
                <div class="nav-toggle">
                    <span class="bar"></span>
                    <span class="bar"></span>
                    <span class="bar"></span>

                </div>
            </div>
        </nav>
    </header>

    <!-- Main Content -->
    <main class="main">
        <!-- Hero Section -->
        <section id="home" class="hero">
            <div class="hero-container">
                <div class="hero-content">
                    <h1 class="hero-title">
                        Welcome to <span class="highlight">%s</span>

                    </h1>
                    <p class="hero-subtitle">
                        Professional web solutions that make an impact
                    </p>
                    <div class="hero-buttons">
                        <a href="#contact" class="btn btn-primary">Get Started</a>
                        <a href="#about" class="btn btn-secondary">Learn More</a>
                    </div>
                </div>
                <div class="hero-image">
                    <div class="hero-placeholder">
                        <div class="placeholder-content">
                            <div class="placeholder-icon">🚀</div>
                            <p>Hero Image</p>

                        </div>
                    </div>
                </div>
            </div>
        </section>

        <!-- About Section -->
        <section id="about" class="about">

            <div class="container">
                <h2 class="section-title">About Us</h2>
                <div class="about-content">
                    <div class="about-text">
                        <p>We create exceptional web experiences that drive results for your business.</p>
                        <p>Our team combines creative design with cutting-edge technology to deliver solutions that exceed expectations.</p>
                    </div>
                    <div class="about-stats">
                        <div class="stat">
                            <div class="stat-number">100+</div>
                            <div class="stat-label">Projects</div>

                        </div>
                        <div class="stat">
                            <div class="stat-number">50+</div>
                            <div class="stat-label">Clients</div>
                        </div>
                        <div class="stat">
                            <div class="stat-number">5+</div>
                            <div class="stat-label">Years</div>
                        </div>
                    </div>
                </div>

            </div>
        </section>


        <!-- Services Section -->
        <section id="services" class="services">
            <div class="container">
                <h2 class="section-title">Our Services</h2>
                <div class="services-grid">
                    <div class="service-card">
                        <div class="service-icon">🎨</div>
                        <h3 class="service-title">Web Design</h3>

                        <p class="service-description">Custom designs that reflect your brand and engage your audience.</p>
                    </div>
                    <div class="service-card">
                        <div class="service-icon">⚡</div>
                        <h3 class="service-title">Development</h3>

                        <p class="service-description">Fast, responsive websites built with modern technologies.</p>
                    </div>
                    <div class="service-card">
                        <div class="service-icon">📱</div>
                        <h3 class="service-title">Mobile First</h3>
                        <p class="service-description">Optimized experiences across all devices and screen sizes.</p>
                    </div>

                </div>
            </div>
        </section>

        <!-- Contact Section -->
        <section id="contact" class="contact">
            <div class="container">
                <h2 class="section-title">Get In Touch</h2>
                <div class="contact-content">

                    <div class="contact-info">
                        <h3>Let's work together</h3>
                        <p>Ready to start your next project? Contact us today for a free consultation.</p>
                        <div class="contact-details">
                            <div class="contact-item">
                                <span class="contact-icon">📧</span>
                                <span>hello@example.com</span>
                            </div>

                            <div class="contact-item">
                                <span class="contact-icon">📱</span>
                                <span>+1 (555) 123-4567</span>
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
                        <button type="submit" class="btn btn-primary">Send Message</button>
                    </form>
                </div>

            </div>

        </section>
    </main>

    <!-- Footer -->
    <footer class="footer">
        <div class="container">
            <div class="footer-content">
                <div class="footer-section">
                    <h4>%s</h4>
                    <p>Professional web solutions that make an impact.</p>
                </div>
                <div class="footer-section">
                    <h4>Quick Links</h4>
                    <ul>
                        <li><a href="#home">Home</a></li>
                        <li><a href="#about">About</a></li>
                        <li><a href="#services">Services</a></li>
                        <li><a href="#contact">Contact</a></li>
                    </ul>

                </div>
                <div class="footer-section">
                    <h4>Follow Us</h4>
                    <div class="social-links">
                        <a href="#" class="social-link">Twitter</a>
                        <a href="#" class="social-link">LinkedIn</a>
                        <a href="#" class="social-link">GitHub</a>
                    </div>
                </div>
            </div>
            <div class="footer-bottom">
                <p>&copy; 2024 %s. All rights reserved.</p>

            </div>

        </div>
    </footer>


    <!-- Scripts -->
    <script src="./assets/js/main.js"></script>
</body>
</html>]], 
        project_name, project_name, project_name, project_name, project_name, project_name, 
        project_name, project_name, project_name, project_name, project_name)
      
      return html
    end


    -- Function to generate CSS template
    local function generate_css_template(template_config)
      local css = string.format([[/* CSS Reset and Base Styles */

* {

    margin: 0;
    padding: 0;
    box-sizing: border-box;
}

:root {

    --primary-color: %s;
    --secondary-color: %s;
    --accent-color: %s;

    --text-primary: #1a1a1a;
    --text-secondary: #6b7280;
    --white: #ffffff;
    --gray-100: #f3f4f6;
    --gray-200: #e5e7eb;

    --gray-300: #d1d5db;
    --shadow-sm: 0 1px 2px 0 rgba(0, 0, 0, 0.05);
    --shadow-md: 0 4px 6px -1px rgba(0, 0, 0, 0.1), 0 2px 4px -1px rgba(0, 0, 0, 0.06);
    --shadow-lg: 0 10px 15px -3px rgba(0, 0, 0, 0.1), 0 4px 6px -2px rgba(0, 0, 0, 0.05);
    --transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
}


html {
    scroll-behavior: smooth;
}

body {
    font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Oxygen, Ubuntu, Cantarell, sans-serif;
    line-height: 1.6;
    color: var(--text-primary);
    background-color: var(--white);
}


.container {
    max-width: 1200px;
    margin: 0 auto;
    padding: 0 1rem;
}


/* Header Styles */
.header {
    position: fixed;
    top: 0;
    width: 100%%;

    background-color: rgba(255, 255, 255, 0.95);
    backdrop-filter: blur(10px);
    z-index: 1000;
    transition: var(--transition);
}


.nav {
    padding: 1rem 0;
}

.nav-container {

    display: flex;
    justify-content: space-between;
    align-items: center;
    max-width: 1200px;
    margin: 0 auto;
    padding: 0 1rem;
}


.logo {
    font-size: 1.5rem;

    font-weight: bold;
    color: var(--primary-color);

    text-decoration: none;
    transition: var(--transition);
}

.logo:hover {

    opacity: 0.8;
}

.nav-menu {
    display: flex;
    list-style: none;
    gap: 2rem;
}

.nav-link {
    color: var(--text-primary);

    text-decoration: none;
    font-weight: 500;

    transition: var(--transition);

    position: relative;
}


.nav-link::after {
    content: '';
    position: absolute;
    bottom: -5px;
    left: 0;
    width: 0;

    height: 2px;
    background-color: var(--primary-color);
    transition: var(--transition);
}

.nav-link:hover::after {
    width: 100%%;
}

.nav-toggle {
    display: none;
    flex-direction: column;

    cursor: pointer;

}


.bar {
    width: 25px;
    height: 3px;
    background-color: var(--text-primary);
    margin: 3px 0;

    transition: var(--transition);

}


/* Main Content */
.main {
    margin-top: 80px;
}

/* Hero Section */
.hero {
    min-height: 100vh;
    display: flex;
    align-items: center;
    background: linear-gradient(135deg, var(--secondary-color) 0%%, rgba(255, 255, 255, 0.8) 100%%);

    position: relative;
    overflow: hidden;
}


.hero-container {

    max-width: 1200px;
    margin: 0 auto;
    padding: 0 1rem;
    display: grid;

    grid-template-columns: 1fr 1fr;
    gap: 4rem;

    align-items: center;
}

.hero-title {
    font-size: clamp(2.5rem, 5vw, 4rem);
    font-weight: bold;
    line-height: 1.2;
    margin-bottom: 1rem;
    color: var(--text-primary);

}


.highlight {

    color: var(--primary-color);
    position: relative;

}


.hero-subtitle {
    font-size: 1.25rem;

    color: var(--text-secondary);
    margin-bottom: 2rem;
    line-height: 1.6;
}


.hero-buttons {
    display: flex;
    gap: 1rem;
    flex-wrap: wrap;
}

.btn {

    display: inline-block;
    padding: 0.75rem 1.5rem;
    border-radius: 0.5rem;
    text-decoration: none;
    font-weight: 600;
    transition: var(--transition);
    border: 2px solid transparent;
    cursor: pointer;
    font-size: 1rem;
}

.btn-primary {
    background-color: var(--primary-color);
    color: var(--white);
    border-color: var(--primary-color);

}


.btn-primary:hover {

    background-color: transparent;
    color: var(--primary-color);
    transform: translateY(-2px);
    box-shadow: var(--shadow-lg);
}


.btn-secondary {
    background-color: transparent;
    color: var(--primary-color);
    border-color: var(--primary-color);

}


.btn-secondary:hover {
    background-color: var(--primary-color);
    color: var(--white);
    transform: translateY(-2px);

    box-shadow: var(--shadow-lg);

}


.hero-image {

    display: flex;
    justify-content: center;
    align-items: center;
}


.hero-placeholder {
    width: 100%%;

    height: 400px;
    background: linear-gradient(135deg, var(--gray-100) 0%%, var(--gray-200) 100%%);

    border-radius: 1rem;
    display: flex;
    align-items: center;
    justify-content: center;
    position: relative;
    overflow: hidden;
}


.placeholder-content {
    text-align: center;

    color: var(--text-secondary);
}

.placeholder-icon {
    font-size: 3rem;
    margin-bottom: 1rem;
}

/* Section Styles */
section {
    padding: 5rem 0;
}

.section-title {
    font-size: 2.5rem;

    font-weight: bold;
    text-align: center;
    margin-bottom: 3rem;

    color: var(--text-primary);
}

/* About Section */

.about {
    background-color: var(--gray-100);

}


.about-content {
    display: grid;
    grid-template-columns: 2fr 1fr;

    gap: 4rem;
    align-items: center;
}

.about-text {

    font-size: 1.125rem;
    line-height: 1.8;
    color: var(--text-secondary);
}


.about-text p {
    margin-bottom: 1.5rem;
}

.about-stats {
    display: flex;
    flex-direction: column;
    gap: 2rem;
}

.stat {

    text-align: center;
    padding: 1.5rem;
    background-color: var(--white);
    border-radius: 0.5rem;
    box-shadow: var(--shadow-sm);
}

.stat-number {
    font-size: 2rem;
    font-weight: bold;
    color: var(--primary-color);
}


.stat-label {
    color: var(--text-secondary);
    font-weight: 500;
}

/* Services Section */
.services-grid {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
    gap: 2rem;
}

.service-card {

    background-color: var(--white);
    padding: 2rem;

    border-radius: 1rem;
    text-align: center;
    box-shadow: var(--shadow-md);
    transition: var(--transition);
}

.service-card:hover {

    transform: translateY(-5px);
    box-shadow: var(--shadow-lg);
}

.service-icon {

    font-size: 3rem;

    margin-bottom: 1rem;
}

.service-title {

    font-size: 1.5rem;
    font-weight: bold;
    margin-bottom: 1rem;

    color: var(--text-primary);
}

.service-description {

    color: var(--text-secondary);
    line-height: 1.6;

}


/* Contact Section */
.contact {
    background-color: var(--gray-100);
}

.contact-content {
    display: grid;
    grid-template-columns: 1fr 1fr;

    gap: 4rem;
}


.contact-info h3 {
    font-size: 1.5rem;
    margin-bottom: 1rem;
    color: var(--text-primary);
}


.contact-info p {

    color: var(--text-secondary);

    margin-bottom: 2rem;
    line-height: 1.6;
}

.contact-details {
    display: flex;

    flex-direction: column;

    gap: 1rem;
}

.contact-item {
    display: flex;
    align-items: center;
    gap: 0.5rem;
}


.contact-icon {
    font-size: 1.25rem;

}


.contact-form {
    background-color: var(--white);
    padding: 2rem;
    border-radius: 1rem;
    box-shadow: var(--shadow-sm);
}

.form-group {
    margin-bottom: 1.5rem;
}

.form-group label {
    display: block;
    margin-bottom: 0.5rem;

    font-weight: 500;
    color: var(--text-primary);
}

.form-group input,
.form-group textarea {
    width: 100%%;
    padding: 0.75rem;
    border: 2px solid var(--gray-200);
    border-radius: 0.5rem;

    font-size: 1rem;

    transition: var(--transition);

}


.form-group input:focus,
.form-group textarea:focus {
    outline: none;
    border-color: var(--primary-color);

    box-shadow: 0 0 0 3px rgba(37, 99, 235, 0.1);
}

/* Footer */

.footer {
    background-color: var(--text-primary);
    color: var(--white);
    padding: 3rem 0 1rem;

}


.footer-content {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
    gap: 2rem;
    margin-bottom: 2rem;
}

.footer-section h4 {
    margin-bottom: 1rem;
    color: var(--white);
}


.footer-section ul {
    list-style: none;
}

.footer-section li {
    margin-bottom: 0.5rem;
}


.footer-section a {
    color: var(--gray-300);
    text-decoration: none;

    transition: var(--transition);

}


.footer-section a:hover {
    color: var(--white);
}

.social-links {

    display: flex;
    gap: 1rem;

}


.social-link {
    color: var(--gray-300);
    text-decoration: none;

    transition: var(--transition);

}


.social-link:hover {
    color: var(--accent-color);
}

.footer-bottom {
    text-align: center;
    padding-top: 2rem;

    border-top: 1px solid var(--gray-300);
    color: var(--gray-300);

}


/* Responsive Design */
@media (max-width: 768px) {
    .nav-menu {
        position: fixed;

        left: -100%%;
        top: 70px;
        flex-direction: column;
        background-color: var(--white);
        width: 100%%;
        text-align: center;
        transition: var(--transition);

        box-shadow: var(--shadow-md);
        padding: 2rem 0;
        gap: 1rem;
    }


    .nav-menu.active {
        left: 0;
    }


    .nav-toggle {

        display: flex;
    }

    .hero-container {
        grid-template-columns: 1fr;
        gap: 2rem;
        text-align: center;
    }

    .hero-placeholder {
        height: 300px;
    }


    .about-content {

        grid-template-columns: 1fr;
        gap: 2rem;
    }


    .about-stats {
        flex-direction: row;
        justify-content: space-around;

    }

    .contact-content {
        grid-template-columns: 1fr;
        gap: 2rem;
    }


    .hero-buttons {
        justify-content: center;
    }
}


@media (max-width: 480px) {
    .hero-buttons {
        flex-direction: column;

        align-items: center;

    }
    

    .btn {
        width: 100%%;
        text-align: center;

    }
}

/* Animation Classes */

.fade-in {
    opacity: 0;

    animation: fadeIn 0.8s ease-out forwards;
}


@keyframes fadeIn {
    to {

        opacity: 1;
    }

}


.slide-up {
    transform: translateY(30px);
    opacity: 0;

    animation: slideUp 0.8s ease-out forwards;
}


@keyframes slideUp {
    to {
        transform: translateY(0);
        opacity: 1;

    }
}]], template_config.primary_color, template_config.secondary_color, template_config.accent_color)
      

      return css
    end


    -- Function to generate JavaScript template
    local function generate_js_template()
      local js = [[// Main JavaScript file for interactive features


document.addEventListener('DOMContentLoaded', function() {

    // Mobile menu toggle
    const navToggle = document.querySelector('.nav-toggle');

    const navMenu = document.querySelector('.nav-menu');


    if (navToggle && navMenu) {
        navToggle.addEventListener('click', function() {
            navMenu.classList.toggle('active');
            
            // Animate hamburger menu
            const bars = navToggle.querySelectorAll('.bar');

            bars.forEach((bar, index) => {
                if (navMenu.classList.contains('active')) {

                    if (index === 0) bar.style.transform = 'rotate(45deg) translate(5px, 5px)';

                    if (index === 1) bar.style.opacity = '0';
                    if (index === 2) bar.style.transform = 'rotate(-45deg) translate(7px, -6px)';
                } else {

                    bar.style.transform = 'none';
                    bar.style.opacity = '1';
                }
            });
        });
    }


    // Close mobile menu when clicking on a link
    const navLinks = document.querySelectorAll('.nav-link');

    navLinks.forEach(link => {
        link.addEventListener('click', function() {
            if (navMenu.classList.contains('active')) {
                navMenu.classList.remove('active');
                const bars = navToggle.querySelectorAll('.bar');
                bars.forEach(bar => {
                    bar.style.transform = 'none';
                    bar.style.opacity = '1';
                });
            }
        });
    });

    // Smooth scrolling for navigation links
    navLinks.forEach(link => {
        link.addEventListener('click', function(e) {

            e.preventDefault();
            const targetId = this.getAttribute('href').substring(1);
            const targetSection = document.getElementById(targetId);

            
            if (targetSection) {
                const headerOffset = 80;
                const elementPosition = targetSection.getBoundingClientRect().top;
                const offsetPosition = elementPosition + window.pageYOffset - headerOffset;

                window.scrollTo({
                    top: offsetPosition,

                    behavior: 'smooth'
                });
            }
        });
    });


    // Header scroll effect
    const header = document.querySelector('.header');
    let lastScrollY = window.scrollY;


    window.addEventListener('scroll', function() {
        if (window.scrollY > 100) {

            header.style.backgroundColor = 'rgba(255, 255, 255, 0.98)';
            header.style.boxShadow = '0 2px 10px rgba(0, 0, 0, 0.1)';

        } else {
            header.style.backgroundColor = 'rgba(255, 255, 255, 0.95)';
            header.style.boxShadow = 'none';
        }
        
        lastScrollY = window.scrollY;
    });

    // Intersection Observer for animations
    const observerOptions = {
        threshold: 0.1,
        rootMargin: '0px 0px -50px 0px'
    };


    const observer = new IntersectionObserver(function(entries) {
        entries.forEach(entry => {
            if (entry.isIntersecting) {
                entry.target.classList.add('fade-in');

            }

        });

    }, observerOptions);

    // Observe elements for animation
    const animatedElements = document.querySelectorAll('.service-card, .stat, .hero-content');

    animatedElements.forEach(el => observer.observe(el));

    // Form submission

    const contactForm = document.querySelector('.contact-form');

    if (contactForm) {
        contactForm.addEventListener('submit', function(e) {
            e.preventDefault();

            
            // Get form data
            const formData = new FormData(this);
            const data = Object.fromEntries(formData);
            
            // Show loading state
            const submitButton = this.querySelector('button[type="submit"]');
            const originalText = submitButton.textContent
