-- lua/plugins/project-templates.lua

return {
	dir = "~/.config/nvim/templates",
	config = function()
		local M = {}

		-- Function to create project structure
		function M.create_project(project_name, template_type)
			local project_path = vim.fn.getcwd() .. "/" .. project_name

			-- Create project directory
			vim.fn.mkdir(project_path, "p")

			if template_type == "landing" then
				M.create_landing_page(project_path)
			elseif template_type == "portfolio" then
				M.create_portfolio(project_path)
			elseif template_type == "business" then
				M.create_business_site(project_path)
			end

			-- Open the project
			vim.cmd("cd " .. project_path)

			vim.cmd("edit index.html")
		end

		-- Landing page template

		function M.create_landing_page(path)
			local files = {
				["index.html"] = [[<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">

    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Landing Page</title>
    <link rel="stylesheet" href="css/style.css">
</head>

<body>
    <header class="header">
        <nav class="nav">
            <div class="logo">LOGO</div>
            <ul class="nav-links">
                <li><a href="#home">Home</a></li>
                <li><a href="#about">About</a></li>
                <li><a href="#services">Services</a></li>
                <li><a href="#contact">Contact</a></li>
            </ul>
        </nav>
    </header>
    
    <main>
        <section class="hero" id="home">
            <div class="hero-content">
                <h1>Welcome to Our Service</h1>
                <p>Your success is our priority</p>
                <button class="cta-button">Get Started</button>

            </div>
        </section>
        
        <section class="about" id="about">
            <div class="container">
                <h2>About Us</h2>

                <p>About content here</p>
            </div>

        </section>
        
        <section class="services" id="services">
            <div class="container">
                <h2>Our Services</h2>
                <div class="service-grid">
                    <div class="service-card">
                        <h3>Service 1</h3>
                        <p>Service description</p>
                    </div>
                    <div class="service-card">
                        <h3>Service 2</h3>
                        <p>Service description</p>
                    </div>
                    <div class="service-card">
                        <h3>Service 3</h3>
                        <p>Service description</p>
                    </div>
                </div>
            </div>
        </section>
        

        <section class="contact" id="contact">
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
        <p>&copy; 2024 Company Name. All rights reserved.</p>
    </footer>
    
    <script src="js/script.js"></script>
</body>
</html>]],

				["css/style.css"] = [[/* CSS Reset */
* {
    margin: 0;
    padding: 0;
    box-sizing: border-box;

}


body {
    font-family: 'Arial', sans-serif;
    line-height: 1.6;
    color: #333;
}

.container {
    max-width: 1200px;
    margin: 0 auto;
    padding: 0 20px;
}


/* Header */
.header {
    background: #fff;
    box-shadow: 0 2px 5px rgba(0,0,0,0.1);
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

.logo {
    font-size: 1.5rem;
    font-weight: bold;
    color: #007bff;
}


.nav-links {
    display: flex;
    list-style: none;
    gap: 2rem;
}

.nav-links a {
    text-decoration: none;
    color: #333;
    transition: color 0.3s ease;
}

.nav-links a:hover {
    color: #007bff;
}

/* Hero Section */
.hero {
    background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
    color: white;
    padding: 120px 0 80px;
    text-align: center;
}

.hero-content h1 {
    font-size: 3rem;
    margin-bottom: 1rem;
}

.hero-content p {
    font-size: 1.2rem;
    margin-bottom: 2rem;
}

.cta-button {
    background: #ff6b6b;
    color: white;
    padding: 15px 30px;
    border: none;
    border-radius: 5px;
    font-size: 1.1rem;
    cursor: pointer;
    transition: background 0.3s ease;
}

.cta-button:hover {
    background: #ff5252;
}

/* About Section */
.about {
    padding: 80px 0;
    background: #f8f9fa;
}

.about h2 {
    text-align: center;
    margin-bottom: 2rem;

    font-size: 2.5rem;
}

/* Services Section */
.services {
    padding: 80px 0;
}

.services h2 {

    text-align: center;
    margin-bottom: 3rem;
    font-size: 2.5rem;
}

.service-grid {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
    gap: 2rem;
}

.service-card {
    background: white;
    padding: 2rem;
    border-radius: 10px;
    box-shadow: 0 5px 15px rgba(0,0,0,0.1);
    text-align: center;
    transition: transform 0.3s ease;
}

.service-card:hover {
    transform: translateY(-5px);

}


/* Contact Section */
.contact {
    padding: 80px 0;
    background: #f8f9fa;
}

.contact h2 {

    text-align: center;
    margin-bottom: 3rem;
    font-size: 2.5rem;
}

.contact-form {
    max-width: 600px;
    margin: 0 auto;
}

.contact-form input,
.contact-form textarea {
    width: 100%;
    padding: 15px;
    margin-bottom: 1rem;
    border: 1px solid #ddd;
    border-radius: 5px;
}

.contact-form button {
    background: #007bff;

    color: white;
    padding: 15px 30px;

    border: none;
    border-radius: 5px;

    cursor: pointer;

    width: 100%;
}

/* Footer */
.footer {
    background: #333;
    color: white;
    text-align: center;
    padding: 2rem 0;
}

/* Responsive Design */
@media (max-width: 768px) {
    .nav {
        flex-direction: column;

        gap: 1rem;
    }
    
    .nav-links {
        flex-direction: column;
        gap: 1rem;
    }
    
    .hero-content h1 {
        font-size: 2rem;
    }
    
    .service-grid {

        grid-template-columns: 1fr;
    }

}]],

				["js/script.js"] = [[// Smooth scrolling for navigation links
document.querySelectorAll('a[href^="#"]').forEach(anchor => {
    anchor.addEventListener('click', function (e) {
        e.preventDefault();
        document.querySelector(this.getAttribute('href')).scrollIntoView({
            behavior: 'smooth'

        });

    });
});

// Form submission
document.querySelector('.contact-form').addEventListener('submit', function(e) {
    e.preventDefault();
    // Add your form submission logic here
    alert('Thank you for your message! We will get back to you soon.');
    this.reset();
});

// Header scroll effect
window.addEventListener('scroll', function() {
    const header = document.querySelector('.header');
    if (window.scrollY > 100) {

        header.style.background = 'rgba(255, 255, 255, 0.95)';
        header.style.backdropFilter = 'blur(10px)';
    } else {
        header.style.background = '#fff';
        header.style.backdropFilter = 'none';
    }
});]],

				["README.md"] = [[# Landing Page Project

## Structure
- `index.html` - Main HTML file
- `css/style.css` - Stylesheet
- `js/script.js` - JavaScript functionality

## Features
- Responsive design
- Smooth scrolling navigation
- Contact form
- Modern gradient hero section
- Service cards with hover effects


## Customization
1. Update the logo and company name
2. Modify colors in CSS variables
3. Add your own content and images
4. Customize the contact form action
]],
			}

			-- Create directories
			vim.fn.mkdir(path .. "/css", "p")
			vim.fn.mkdir(path .. "/js", "p")

			-- Write files
			for filename, content in pairs(files) do
				local file = io.open(path .. "/" .. filename, "w")
				if file then
					file:write(content)
					file:close()
				end
			end
		end

		-- Commands
		vim.api.nvim_create_user_command("CreateProject", function(opts)
			local args = vim.split(opts.args, " ")
			local project_name = args[1] or "new-project"
			local template_type = args[2] or "landing"

			M.create_project(project_name, template_type)
		end, {
			nargs = "*",
			desc = "Create new project with template",
		})

		-- Keybindings
		vim.keymap.set("n", "<leader>np", ":CreateProject ", { desc = "New Project" })

		return M
	end,
}
