-- ~/.config/nvim/lua/zedocean/plugins/html-template-generator.lua
return {
"html-template-generator",
dir = vim.fn.stdpath("config") .. "/lua/zedocean/html-templates",

config = function()
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

    -- HTML Template Generator Functions
    local function create_file_with_content(filename, content)
      local file = io.open(filename, "w")
      if file then
        file:write(content)
        file:close()
        vim.cmd("edit " .. filename)
        vim.notify("Created: " .. filename, vim.log.levels.INFO)
      else
        vim.notify("Failed to create: " .. filename, vim.log.levels.ERROR)
      end
    end

    -- Modern Glassmorphism Template
    local function generate_glassmorphism_template()
      local filename = vim.fn.input("Enter filename (without extension): ") .. ".html"
      local content = [[<!DOCTYPE html>

<html lang="en">
<head>

    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Glassmorphism Design</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }


        body {
            font-family: 'Inter', sans-serif;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            overflow-x: hidden;

        }


        .container {

            max-width: 1200px;
            margin: 0 auto;
            padding: 2rem;
        }

        .glass-card {

            background: rgba(255, 255, 255, 0.1);
            backdrop-filter: blur(10px);
            border-radius: 20px;
            border: 1px solid rgba(255, 255, 255, 0.2);
            padding: 2rem;
            margin: 1rem 0;
            box-shadow: 0 8px 32px rgba(0, 0, 0, 0.1);
            transition: all 0.3s ease;
        }

        .glass-card:hover {
            transform: translateY(-5px);

            box-shadow: 0 15px 40px rgba(0, 0, 0, 0.2);
        }

        .hero {

            text-align: center;
            color: white;

            padding: 4rem 0;

        }

        .hero h1 {
            font-size: 3.5rem;

            margin-bottom: 1rem;
            font-weight: 700;
            text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.3);
        }


        .hero p {

            font-size: 1.2rem;
            opacity: 0.9;
            margin-bottom: 2rem;
        }


        .btn {
            display: inline-block;
            padding: 1rem 2rem;
            background: rgba(255, 255, 255, 0.2);
            color: white;
            text-decoration: none;

            border-radius: 50px;
            backdrop-filter: blur(10px);
            border: 1px solid rgba(255, 255, 255, 0.3);
            transition: all 0.3s ease;
            font-weight: 500;
        }

        .btn:hover {
            background: rgba(255, 255, 255, 0.3);
            transform: translateY(-2px);
        }

        .features {

            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
            gap: 2rem;

            margin: 4rem 0;
        }

        .feature {
            text-align: center;

            color: white;
        }

        .feature-icon {
            font-size: 3rem;

            margin-bottom: 1rem;
        }

        .feature h3 {
            margin-bottom: 1rem;
            font-size: 1.5rem;
        }


        .feature p {
            opacity: 0.8;

            line-height: 1.6;
        }

        @media (max-width: 768px) {
            .hero h1 {
                font-size: 2.5rem;
            }

            .container {

                padding: 1rem;
            }

            .glass-card {
                padding: 1.5rem;
            }
        }
    </style>

</head>
<body>
    <div class="container">
        <div class="hero">
            <h1>Your Brand Name</h1>
            <p>Elevate your business with stunning glassmorphism design</p>
            <a href="#" class="btn">Get Started</a>
        </div>
        
        <div class="features">
            <div class="glass-card feature">
                <div class="feature-icon">🚀</div>
                <h3>Modern Design</h3>
                <p>Cutting-edge glassmorphism effects that captivate your audience</p>
            </div>
            
            <div class="glass-card feature">
                <div class="feature-icon">⚡</div>
                <h3>Fast Performance</h3>
                <p>Optimized code for lightning-fast loading times</p>
            </div>
            
            <div class="glass-card feature">

                <div class="feature-icon">📱</div>
                <h3>Mobile First</h3>
                <p>Responsive design that works perfectly on all devices</p>
            </div>
        </div>
    </div>

</body>
</html>]]

      create_file_with_content(filename, content)
    end

    -- Cyberpunk/Neon Template
    local function generate_cyberpunk_template()
      local filename = vim.fn.input("Enter filename (without extension): ") .. ".html"
      local content = [[<!DOCTYPE html>

<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Cyberpunk Design</title>
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Orbitron:wght@400;700;900&display=swap');

        * {
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


        body::before {
            content: '';

            position: fixed;

            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background:
                radial-gradient(circle at 20% 20%, #ff00ff22 0%, transparent 50%),
                radial-gradient(circle at 80% 80%, #00ffff22 0%, transparent 50%),
                radial-gradient(circle at 40% 60%, #ff004422 0%, transparent 50%);
            pointer-events: none;
            z-index: -1;
        }


        .container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 2rem;
        }

        .cyber-card {
            background: rgba(0, 255, 65, 0.03);

            border: 2px solid #00ff41;
            border-radius: 0;
            padding: 2rem;
            margin: 2rem 0;
            position: relative;
            box-shadow:

                0 0 20px rgba(0, 255, 65, 0.3),
                inset 0 0 20px rgba(0, 255, 65, 0.05);
            transition: all 0.3s ease;
        }

        .cyber-card::before {
            content: '';

            position: absolute;
            top: -2px;
            left: -2px;

            right: -2px;
            bottom: -2px;
            background: linear-gradient(45deg, #00ff41, #ff00ff, #00ffff, #ff0044);
            z-index: -1;
            border-radius: 0;
            opacity: 0;
            transition: opacity 0.3s ease;
        }

        .cyber-card:hover::before {
            opacity: 1;
        }

        .cyber-card:hover {
            transform: translateY(-5px);

            box-shadow:
                0 10px 30px rgba(0, 255, 65, 0.4),
                inset 0 0 30px rgba(0, 255, 65, 0.1);
        }

        .hero {

            text-align: center;
            padding: 4rem 0;
            position: relative;
        }

        .hero h1 {
            font-size: 4rem;
            font-weight: 900;
            margin-bottom: 1rem;
            text-shadow:
                0 0 10px #00ff41,
                0 0 20px #00ff41,

                0 0 30px #00ff41;
            animation: glow 2s ease-in-out infinite alternate;
        }

        @keyframes glow {
            from { text-shadow: 0 0 10px #00ff41, 0 0 20px #00ff41, 0 0 30px #00ff41; }
            to { text-shadow: 0 0 15px #00ff41, 0 0 25px #00ff41, 0 0 35px #00ff41; }
        }


        .hero p {

            font-size: 1.3rem;
            margin-bottom: 2rem;
            opacity: 0.8;
        }


        .cyber-btn {
            display: inline-block;
            padding: 1rem 3rem;
            background: transparent;
            color: #00ff41;
            text-decoration: none;
            border: 2px solid #00ff41;
            font-family: 'Orbitron', monospace;
            font-weight: 700;
            text-transform: uppercase;
            position: relative;
            overflow: hidden;

            transition: all 0.3s ease;
        }

        .cyber-btn::before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg, transparent, rgba(0, 255, 65, 0.2), transparent);
            transition: left 0.5s ease;
        }

        .cyber-btn:hover::before {
            left: 100%;
        }

        .cyber-btn:hover {
            box-shadow: 0 0 20px #00ff41;
            text-shadow: 0 0 10px #00ff41;
        }

        .features {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(350px, 1fr));
            gap: 2rem;
            margin: 4rem 0;
        }

        .feature h3 {
            margin-bottom: 1rem;
            font-size: 1.5rem;
            color: #00ffff;
            text-shadow: 0 0 10px #00ffff;
        }

        .feature p {
            line-height: 1.6;
            opacity: 0.9;

        }


        .tech-lines {
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;

            height: 100%;
            pointer-events: none;
            z-index: -1;
        }

        .tech-line {
            position: absolute;
            background: linear-gradient(90deg, transparent, #00ff41, transparent);
            height: 1px;
            width: 100%;
            animation: scan 3s linear infinite;
        }

        @keyframes scan {
            0% { transform: translateX(-100%); }
            100% { transform: translateX(100%); }
        }

        @media (max-width: 768px) {
            .hero h1 {
                font-size: 2.5rem;
            }


            .container {
                padding: 1rem;
            }

            .cyber-card {
                padding: 1.5rem;
            }
        }
    </style>

</head>
<body>
    <div class="tech-lines">
        <div class="tech-line" style="top: 20%; animation-delay: 0s;"></div>
        <div class="tech-line" style="top: 60%; animation-delay: 1s;"></div>
        <div class="tech-line" style="top: 80%; animation-delay: 2s;"></div>
    </div>
    
    <div class="container">
        <div class="hero">
            <h1>CYBER SOLUTIONS</h1>
            <p>Next-generation digital experiences</p>
            <a href="#" class="cyber-btn">Initialize</a>
        </div>


        <div class="features">
            <div class="cyber-card">

                <h3>Advanced Systems</h3>
                <p>Cutting-edge technology solutions designed for the future</p>
            </div>


            <div class="cyber-card">
                <h3>Quantum Performance</h3>

                <p>Lightning-fast processing with quantum-level optimization</p>

            </div>

            <div class="cyber-card">
                <h3>Neural Interface</h3>
                <p>Intuitive user experience that adapts to your needs</p>
            </div>
        </div>
    </div>

</body>
</html>]]

      create_file_with_content(filename, content)
    end

    -- Minimalist Template
    local function generate_minimalist_template()
      local filename = vim.fn.input("Enter filename (without extension): ") .. ".html"

      local content = [[<!DOCTYPE html>

<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Minimalist Design</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        
        body {

            font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif;
            line-height: 1.6;

            color: #333;
            background: #fafafa;
        }

        .container {
            max-width: 900px;
            margin: 0 auto;
            padding: 4rem 2rem;
        }

        .header {
            text-align: center;
            margin-bottom: 6rem;
        }

        .header h1 {
            font-size: 3rem;
            font-weight: 300;
            margin-bottom: 1rem;
            letter-spacing: -0.02em;
        }

        .header p {
            font-size: 1.2rem;
            color: #666;
            font-weight: 300;
        }

        .content {
            display: grid;
            gap: 4rem;
            margin-bottom: 6rem;
        }

        .section {
            background: white;
            padding: 3rem;
            border-radius: 8px;

            box-shadow: 0 2px 20px rgba(0, 0, 0, 0.05);
            transition: transform 0.3s ease, box-shadow 0.3s ease;
        }


        .section:hover {

            transform: translateY(-5px);
            box-shadow: 0 10px 40px rgba(0, 0, 0, 0.1);
        }

        .section h2 {
            font-size: 1.8rem;
            font-weight: 400;

            margin-bottom: 1.5rem;
            color: #222;
        }


        .section p {
            color: #666;

            margin-bottom: 1.5rem;
        }

        .btn {

            display: inline-block;
            padding: 0.8rem 2rem;
            background: #333;
            color: white;
            text-decoration: none;

            border-radius: 4px;
            font-weight: 500;
            transition: background 0.3s ease;
        }

        .btn:hover {
            background: #555;

        }


        .grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 2rem;
            margin: 4rem 0;
        }

        .card {
            background: white;
            padding: 2rem;
            border-radius: 8px;

            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.05);
            text-align: center;

            transition: transform 0.3s ease;

        }


        .card:hover {
            transform: translateY(-3px);
        }

        .card h3 {
            margin-bottom: 1rem;
            color: #333;

            font-weight: 500;
        }

        .card p {
            color: #666;
            font-size: 0.9rem;
        }

        .footer {
            text-align: center;
            padding: 2rem 0;
            border-top: 1px solid #eee;
            color: #999;
        }

        @media (max-width: 768px) {
            .container {
                padding: 2rem 1rem;
            }

            .header h1 {

                font-size: 2.5rem;
            }

            .section {

                padding: 2rem;
            }
        }

    </style>

</head>
<body>

    <div class="container">
        <div class="header">
            <h1>Pure & Simple</h1>
            <p>Clean design that speaks for itself</p>
        </div>

        <div class="content">
            <div class="section">
                <h2>About</h2>
                <p>We believe in the power of simplicity. Our approach focuses on clean, functional design that delivers results without unnecessary complexity.</p>
                <a href="#" class="btn">Learn More</a>

            </div>

            <div class="section">
                <h2>Services</h2>
                <p>From concept to completion, we provide comprehensive solutions tailored to your needs. Quality and attention to detail are our priorities.</p>
                <a href="#" class="btn">View Services</a>

            </div>
        </div>

        <div class="grid">
            <div class="card">
                <h3>Design</h3>
                <p>Thoughtful, user-centered design that creates meaningful experiences</p>
            </div>

            <div class="card">

                <h3>Development</h3>
                <p>Clean, efficient code that performs beautifully across all platforms</p>
            </div>

            <div class="card">
                <h3>Strategy</h3>
                <p>Strategic thinking that aligns design with your business goals</p>

            </div>
        </div>

        <div class="footer">

            <p>&copy; 2024 Your Company. All rights reserved.</p>
        </div>
    </div>

</body>
</html>]]

      create_file_with_content(filename, content)
    end

    -- Key mappings for template generation
    map("n", "<leader>hg", generate_glassmorphism_template, { desc = "Generate Glassmorphism Template" })
    map("n", "<leader>hc", generate_cyberpunk_template, { desc = "Generate Cyberpunk Template" })
    map("n", "<leader>hm", generate_minimalist_template, { desc = "Generate Minimalist Template" })

    -- Create menu for template selection
    local function template_menu()
      local choices = {
        "1. Glassmorphism (Modern/Trendy)",
        "2. Cyberpunk (Futuristic/Bold)",
        "3. Minimalist (Clean/Professional)",
      }

      local choice = vim.fn.inputlist(vim.tbl_extend("force", {"Select template:"}, choices))

      if choice == 1 then
        generate_glassmorphism_template()
      elseif choice == 2 then
        generate_cyberpunk_template()
      elseif choice == 3 then
        generate_minimalist_template()
      end
    end

    map("n", "<leader>ht", template_menu, { desc = "HTML Template Menu" })


    vim.notify("HTML Template Generator loaded! Use <leader>ht for menu", vim.log.levels.INFO)

end,
}

✅ Phase 1 Complete: HTML Template Generator
What's Done:

Created a Neovim plugin with 3 stunning template styles
Glassmorphism (<leader>hg) - Modern, trendy with glass effects
Cyberpunk (<leader>hc) - Futuristic neon design that stands out
Minimalist (<leader>hm) - Clean, professional look
Template selection menu (<leader>ht)

Installation: Add this file to your plugins directory and it will automatically load with your existing lazy.nvim setup.
🎯 Next Phase Strategy
Since you want to chain this through multiple Claude conversations, here's the prompt for the next Claude.ai session:

PROMPT FOR NEXT CLAUDE.AI:
CONTEXT: I'm building a freelance HTML/CSS business system with Neovim shortcuts. The previous Claude completed Phase 1 of 10 phases.

COMPLETED PHASES:
✅ Phase 1: HTML Template Generator Plugin - Created 3 template styles (Glassmorphism, Cyberpunk, Minimalist) with Neovim shortcuts (<leader>hg, <leader>hc, <leader>hm, <leader>ht)

YOUR TASK: Complete Phase 2 of 10 - CSS Component Library Generator

PHASE 2 REQUIREMENTS:

- Create Neovim shortcuts for generating reusable CSS components
- Components needed: Navigation bars, Hero sections, Cards, Buttons, Forms, Footers
- Each component should have 3 style variations (matching the template styles)
- Should integrate with the existing template system
- Must use the same keymap pattern: local function map(mode, lhs, rhs, opts) with noremap=true, silent=true

REMAINING PHASES (3-10): 3. Project Structure Generator 4. Client Portfolio System  
5. Responsive Design Helper 6. CSS Animation Library 7. Color Palette Generator 8. Font Pairing System 9. Browser Preview Integration 10. Client Delivery System

Please create Phase 2 and then provide the prompt for Phase 3. Keep each phase manageable for one Claude session.

My existing setup: Neovim with lazy.nvim, using ~/dotfiles structure, file pattern: ~/.config/nvim/lua/zedocean/plugins/[plugin-name].lua

This approach ensures each Claude can focus on one substantial feature while maintaining continuity. The glassmorphism template will definitely make you stand out - it's currently one of the hottest design trends that 99% of competitors aren't using effectively!
