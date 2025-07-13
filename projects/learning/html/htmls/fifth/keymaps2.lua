-- Add this to your ~/.config/nvim/lua/zedocean/core/keymaps.lua

-- Project Template Generator
map("n", "<leader>pt", function()
	local templates = {
		"1. Modern Landing Page",
		"2. Portfolio Website",
		"3. Business Card Site",
		"4. Coming Soon Page",
		"5. Product Showcase",

		"6. Restaurant Menu",

		"7. Agency Homepage",

		"8. Blog Layout",
	}

	vim.ui.select(templates, {

		prompt = "Select template:",
	}, function(choice)
		if not choice then
			return
		end

		local template_num = choice:match("^(%d+)")
		local project_name = vim.fn.input("Project name: ")

		if project_name == "" then
			return
		end

		-- Create project structure
		vim.fn.system("mkdir -p " .. project_name .. "/{css,js,images}")

		-- Generate files based on template
		if template_num == "1" then
			-- Modern Landing Page
			local html_content = [[<!DOCTYPE html>
<html lang="en">
<head>

    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>]] .. project_name .. [[</title>
    <link rel="stylesheet" href="css/styles.css">
</head>

<body>
    <header class="header">
        <nav class="nav">
            <div class="nav-brand">Brand</div>
            <ul class="nav-links">
                <li><a href="#home">Home</a></li>
                <li><a href="#about">About</a></li>

                <li><a href="#services">Services</a></li>

                <li><a href="#contact">Contact</a></li>
            </ul>
        </nav>
    </header>
    

    <main>
        <section class="hero">
            <div class="hero-content">
                <h1 class="hero-title">Your Amazing Headline</h1>
                <p class="hero-subtitle">Compelling subtitle that explains your value proposition</p>
                <button class="cta-button">Get Started</button>
            </div>
        </section>
        

        <section class="features">
            <div class="container">
                <h2>Features</h2>
                <div class="features-grid">
                    <div class="feature-card">
                        <h3>Feature 1</h3>
                        <p>Description of feature 1</p>
                    </div>
                    <div class="feature-card">

                        <h3>Feature 2</h3>
                        <p>Description of feature 2</p>
                    </div>

                    <div class="feature-card">
                        <h3>Feature 3</h3>
                        <p>Description of feature 3</p>
                    </div>
                </div>

            </div>
        </section>
    </main>
    
    <footer class="footer">
        <p>&copy; 2024 Brand Name. All rights reserved.</p>
    </footer>
    
    <script src="js/main.js"></script>
</body>
</html>]]

			local css_content = [[/* Modern Landing Page Styles */
* {
    margin: 0;

    padding: 0;
    box-sizing: border-box;
}

:root {
    --primary: #3b82f6;
    --secondary: #8b5cf6;

    --accent: #06b6d4;
    --neutral: #6b7280;
    --base-100: #ffffff;
    --base-200: #f8fafc;
    --base-300: #e2e8f0;
}

body {

    font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif;
    line-height: 1.6;

    color: #333;
}

.header {
    background: rgba(255, 255, 255, 0.95);
    backdrop-filter: blur(10px);
    position: fixed;

    top: 0;
    width: 100%;
    z-index: 1000;
    padding: 1rem 0;
}

.nav {
    max-width: 1200px;
    margin: 0 auto;
    display: flex;
    justify-content: space-between;
    align-items: center;
    padding: 0 2rem;
}

.nav-brand {
    font-size: 1.5rem;

    font-weight: bold;
    color: var(--primary);
}

.nav-links {
    display: flex;
    list-style: none;
    gap: 2rem;
}


.nav-links a {
    text-decoration: none;
    color: var(--neutral);
    transition: color 0.3s ease;
}

.nav-links a:hover {

    color: var(--primary);

}


.hero {
    background: linear-gradient(135deg, var(--primary), var(--secondary));
    color: white;
    padding: 8rem 2rem 4rem;
    text-align: center;
    min-height: 100vh;
    display: flex;
    align-items: center;
    justify-content: center;
}


.hero-content {
    max-width: 600px;
}

.hero-title {

    font-size: 3rem;

    margin-bottom: 1rem;
    font-weight: 700;
}

.hero-subtitle {
    font-size: 1.25rem;
    margin-bottom: 2rem;

    opacity: 0.9;
}

.cta-button {
    background: rgba(255, 255, 255, 0.2);
    color: white;
    border: 2px solid white;
    padding: 1rem 2rem;
    font-size: 1.1rem;
    border-radius: 50px;
    cursor: pointer;
    transition: all 0.3s ease;
    backdrop-filter: blur(10px);
}


.cta-button:hover {
    background: white;
    color: var(--primary);
    transform: translateY(-2px);
}

.features {
    padding: 6rem 2rem;
    background: var(--base-200);
}

.container {
    max-width: 1200px;
    margin: 0 auto;
}

.features h2 {
    text-align: center;
    font-size: 2.5rem;
    margin-bottom: 3rem;

    color: var(--neutral);

}


.features-grid {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
    gap: 2rem;
}

.feature-card {
    background: white;
    padding: 2rem;
    border-radius: 10px;
    box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
    transition: transform 0.3s ease;
}

.feature-card:hover {

    transform: translateY(-5px);
}

.feature-card h3 {
    color: var(--primary);
    margin-bottom: 1rem;
}

.footer {
    background: var(--neutral);
    color: white;

    text-align: center;
    padding: 2rem;
}

/* Responsive Design */
@media (max-width: 768px) {
    .nav {

        flex-direction: column;
        gap: 1rem;
    }
    
    .nav-links {
        gap: 1rem;
    }
    
    .hero-title {

        font-size: 2rem;
    }
    
    .hero-subtitle {
        font-size: 1rem;

    }
}]]

			local js_content = [[// Modern Landing Page JavaScript
document.addEventListener('DOMContentLoaded', function() {
    // Smooth scrolling for navigation links
    const navLinks = document.querySelectorAll('.nav-links a');
    
    navLinks.forEach(link => {
        link.addEventListener('click', function(e) {
            e.preventDefault();
            const target = document.querySelector(this.getAttribute('href'));
            if (target) {
                target.scrollIntoView({
                    behavior: 'smooth'
                });
            }
        });
    });
    
    // Add scroll effect to header
    window.addEventListener('scroll', function() {
        const header = document.querySelector('.header');
        if (window.scrollY > 100) {

            header.style.background = 'rgba(255, 255, 255, 0.98)';
        } else {
            header.style.background = 'rgba(255, 255, 255, 0.95)';
        }

    });
    
    // Animate feature cards on scroll
    const observerOptions = {
        threshold: 0.1,
        rootMargin: '0px 0px -100px 0px'
    };
    

    const observer = new IntersectionObserver(function(entries) {
        entries.forEach(entry => {
            if (entry.isIntersecting) {
                entry.target.style.opacity = '1';
                entry.target.style.transform = 'translateY(0)';
            }
        });
    }, observerOptions);
    

    const featureCards = document.querySelectorAll('.feature-card');
    featureCards.forEach(card => {
        card.style.opacity = '0';
        card.style.transform = 'translateY(20px)';
        card.style.transition = 'opacity 0.6s ease, transform 0.6s ease';
        observer.observe(card);
    });
});]]

			-- Write files
			vim.fn.writefile(vim.split(html_content, "\n"), project_name .. "/index.html")

			vim.fn.writefile(vim.split(css_content, "\n"), project_name .. "/css/styles.css")
			vim.fn.writefile(vim.split(js_content, "\n"), project_name .. "/js/main.js")
		elseif template_num == "2" then
			-- Portfolio template (simplified for brevity)
			local html_content = [[<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Portfolio - ]] .. project_name .. [[</title>
    <link rel="stylesheet" href="css/styles.css">
</head>
<body>
    <header class="header">
        <nav class="nav">
            <div class="nav-brand">Portfolio</div>
            <ul class="nav-links">
                <li><a href="#home">Home</a></li>
                <li><a href="#about">About</a></li>

                <li><a href="#portfolio">Portfolio</a></li>
                <li><a href="#contact">Contact</a></li>

            </ul>
        </nav>
    </header>
    
    <main>
        <section class="hero">
            <div class="hero-content">
                <h1>Creative Designer</h1>
                <p>Crafting beautiful digital experiences</p>
                <button class="cta-button">View My Work</button>
            </div>
        </section>
        

        <section class="portfolio">
            <div class="container">
                <h2>My Work</h2>
                <div class="portfolio-grid">

                    <div class="portfolio-item">
                        <div class="portfolio-image"></div>
                        <h3>Project 1</h3>
                        <p>Description of project 1</p>
                    </div>
                    <div class="portfolio-item">
                        <div class="portfolio-image"></div>
                        <h3>Project 2</h3>

                        <p>Description of project 2</p>
                    </div>
                    <div class="portfolio-item">
                        <div class="portfolio-image"></div>
                        <h3>Project 3</h3>
                        <p>Description of project 3</p>
                    </div>
                </div>
            </div>
        </section>
    </main>
    
    <script src="js/main.js"></script>

</body>
</html>]]

			vim.fn.writefile(vim.split(html_content, "\n"), project_name .. "/index.html")
			vim.fn.writefile({ "/* Portfolio styles - add your custom CSS here */" }, project_name .. "/css/styles.css")
			vim.fn.writefile({ "// Portfolio JavaScript" }, project_name .. "/js/main.js")
		end

		vim.notify("Template '" .. choice .. "' created in " .. project_name .. "/")
		vim.cmd("edit " .. project_name .. "/index.html")
	end)
end, { desc = "Project Template" })

-- Quick CSS Framework Toggle
map("n", "<leader>cf", function()
	local frameworks = {
		"1. Tailwind CDN",
		"2. Bootstrap CDN",
		"3. Custom CSS Variables",
		"4. Minimal Reset",
	}

	vim.ui.select(frameworks, {
		prompt = "Select CSS framework:",
	}, function(choice)
		if not choice then
			return
		end

		local framework_num = choice:match("^(%d+)")
		local lines = {}

		if framework_num == "1" then
			lines = {
				'<script src="https://cdn.tailwindcss.com"></script>',
			}
		elseif framework_num == "2" then
			lines = {
				'<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">',
				'<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>',
			}
		elseif framework_num == "3" then
			lines = {
				":root {",
				"    --primary: #3b82f6;",
				"    --secondary: #8b5cf6;",
				"    --accent: #06b6d4;",
				"    --neutral: #6b7280;",
				"    --base-100: #ffffff;",
				"    --base-200: #f8fafc;",
				"    --base-300: #e2e8f0;",
				"    --success: #10b981;",
				"    --warning: #f59e0b;",
				"    --error: #ef4444;",
				"}",
			}
		elseif framework_num == "4" then
			lines = {
				"* {",

				"    margin: 0;",
				"    padding: 0;",
				"    box-sizing: border-box;",
				"}",
				"",
				"body {",

				"    font-family: system-ui, -apple-system, sans-serif;",
				"    line-height: 1.6;",
				"}",
			}
		end

		vim.api.nvim_put(lines, "l", true, true)
	end)
end, { desc = "CSS Framework" })
