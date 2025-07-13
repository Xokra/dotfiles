-- ~/.config/nvim/lua/zedocean/plugins/html-template-generator.lua

local M = {}

-- Template configurations
local templates = {
landing = {
name = "Landing Page",
description = "Modern landing page template",
files = {
"index.html",
"styles.css",
"script.js"
}
},
portfolio = {

    name = "Portfolio",
    description = "Creative portfolio template",
    files = {
      "index.html",
      "portfolio.css",
      "portfolio.js"

    }

},
business = {
name = "Business Site",
description = "Professional business website",
files = {
"index.html",
"business.css",

      "business.js"

    }

},
ecommerce = {
name = "E-commerce",
description = "Online store template",
files = {
"index.html",
"shop.css",
"shop.js"
}
}
}

-- Style variations
local styles = {

modern = {

    name = "Modern",
    description = "Contemporary design with glassmorphism",
    suffix = "-modern"

},
minimal = {
name = "Minimal",
description = "Clean, simple design",
suffix = "-minimal"
},
classic = {
name = "Classic",
description = "Traditional, professional look",
suffix = "-classic"
},
creative = {

    name = "Creative",
    description = "Bold, artistic design",
    suffix = "-creative"

}

}

-- Color schemes
local color_schemes = {

oceanic = { primary = "#0ea5e9", secondary = "#06b6d4", accent = "#3b82f6" },
sunset = { primary = "#f59e0b", secondary = "#f97316", accent = "#ef4444" },
forest = { primary = "#10b981", secondary = "#059669", accent = "#0d9488" },
purple = { primary = "#8b5cf6", secondary = "#a855f7", accent = "#c084fc" },
monochrome = { primary = "#374151", secondary = "#6b7280", accent = "#9ca3af" }

}

-- Utility function for creating directories

local function create_directory(path)
vim.fn.mkdir(path, "p")
end

-- Function to replace placeholders in template content
local function replace_placeholders(content, replacements)
for key, value in pairs(replacements) do
content = content:gsub("{{" .. key .. "}}", value)
end
return content
end

-- Function to generate HTML template
local function generate_html_template(template_type, style_type, color_scheme, project_name)
local html_content = ""

if template_type == "landing" then
html_content = [[

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>{{project_name}}</title>
    <link rel="stylesheet" href="styles.css">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">
</head>
<body>

    <!-- Navigation -->
    <nav class="navbar">
        <div class="nav-container">
            <div class="nav-logo">
                <h2>{{project_name}}</h2>
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

    <!-- Hero Section -->

    <section id="home" class="hero">
        <div class="hero-container">

            <div class="hero-content">
                <h1 class="hero-title">Welcome to {{project_name}}</h1>
                <p class="hero-subtitle">Creating amazing experiences with cutting-edge design and technology</p>
                <div class="hero-buttons">
                    <a href="#services" class="btn btn-primary">Get Started</a>
                    <a href="#about" class="btn btn-secondary">Learn More</a>
                </div>
            </div>
            <div class="hero-image">
                <div class="hero-graphic"></div>
            </div>
        </div>
    </section>

    <!-- About Section -->
    <section id="about" class="about">
        <div class="container">
            <h2 class="section-title">About Us</h2>
            <div class="about-content">

                <div class="about-text">
                    <p>We are passionate about creating exceptional digital experiences that combine beautiful design with powerful functionality.</p>
                    <ul class="feature-list">
                        <li>Modern Design Principles</li>
                        <li>Responsive Development</li>
                        <li>Performance Optimization</li>
                        <li>User Experience Focus</li>
                    </ul>
                </div>
                <div class="about-stats">
                    <div class="stat">
                        <h3>100+</h3>
                        <p>Projects Completed</p>
                    </div>
                    <div class="stat">
                        <h3>50+</h3>
                        <p>Happy Clients</p>

                    </div>
                    <div class="stat">
                        <h3>5+</h3>
                        <p>Years Experience</p>
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
                    <h3>Web Design</h3>
                    <p>Beautiful, modern designs that capture your brand's essence</p>
                </div>
                <div class="service-card">
                    <div class="service-icon">💻</div>
                    <h3>Development</h3>
                    <p>Clean, efficient code that brings designs to life</p>
                </div>
                <div class="service-card">
                    <div class="service-icon">📱</div>
                    <h3>Responsive</h3>
                    <p>Perfect experience across all devices and screen sizes</p>
                </div>
                <div class="service-card">
                    <div class="service-icon">⚡</div>
                    <h3>Performance</h3>
                    <p>Lightning-fast loading times and smooth interactions</p>
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

                    <h3>Let's Start a Conversation</h3>

                    <p>Ready to bring your vision to life? We'd love to hear from you.</p>
                    <div class="contact-details">
                        <div class="contact-item">
                            <span class="contact-icon">📧</span>
                            <span>hello@{{project_name}}.com</span>
                        </div>
                        <div class="contact-item">
                            <span class="contact-icon">📱</span>
                            <span>+1 (555) 123-4567</span>

                        </div>
                    </div>
                </div>
                <form class="contact-form">
                    <input type="text" placeholder="Your Name" required>
                    <input type="email" placeholder="Your Email" required>
                    <textarea placeholder="Your Message" rows="5" required></textarea>
                    <button type="submit" class="btn btn-primary">Send Message</button>
                </form>
            </div>

        </div>
    </section>

    <!-- Footer -->
    <footer class="footer">
        <div class="container">
            <div class="footer-content">
                <div class="footer-logo">
                    <h3>{{project_name}}</h3>
                    <p>Creating exceptional digital experiences</p>
                </div>
                <div class="footer-links">
                    <a href="#home">Home</a>
                    <a href="#about">About</a>
                    <a href="#services">Services</a>
                    <a href="#contact">Contact</a>
                </div>
            </div>

            <div class="footer-bottom">
                <p>&copy; 2024 {{project_name}}. All rights reserved.</p>
            </div>
        </div>

    </footer>

    <script src="script.js"></script>

</body>
</html>
]]

end

return html_content
end

-- Function to generate CSS based on style and color scheme

local function generate_css_template(style_type, color_scheme)

local css_content = ""

if style_type == "modern" then

    css_content = [[

/_ Modern Glassmorphism Style _/

:root {
--primary-color: ]] .. color_scheme.primary .. [[;

    --secondary-color: ]] .. color_scheme.secondary .. [[;
    --accent-color: ]] .. color_scheme.accent .. [[;

    --glass-bg: rgba(255, 255, 255, 0.1);
    --glass-border: rgba(255, 255, 255, 0.2);
    --text-primary: #ffffff;
    --text-secondary: rgba(255, 255, 255, 0.8);

    --shadow: 0 8px 32px rgba(0, 0, 0, 0.1);

}

- {
  margin: 0;
  padding: 0;
  box-sizing: border-box;
  }

body {

    font-family: 'Inter', sans-serif;
    line-height: 1.6;
    color: var(--text-primary);

    background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
    min-height: 100vh;
    overflow-x: hidden;

}

.container {

    max-width: 1200px;
    margin: 0 auto;
    padding: 0 20px;

}

/_ Navigation _/

.navbar {
position: fixed;
top: 0;
width: 100%;

    background: var(--glass-bg);
    backdrop-filter: blur(20px);
    border-bottom: 1px solid var(--glass-border);
    z-index: 1000;
    transition: all 0.3s ease;

}

.nav-container {

    max-width: 1200px;
    margin: 0 auto;

    padding: 0 20px;

    display: flex;
    justify-content: space-between;
    align-items: center;
    height: 70px;

}

.nav-logo h2 {

    font-size: 1.8rem;
    font-weight: 700;
    background: linear-gradient(135deg, var(--primary-color), var(--accent-color));

    -webkit-background-clip: text;
    -webkit-text-fill-color: transparent;
    background-clip: text;

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
    transition: all 0.3s ease;
    position: relative;

}

.nav-link::after {
content: '';
position: absolute;

    bottom: -5px;
    left: 0;
    width: 0;
    height: 2px;
    background: var(--primary-color);
    transition: width 0.3s ease;

}

.nav-link:hover::after {

    width: 100%;

}

.nav-toggle {
display: none;
flex-direction: column;
cursor: pointer;
}

.bar {
width: 25px;
height: 3px;
background: var(--text-primary);

    margin: 3px 0;
    transition: 0.3s;

}

/_ Hero Section _/

.hero {
padding: 120px 0 80px;

    min-height: 100vh;
    display: flex;

    align-items: center;

}

.hero-container {
max-width: 1200px;
margin: 0 auto;
padding: 0 20px;
display: grid;

    grid-template-columns: 1fr 1fr;

    gap: 4rem;
    align-items: center;

}

.hero-title {
font-size: 3.5rem;

    font-weight: 700;
    margin-bottom: 1.5rem;

    background: linear-gradient(135deg, var(--text-primary), var(--text-secondary));
    -webkit-background-clip: text;
    -webkit-text-fill-color: transparent;

    background-clip: text;

}

.hero-subtitle {
font-size: 1.2rem;
color: var(--text-secondary);
margin-bottom: 2rem;
line-height: 1.8;
}

.hero-buttons {
display: flex;
gap: 1rem;
}

.btn {
padding: 12px 30px;

    border-radius: 50px;
    text-decoration: none;
    font-weight: 600;
    transition: all 0.3s ease;
    border: 2px solid transparent;
    position: relative;
    overflow: hidden;

}

.btn-primary {
background: var(--glass-bg);

    color: var(--text-primary);
    border-color: var(--glass-border);

    backdrop-filter: blur(20px);

}

.btn-primary::before {
content: '';
position: absolute;
top: 0;

    left: -100%;
    width: 100%;
    height: 100%;
    background: linear-gradient(90deg, transparent, rgba(255,255,255,0.2), transparent);

    transition: left 0.5s ease;

}

.btn-primary:hover::before {
left: 100%;
}

.btn-secondary {
background: transparent;
color: var(--text-primary);
border-color: var(--primary-color);

}

.btn-secondary:hover {
background: var(--primary-color);
transform: translateY(-2px);
box-shadow: var(--shadow);
}

.hero-graphic {
width: 400px;
height: 400px;

    background: var(--glass-bg);
    border-radius: 50%;
    backdrop-filter: blur(20px);

    border: 1px solid var(--glass-border);

    position: relative;
    animation: float 6s ease-in-out infinite;

}

.hero-graphic::before {

    content: '';
    position: absolute;

    top: 20px;
    left: 20px;
    right: 20px;

    bottom: 20px;
    background: linear-gradient(135deg, var(--primary-color), var(--accent-color));
    border-radius: 50%;
    opacity: 0.3;
    filter: blur(20px);

}

@keyframes float {

    0%, 100% { transform: translateY(0px); }
    50% { transform: translateY(-20px); }

}

/_ Sections _/
.section-title {
font-size: 2.5rem;
font-weight: 700;
text-align: center;

    margin-bottom: 3rem;
    background: linear-gradient(135deg, var(--primary-color), var(--accent-color));

    -webkit-background-clip: text;
    -webkit-text-fill-color: transparent;
    background-clip: text;

}

/_ About Section _/
.about {

    padding: 80px 0;

    background: var(--glass-bg);
    backdrop-filter: blur(20px);

}

.about-content {

    display: grid;
    grid-template-columns: 1fr 1fr;
    gap: 4rem;
    align-items: center;

}

.about-text p {
font-size: 1.1rem;

    margin-bottom: 2rem;
    color: var(--text-secondary);

}

.feature-list {
list-style: none;
}

.feature-list li {
padding: 0.5rem 0;
position: relative;
padding-left: 1.5rem;
}

.feature-list li::before {
content: '✓';
position: absolute;
left: 0;
color: var(--primary-color);
font-weight: bold;
}

.about-stats {

    display: grid;
    grid-template-columns: repeat(3, 1fr);
    gap: 2rem;

}

.stat {
text-align: center;
padding: 2rem;
background: var(--glass-bg);
border-radius: 20px;
border: 1px solid var(--glass-border);
backdrop-filter: blur(20px);
}

.stat h3 {
font-size: 2.5rem;
font-weight: 700;
color: var(--primary-color);
margin-bottom: 0.5rem;
}

/_ Services Section _/
.services {
padding: 80px 0;
}

.services-grid {
display: grid;

    grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));

    gap: 2rem;

}

.service-card {
background: var(--glass-bg);
padding: 2.5rem;
border-radius: 20px;
border: 1px solid var(--glass-border);
backdrop-filter: blur(20px);
text-align: center;

    transition: all 0.3s ease;
    position: relative;
    overflow: hidden;

}

.service-card::before {
content: '';
position: absolute;
top: 0;

    left: -100%;
    width: 100%;
    height: 100%;

    background: linear-gradient(90deg, transparent, rgba(255,255,255,0.1), transparent);

    transition: left 0.5s ease;

}

.service-card:hover::before {

    left: 100%;

}

.service-card:hover {
transform: translateY(-10px);
box-shadow: var(--shadow);
}

.service-icon {
font-size: 3rem;
margin-bottom: 1rem;

}

.service-card h3 {
font-size: 1.5rem;

    font-weight: 600;
    margin-bottom: 1rem;
    color: var(--primary-color);

}

/_ Contact Section _/

.contact {
padding: 80px 0;
background: var(--glass-bg);
backdrop-filter: blur(20px);
}

.contact-content {

    display: grid;
    grid-template-columns: 1fr 1fr;
    gap: 4rem;

}

.contact-info h3 {
font-size: 2rem;
margin-bottom: 1rem;

    color: var(--primary-color);

}

.contact-info p {
margin-bottom: 2rem;

    color: var(--text-secondary);

}

.contact-details {
display: flex;
flex-direction: column;
gap: 1rem;
}

.contact-item {
display: flex;
align-items: center;

    gap: 1rem;

}

.contact-icon {
font-size: 1.2rem;

}

.contact-form {
display: flex;

    flex-direction: column;

    gap: 1rem;

}

.contact-form input,

.contact-form textarea {
padding: 1rem;
border: 1px solid var(--glass-border);
border-radius: 10px;
background: var(--glass-bg);
color: var(--text-primary);
backdrop-filter: blur(20px);

    font-family: inherit;

}

.contact-form input::placeholder,
.contact-form textarea::placeholder {
color: var(--text-secondary);
}

/_ Footer _/
.footer {
padding: 40px 0;
background: rgba(0, 0, 0, 0.2);
backdrop-filter: blur(20px);
}

.footer-content {

    display: flex;
    justify-content: space-between;
    align-items: center;

    margin-bottom: 2rem;

}

.footer-logo h3 {
color: var(--primary-color);

    margin-bottom: 0.5rem;

}

.footer-links {

    display: flex;
    gap: 2rem;

}

.footer-links a {
color: var(--text-secondary);
text-decoration: none;
transition: color 0.3s ease;
}

.footer-links a:hover {
color: var(--primary-color);

}

.footer-bottom {
text-align: center;

    padding-top: 2rem;
    border-top: 1px solid var(--glass-border);
    color: var(--text-secondary);

}

/_ Responsive Design _/
@media (max-width: 768px) {
.nav-menu {

        position: fixed;
        left: -100%;
        top: 70px;
        flex-direction: column;
        background: var(--glass-bg);

        backdrop-filter: blur(20px);
        width: 100%;
        text-align: center;
        transition: 0.3s;

        box-shadow: var(--shadow);

    }



    .nav-menu.active {
        left: 0;
    }

    .nav-toggle {
        display: flex;
    }

    .hero-container {
        grid-template-columns: 1fr;
        text-align: center;
    }

    .hero-title {

        font-size: 2.5rem;
    }


    .about-content,
    .contact-content {
        grid-template-columns: 1fr;
    }

    .about-stats {
        grid-template-columns: 1fr;
    }

    .services-grid {
        grid-template-columns: 1fr;
    }

    .footer-content {
        flex-direction: column;
        gap: 2rem;
    }

}
]]
end

return css_content
end

-- Function to generate JavaScript
local function generate_js_template()

return [[
// Mobile Navigation Toggle

const navToggle = document.querySelector('.nav-toggle');
const navMenu = document.querySelector('.nav-menu');

navToggle.addEventListener('click', () => {
navMenu.classList.toggle('active');

});

// Close mobile menu when clicking on a link
document.querySelectorAll('.nav-link').forEach(link => {
link.addEventListener('click', () => {
navMenu.classList.remove('active');
});

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

// Navbar background change on scroll
window.addEventListener('scroll', () => {
const navbar = document.querySelector('.navbar');

    if (window.scrollY > 50) {
        navbar.style.background = 'rgba(255, 255, 255, 0.15)';

    } else {
        navbar.style.background = 'rgba(255, 255, 255, 0.1)';
    }

});

// Contact form handling
const contactForm = document.querySelector('.contact-form');
if (contactForm) {

    contactForm.addEventListener('submit', (e) => {
        e.preventDefault();

        // Get form data
        const formData = new FormData(contactForm);
        const name = formData.get('name');
        const email = formData.get('email');
        const message = formData.get('message');

        // Simple validation
        if (!name || !email || !message) {
            alert('Please fill in all fields');

            return;
        }

        // Here you would typically send the data to your server
        console.log('Form submitted:', { name, email, message });
        alert('Thank you for your message! We\'ll get back to you soon.');

        // Reset form
        contactForm.reset();
    });

}

// Intersection Observer for animations
const observerOptions = {
threshold: 0.1,
rootMargin: '0px 0px -50px 0px'
};

const observer = new IntersectionObserver((entries) => {
entries.forEach(entry => {
if (entry.isIntersecting) {
entry.target.style.opacity = '1';
entry.target.style.transform = 'translateY(0)';
}
});
}, observerOptions);

// Observe all sections for animation
document.querySelectorAll('section').forEach(section => {

    section.style.opacity = '0';
    section.style.transform = 'translateY(20px)';
    section.style.transition = 'all 0.6s ease-out';

    observer.observe(section);

});

// Service cards hover effect
document.querySelectorAll('.service-card').forEach(card => {
card.addEventListener('mouseenter', () => {
card.style.transform = 'translateY(-10px) scale(1.02)';
});

    card.addEventListener('mouseleave', () => {
        card.style.transform = 'translateY(0) scale(1)';
    });

});

// Stats counter animation
const animateStats = () => {
const stats = document.querySelectorAll('.stat h3');
stats.forEach(stat => {
const target = parseInt(stat.textContent);
const increment = target / 100;
let current = 0;

        const timer = setInterval(() => {
            current += increment;
            stat.textContent = Math.floor(current) + '+';

            if (current >= target) {

                stat.textContent = target + '+';
                clearInterval(timer);

            }
        }, 20);
    });

};

// Trigger stats animation when about section is visible
const aboutSection = document.querySelector('.about');
if (aboutSection) {
const statsObserver = new IntersectionObserver((entries) => {
entries.forEach(entry => {
if (entry.isIntersecting) {

                animateStats();
                statsObserver.unobserve(entry.target);
            }
        });
    }, { threshold: 0.5 });

    statsObserver.observe(aboutSection);

}

// Particle effect for hero section (optional)

function createParticles() {
const hero = document.querySelector('.hero');
if (!hero) return;

    for (let i = 0; i < 50; i++) {

        const particle = document.createElement('div');
        particle.className = 'particle';
        particle.style.cssText = `
            position: absolute;
            width: 2px;
            height: 2px;

            background: rgba(255, 255, 255, 0.3);

            border-radius: 50%;
            pointer-events: none;

            left: ${Math.random() * 100}%;
            top: ${Math.random() * 100}%;
            animation: float ${3 + Math.random() * 4}s ease-in-out infinite;
        `;

        hero.appendChild(particle);
    }

}

// Initialize particles
createParticles();
]]
end

-- Main function to create project structure
function M.create_project(project_name, template_type, style_type, color_scheme_name)
local project_path = vim.fn.expand("~/projects/" .. project_name)

-- Create project directory

create_directory(project_path)

-- Get color scheme
local color_scheme = color_schemes[color_scheme_name] or color_schemes.oceanic

-- Generate files

local replacements = {
project_name = project_name,
template_type = template_type,

    style_type = style_type,
    color_scheme_name = color_scheme_name

}

-- Generate HTML

local html_content = generate_html_template(template_type, style_type, color_scheme, project_name)

html_content = replace_placeholders(html_content, replacements)

-- Generate CSS
local css_content = generate_css_template(style_type, color_scheme)

-- Generate JS

local js_content = generate_js_template()

-- Write files
vim.fn.writefile(vim.split(html_content, '\n'), project_path .. "/index.html")
vim.fn.writefile(vim.split(css_content, '\n'), project_path .. "/styles.css")

vim.fn.writefile(vim.split(js_content, '\n'), project_path .. "/script.js")

-- Create assets
