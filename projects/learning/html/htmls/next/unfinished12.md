-- ~/.config/nvim/lua/zedocean/plugins/html-templates.lua

return {
name = "html-templates",
config = function()
-- Local function for keymap helper (using your preferred style)

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

    -- Template configurations with different styles
    local templates = {
      -- Modern Glassmorphism Landing Page
      glassmorphism = {
        name = "Glassmorphism Landing Page",
        html = [[<!DOCTYPE html>

<html lang="en">
<head>
    <meta charset="UTF-8">

    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>{{TITLE}}</title>
    <link rel="stylesheet" href="style.css">

</head>

<body>
    <div class="container">
        <nav class="glass-nav">
            <div class="logo">{{BRAND}}</div>
            <ul class="nav-links">
                <li><a href="#home">Home</a></li>
                <li><a href="#about">About</a></li>
                <li><a href="#services">Services</a></li>
                <li><a href="#contact">Contact</a></li>
            </ul>
        </nav>
        
        <section class="hero">
            <div class="glass-card hero-content">
                <h1>{{HEADING}}</h1>
                <p>{{SUBHEADING}}</p>
                <button class="cta-button">{{CTA_TEXT}}</button>
            </div>

        </section>

        <section class="features">
            <div class="glass-card">
                <h2>Our Features</h2>
                <div class="feature-grid">
                    <div class="feature-item">
                        <h3>Feature 1</h3>
                        <p>Description here</p>
                    </div>
                    <div class="feature-item">
                        <h3>Feature 2</h3>
                        <p>Description here</p>

                    </div>
                    <div class="feature-item">
                        <h3>Feature 3</h3>
                        <p>Description here</p>
                    </div>
                </div>
            </div>
        </section>
    </div>

</body>

</html>]],
        css = [[* {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
}

body {
font-family: 'Inter', sans-serif;
background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
min-height: 100vh;
color: white;
}

.container {
max-width: 1200px;
margin: 0 auto;
padding: 0 20px;
}

.glass-nav {
background: rgba(255, 255, 255, 0.1);
backdrop-filter: blur(10px);

    border: 1px solid rgba(255, 255, 255, 0.2);
    border-radius: 20px;
    padding: 1rem 2rem;
    margin: 2rem 0;
    display: flex;
    justify-content: space-between;

    align-items: center;

}

.logo {
font-size: 1.5rem;
font-weight: bold;
}

.nav-links {
display: flex;
list-style: none;
gap: 2rem;
}

.nav-links a {
color: white;
text-decoration: none;
transition: all 0.3s ease;
}

.nav-links a:hover {
color: #ffd700;
transform: translateY(-2px);
}

.glass-card {
background: rgba(255, 255, 255, 0.1);
backdrop-filter: blur(15px);
border: 1px solid rgba(255, 255, 255, 0.2);
border-radius: 25px;
padding: 3rem;

    margin: 2rem 0;
    box-shadow: 0 8px 32px rgba(0, 0, 0, 0.1);
    transition: all 0.3s ease;

}

.glass-card:hover {
transform: translateY(-10px);
box-shadow: 0 15px 50px rgba(0, 0, 0, 0.2);
}

.hero {
text-align: center;

    padding: 4rem 0;

}

.hero h1 {
font-size: 3.5rem;

    margin-bottom: 1rem;
    background: linear-gradient(45deg, #ffd700, #ff6b6b);
    -webkit-background-clip: text;
    -webkit-text-fill-color: transparent;

}

.hero p {
font-size: 1.2rem;
margin-bottom: 2rem;
opacity: 0.9;

}

.cta-button {
background: linear-gradient(45deg, #ff6b6b, #ffd700);
border: none;
padding: 1rem 2rem;
border-radius: 50px;
color: white;
font-size: 1.1rem;
font-weight: bold;
cursor: pointer;
transition: all 0.3s ease;
text-transform: uppercase;
letter-spacing: 1px;
}

.cta-button:hover {
transform: translateY(-3px);
box-shadow: 0 10px 30px rgba(255, 107, 107, 0.4);
}

.features h2 {
text-align: center;
margin-bottom: 3rem;
font-size: 2.5rem;
}

.feature-grid {
display: grid;
grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
gap: 2rem;
}

.feature-item {
background: rgba(255, 255, 255, 0.05);
padding: 2rem;

    border-radius: 20px;
    text-align: center;
    transition: all 0.3s ease;

}

.feature-item:hover {
background: rgba(255, 255, 255, 0.15);
transform: translateY(-5px);
}

.feature-item h3 {

    margin-bottom: 1rem;
    color: #ffd700;

}

@media (max-width: 768px) {
.glass-nav {
flex-direction: column;
gap: 1rem;
}

    .nav-links {

        gap: 1rem;
    }

    .hero h1 {

        font-size: 2.5rem;
    }

    .glass-card {
        padding: 2rem;
    }

}]]
},

      -- Minimalist Professional
      minimalist = {
        name = "Minimalist Professional",
        html = [[<!DOCTYPE html>

<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>{{TITLE}}</title>
    <link rel="stylesheet" href="style.css">
</head>
<body>
    <header>
        <nav class="nav-container">

            <div class="logo">{{BRAND}}</div>
            <ul class="nav-menu">
                <li><a href="#home">Home</a></li>
                <li><a href="#about">About</a></li>
                <li><a href="#services">Services</a></li>
                <li><a href="#contact">Contact</a></li>
            </ul>
        </nav>
    </header>

    <main>
        <section class="hero-section">
            <div class="hero-content">
                <h1>{{HEADING}}</h1>

                <p>{{SUBHEADING}}</p>
                <button class="primary-button">{{CTA_TEXT}}</button>
            </div>
        </section>

        <section class="services-section">
            <div class="container">
                <h2>What We Offer</h2>
                <div class="services-grid">
                    <div class="service-card">
                        <h3>Service One</h3>
                        <p>Clean, professional description of your service offering.</p>
                    </div>
                    <div class="service-card">
                        <h3>Service Two</h3>
                        <p>Clean, professional description of your service offering.</p>
                    </div>
                    <div class="service-card">

                        <h3>Service Three</h3>
                        <p>Clean, professional description of your service offering.</p>
                    </div>
                </div>
            </div>

        </section>
    </main>

    <footer>
        <div class="container">
            <p>&copy; 2024 {{BRAND}}. All rights reserved.</p>
        </div>

    </footer>

</body>
</html>]],
        css = [[* {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
}

body {
font-family: 'Helvetica Neue', Arial, sans-serif;
line-height: 1.6;

    color: #333;
    background: #ffffff;

}

.container {
max-width: 1200px;
margin: 0 auto;
padding: 0 20px;
}

/_ Header _/
header {
background: #ffffff;
box-shadow: 0 2px 10px rgba(0,0,0,0.1);
position: fixed;
width: 100%;
top: 0;
z-index: 1000;
}

.nav-container {
max-width: 1200px;
margin: 0 auto;
padding: 1rem 20px;
display: flex;
justify-content: space-between;
align-items: center;
}

.logo {
font-size: 1.8rem;
font-weight: 700;

    color: #2c3e50;

}

.nav-menu {
display: flex;
list-style: none;
gap: 2rem;

}

.nav-menu a {
color: #333;
text-decoration: none;
font-weight: 500;
transition: color 0.3s ease;
}

.nav-menu a:hover {
color: #3498db;
}

/_ Hero Section _/
.hero-section {
padding: 120px 0 80px;
text-align: center;
background: linear-gradient(135deg, #f8f9fa 0%, #e9ecef 100%);
}

.hero-content {
max-width: 800px;
margin: 0 auto;
padding: 0 20px;
}

.hero-content h1 {
font-size: 3.5rem;
font-weight: 700;
margin-bottom: 1.5rem;
color: #2c3e50;
line-height: 1.2;
}

.hero-content p {
font-size: 1.2rem;
margin-bottom: 2rem;

    color: #6c757d;

}

.primary-button {
background: #3498db;
color: white;
padding: 12px 30px;
border: none;
border-radius: 5px;
font-size: 1.1rem;
font-weight: 600;
cursor: pointer;
transition: all 0.3s ease;
text-transform: uppercase;
letter-spacing: 0.5px;
}

.primary-button:hover {
background: #2980b9;

    transform: translateY(-2px);

}

/_ Services Section _/
.services-section {
padding: 80px 0;
background: #ffffff;

}

.services-section h2 {
text-align: center;
font-size: 2.5rem;
margin-bottom: 3rem;
color: #2c3e50;
}

.services-grid {
display: grid;
grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
gap: 2rem;
}

.service-card {
padding: 2rem;

    text-align: center;
    border: 1px solid #e9ecef;
    border-radius: 10px;
    transition: all 0.3s ease;

}

.service-card:hover {
transform: translateY(-5px);
box-shadow: 0 10px 30px rgba(0,0,0,0.1);
}

.service-card h3 {
margin-bottom: 1rem;
color: #2c3e50;
font-size: 1.3rem;
}

.service-card p {

    color: #6c757d;

    line-height: 1.6;

}

/_ Footer _/
footer {
background: #2c3e50;
color: white;
padding: 2rem 0;
text-align: center;
}

/_ Responsive Design _/
@media (max-width: 768px) {
.nav-container {
flex-direction: column;

        gap: 1rem;
    }

    .nav-menu {
        gap: 1rem;
    }


    .hero-content h1 {
        font-size: 2.5rem;
    }


    .services-grid {
        grid-template-columns: 1fr;
    }

}]]
},

      -- Dark Cyberpunk
      cyberpunk = {
        name = "Dark Cyberpunk",
        html = [[<!DOCTYPE html>

<html lang="en">
<head>
    <meta charset="UTF-8">

    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>{{TITLE}}</title>
    <link rel="stylesheet" href="style.css">

</head>

<body>
    <div class="matrix-bg"></div>
    <div class="scan-line"></div>
    
    <header class="cyber-header">
        <nav class="cyber-nav">
            <div class="logo-container">
                <div class="logo">{{BRAND}}</div>
                <div class="logo-glitch">{{BRAND}}</div>

            </div>
            <ul class="nav-links">

                <li><a href="#home" class="nav-link">HOME</a></li>
                <li><a href="#about" class="nav-link">ABOUT</a></li>
                <li><a href="#services" class="nav-link">SERVICES</a></li>
                <li><a href="#contact" class="nav-link">CONTACT</a></li>

            </ul>
        </nav>
    </header>

    <main>
        <section class="hero-cyber">
            <div class="hero-container">
                <div class="glitch-text">
                    <h1>{{HEADING}}</h1>
                    <h1 class="glitch-layer">{{HEADING}}</h1>
                    <h1 class="glitch-layer">{{HEADING}}</h1>
                </div>
                <p class="cyber-subtitle">{{SUBHEADING}}</p>
                <button class="cyber-button">
                    <span>{{CTA_TEXT}}</span>
                    <div class="button-glitch"></div>
                </button>
            </div>
        </section>

        <section class="data-section">
            <div class="container">
                <h2 class="section-title">SYSTEM.FEATURES</h2>
                <div class="data-grid">

                    <div class="data-card">
                        <div class="card-header">
                            <span class="card-id">[001]</span>
                            <span class="card-status">ACTIVE</span>
                        </div>
                        <h3>NEURAL INTERFACE</h3>
                        <p>Advanced cybernetic integration for seamless human-machine interaction.</p>
                    </div>
                    <div class="data-card">
                        <div class="card-header">
                            <span class="card-id">[002]</span>
                            <span class="card-status">ACTIVE</span>
                        </div>

                        <h3>QUANTUM PROCESSING</h3>
                        <p>Next-generation computational power exceeding traditional limitations.</p>

                    </div>
                    <div class="data-card">
                        <div class="card-header">
                            <span class="card-id">[003]</span>

                            <span class="card-status">ACTIVE</span>
                        </div>
                        <h3>DIGITAL SECURITY</h3>
                        <p>Military-grade encryption protecting your data in the digital realm.</p>
                    </div>
                </div>
            </div>

        </section>
    </main>

</body>
</html>]],
        css = [[@import url('https://fonts.googleapis.com/css2?family=Orbitron:wght@400;700;900&display=swap');

- {

      margin: 0;
      padding: 0;
      box-sizing: border-box;

  }

body {
font-family: 'Orbitron', monospace;
background: #0a0a0a;
color: #00ff41;
overflow-x: hidden;
position: relative;
}

/_ Matrix Background Effect _/
.matrix-bg {
position: fixed;
top: 0;
left: 0;
width: 100%;
height: 100%;
background:
radial-gradient(circle at 20% 50%, rgba(0, 255, 65, 0.1) 0%, transparent 50%),
radial-gradient(circle at 80% 20%, rgba(255, 0, 65, 0.1) 0%, transparent 50%),
radial-gradient(circle at 40% 80%, rgba(0, 194, 255, 0.1) 0%, transparent 50%);
z-index: -2;
}

/_ Scan Line Effect _/
.scan-line {
position: fixed;
top: 0;
left: 0;
width: 100%;
height: 2px;
background: linear-gradient(90deg, transparent, #00ff41, transparent);

    animation: scan 2s linear infinite;
    z-index: -1;

}

@keyframes scan {
0% { top: 0; }
100% { top: 100vh; }
}

.container {
max-width: 1200px;
margin: 0 auto;
padding: 0 20px;
}

/_ Header _/

.cyber-header {
background: rgba(0, 0, 0, 0.9);
backdrop-filter: blur(10px);
border-bottom: 1px solid #00ff41;
padding: 1rem 0;
position: fixed;
width: 100%;
top: 0;

    z-index: 1000;

}

.cyber-nav {
max-width: 1200px;

    margin: 0 auto;
    padding: 0 20px;
    display: flex;
    justify-content: space-between;
    align-items: center;

}

.logo-container {
position: relative;

}

.logo {
font-size: 1.8rem;
font-weight: 900;
color: #00ff41;
text-shadow: 0 0 10px #00ff41;
}

.logo-glitch {
position: absolute;
top: 0;
left: 0;
font-size: 1.8rem;
font-weight: 900;
color: #ff0040;
animation: glitch 2s infinite;
opacity: 0.8;
}

@keyframes glitch {
0% { transform: translate(0); }
20% { transform: translate(-1px, 1px); }

    40% { transform: translate(-1px, -1px); }
    60% { transform: translate(1px, 1px); }
    80% { transform: translate(1px, -1px); }
    100% { transform: translate(0); }

}

.nav-links {
display: flex;
list-style: none;
gap: 2rem;
}

.nav-link {
color: #00ff41;
text-decoration: none;
font-weight: 700;
font-size: 0.9rem;
letter-spacing: 2px;
transition: all 0.3s ease;
position: relative;
padding: 0.5rem 1rem;
border: 1px solid transparent;
}

.nav-link:hover {

    color: #ffffff;

    border-color: #00ff41;
    box-shadow: 0 0 20px rgba(0, 255, 65, 0.5);
    text-shadow: 0 0 10px #00ff41;

}

/_ Hero Section _/
.hero-cyber {
padding: 150px 0 100px;
text-align: center;
background:
linear-gradient(135deg, rgba(0, 255, 65, 0.1) 0%, transparent 50%),
linear-gradient(225deg, rgba(255, 0, 65, 0.1) 0%, transparent 50%);
}

.hero-container {

    max-width: 800px;
    margin: 0 auto;

    padding: 0 20px;

}

.glitch-text {
position: relative;
margin-bottom: 2rem;
}

.glitch-text h1 {
font-size: 4rem;
font-weight: 900;
color: #00ff41;
text-shadow: 0 0 20px #00ff41;
letter-spacing: 3px;
animation: textGlow 2s ease-in-out infinite alternate;
}

.glitch-layer {
position: absolute;
top: 0;
left: 0;
width: 100%;
height: 100%;
color: #ff0040;
animation: glitchText 3s infinite;
}

.glitch-layer:nth-child(3) {
color: #0040ff;
animation-delay: 0.5s;
}

@keyframes textGlow {

    from { text-shadow: 0 0 20px #00ff41; }
    to { text-shadow: 0 0 30px #00ff41, 0 0 40px #00ff41; }

}

@keyframes glitchText {
0% { transform: translate(0); opacity: 1; }
10% { transform: translate(-1px, 1px); opacity: 0.8; }
20% { transform: translate(-2px, 0); opacity: 0.6; }
30% { transform: translate(2px, -1px); opacity: 0.8; }
40% { transform: translate(1px, 2px); opacity: 0.4; }

    50% { transform: translate(-1px, -2px); opacity: 0.6; }
    60% { transform: translate(2px, 1px); opacity: 0.8; }

    70% { transform: translate(-2px, -1px); opacity: 0.4; }
    80% { transform: translate(1px, -1px); opacity: 0.8; }
    90% { transform: translate(-1px, 0); opacity: 0.6; }
    100% { transform: translate(0); opacity: 1; }

}

.cyber-subtitle {
font-size: 1.2rem;
margin-bottom: 3rem;
color: #888;
letter-spacing: 1px;
text-transform: uppercase;
}

.cyber-button {
background: transparent;
color: #00ff41;
padding: 15px 40px;
border: 2px solid #00ff41;
font-family: 'Orbitron', monospace;
font-size: 1.1rem;
font-weight: 700;
letter-spacing: 2px;

    cursor: pointer;

    position: relative;
    transition: all 0.3s ease;
    text-transform: uppercase;
    overflow: hidden;

}

.cyber-button:hover {
background: #00ff41;
color: #000;
box-shadow: 0 0 30px #00ff41;
transform: translateY(-2px);
}

.cyber-button span {
position: relative;
z-index: 1;
}

.button-glitch {
position: absolute;
top: 0;
left: -100%;
width: 100%;
height: 100%;
background: linear-gradient(90deg, transparent, rgba(255, 255, 255, 0.2), transparent);

    transition: all 0.5s ease;

}

.cyber-button:hover .button-glitch {
left: 100%;
}

/_ Data Section _/

.data-section {
padding: 100px 0;
background: rgba(0, 0, 0, 0.5);
}

.section-title {
text-align: center;
font-size: 2.5rem;
margin-bottom: 3rem;
color: #00ff41;
text-shadow: 0 0 20px #00ff41;
letter-spacing: 3px;
}

.data-grid {
display: grid;
grid-template-columns: repeat(auto-fit, minmax(350px, 1fr));
gap: 2rem;
}

.data-card {
background: rgba(0, 255, 65, 0.05);
border: 1px solid #00ff41;
border-radius: 10px;
padding: 2rem;
transition: all 0.3s ease;
position: relative;
overflow: hidden;
}

.data-card::before {
content: '';
position: absolute;
top: 0;
left: -100%;
width: 100%;
height: 100%;
background: linear-gradient(90deg, transparent, rgba(0, 255, 65, 0.1), transparent);
transition: all 0.5s ease;
}

.data-card:hover::before {

    left: 100%;

}

.data-card:hover {
transform: translateY(-5px);
box-shadow: 0 10px 30px rgba(0, 255, 65, 0.3);
border-color: #00ff41;
}

.card-header {
display: flex;
justify-content: space-between;

    margin-bottom: 1rem;
    font-size: 0.8rem;

}

.card-id {
color: #00ff41;
font-weight: 700;
}

.card-status {
color: #ff0040;
font-weight: 700;

}

.data-card h3 {
margin-bottom: 1rem;
color: #ffffff;
font-size: 1.2rem;
letter-spacing: 1px;
}

.data-card p {
color: #aaa;
line-height: 1.6;
font-size: 0.9rem;
}

/_ Responsive Design _/
@media (max-width: 768px) {

    .cyber-nav {
        flex-direction: column;
        gap: 1rem;
    }

    .nav-links {
        gap: 1rem;
    }


    .glitch-text h1 {

        font-size: 2.5rem;
    }

    .data-grid {
        grid-template-columns: 1fr;
    }

}]]
}
}

    -- Function to create template files
    local function create_template(template_type)
      local template = templates[template_type]
      if not template then
        vim.notify("Template not found: " .. template_type, vim.log.levels.ERROR)
        return
      end

      local current_dir = vim.fn.getcwd()
      local html_file = current_dir .. "/index.html"
      local css_file = current_dir .. "/style.css"

      -- Get user input for placeholders
      local replacements = {}

      replacements.TITLE = vim.fn.input("Enter page title: ") or "My Website"
      replacements.BRAND = vim.fn.input("Enter brand name: ") or "Brand"

      replacements.HEADING = vim.fn.input("Enter main heading: ") or "Welcome to Our Website"
      replacements.SUBHEADING = vim.fn.input("Enter subheading: ") or "We create amazing experiences"
      replacements.CTA_TEXT = vim.fn.input("Enter CTA button text: ") or "Get Started"

      -- Replace placeholders in HTML
      local html_content = template.html
      for key, value in pairs(replacements) do
        html_content = html_content:gsub("{{" .. key .. "}}", value)
      end

      -- Write files
      local html_handle = io.open(html_file, "w")
      if html_handle then
        html_handle:write(html_content)
        html_handle:close()
        vim.notify("Created: " .. html_file, vim.log.levels.INFO)
      end


      local css_handle = io.open(css_file, "w")
      if css_handle then
        css_handle:write(template.css)
        css_handle:close()
        vim.notify("Created: " .. css_file, vim.log.levels.INFO)
      end

      -- Open the HTML file
      vim.cmd("edit " .. html_file)

    end

    -- Function to show template picker

    local function show_template_picker()

      local template_options = {}
      for key, template in pairs(templates) do
        table.insert(template_options, key .. " - " .. template.name)
      end

      vim.ui.select(template_options, {
        prompt = "Select template style:",
        format_item = function(item)
          return item
        end,
      }, function(choice)
        if choice then
          local template_key = choice:match("^([^%s]+)")
