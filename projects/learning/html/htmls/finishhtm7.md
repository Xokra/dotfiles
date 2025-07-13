-- ~/.config/nvim/lua/zedocean/plugins/html-templates.lua

return {
"L3MON4D3/LuaSnip",
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
local sn = ls.snippet_node

    -- Helper function for mapping
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

    -- HTML5 Boilerplate Templates
    local html_snippets = {
      -- Modern HTML5 Boilerplate
      s("html5", {
        t({
          "<!DOCTYPE html>",

          "<html lang=\"en\">",

          "<head>",
          "    <meta charset=\"UTF-8\">",
          "    <meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\">",
          "    <title>"
        }),
        i(1, "Page Title"),
        t({
          "</title>",
          "    <link rel=\"stylesheet\" href=\""
        }),
        i(2, "styles.css"),
        t({
          "\">",
          "</head>",

          "<body>",
          "    <main>",

          "        "
        }),
        i(3, "<!-- Content here -->"),
        t({
          "",
          "    </main>",
          "    <script src=\""

        }),
        i(4, "script.js"),
        t({
          "\"></script>",
          "</body>",
          "</html>"

        })
      }),


      -- Glassmorphism Landing Page
      s("glass-landing", {
        t({
          "<!DOCTYPE html>",
          "<html lang=\"en\">",
          "<head>",
          "    <meta charset=\"UTF-8\">",
          "    <meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\">",
          "    <title>"

        }),

        i(1, "Glassmorphism Landing"),
        t({
          "</title>",
          "    <style>",
          "        * { margin: 0; padding: 0; box-sizing: border-box; }",
          "        body {",
          "            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);",
          "            min-height: 100vh;",
          "            font-family: 'Arial', sans-serif;",
          "            overflow-x: hidden;",
          "        }",
          "        .glass-container {",
          "            background: rgba(255, 255, 255, 0.1);",
          "            backdrop-filter: blur(10px);",
          "            border-radius: 20px;",
          "            border: 1px solid rgba(255, 255, 255, 0.2);",
          "            padding: 2rem;",
          "            margin: 2rem;",
          "            box-shadow: 0 8px 32px rgba(0, 0, 0, 0.1);",
          "        }",
          "        .hero {",
          "            text-align: center;",
          "            color: white;",
          "            padding: 4rem 2rem;",
          "        }",
          "        .hero h1 {",
          "            font-size: 3.5rem;",
          "            margin-bottom: 1rem;",

          "            text-shadow: 2px 2px 4px rgba(0,0,0,0.3);",
          "        }",
          "        .hero p {",
          "            font-size: 1.2rem;",
          "            margin-bottom: 2rem;",
          "            opacity: 0.9;",
          "        }",
          "        .cta-button {",
          "            background: rgba(255, 255, 255, 0.2);",
          "            color: white;",

          "            padding: 1rem 2rem;",
          "            border: none;",
          "            border-radius: 50px;",
          "            font-size: 1.1rem;",
          "            cursor: pointer;",
          "            transition: all 0.3s ease;",
          "            backdrop-filter: blur(5px);",
          "        }",
          "        .cta-button:hover {",
          "            background: rgba(255, 255, 255, 0.3);",
          "            transform: translateY(-2px);",
          "        }",
          "    </style>",
          "</head>",
          "<body>",
          "    <div class=\"hero\">",
          "        <div class=\"glass-container\">",
          "            <h1>"
        }),
        i(2, "Your Amazing Product"),
        t({
          "</h1>",
          "            <p>"
        }),
        i(3, "Transform your business with our innovative solution"),
        t({
          "</p>",
          "            <button class=\"cta-button\">"
        }),
        i(4, "Get Started"),
        t({
          "</button>",
          "        </div>",
          "    </div>",
          "</body>",
          "</html>"

        })
      }),


      -- Modern Card Layout
      s("card-layout", {
        t({

          "<div class=\"card\">",
          "    <div class=\"card-header\">",
          "        <h3>"
        }),
        i(1, "Card Title"),
        t({
          "</h3>",
          "    </div>",
          "    <div class=\"card-body\">",
          "        <p>"
        }),
        i(2, "Card content goes here"),
        t({
          "</p>",
          "    </div>",
          "    <div class=\"card-footer\">",
          "        <button class=\"btn btn-primary\">"
        }),
        i(3, "Action"),
        t({
          "</button>",
          "    </div>",
          "</div>"
        })
      }),

      -- Navigation Component
      s("navbar", {
        t({
          "<nav class=\"navbar\">",
          "    <div class=\"nav-container\">",
          "        <a href=\"#\" class=\"nav-brand\">"
        }),
        i(1, "Brand"),
        t({
          "</a>",
          "        <ul class=\"nav-menu\">",
          "            <li class=\"nav-item\">",
          "                <a href=\"#\" class=\"nav-link\">"
        }),
        i(2, "Home"),
        t({
          "</a>",
          "            </li>",
          "            <li class=\"nav-item\">",
          "                <a href=\"#\" class=\"nav-link\">"

        }),

        i(3, "About"),
        t({
          "</a>",
          "            </li>",
          "            <li class=\"nav-item\">",
          "                <a href=\"#\" class=\"nav-link\">"
        }),
        i(4, "Contact"),
        t({
          "</a>",
          "            </li>",
          "        </ul>",
          "    </div>",
          "</nav>"
        })
      }),

      -- Hero Section
      s("hero", {
        t({
          "<section class=\"hero\">",
          "    <div class=\"hero-content\">",

          "        <h1 class=\"hero-title\">"
        }),
        i(1, "Amazing Headlines"),
        t({
          "</h1>",
          "        <p class=\"hero-subtitle\">"
        }),
        i(2, "Compelling subtitle that converts"),
        t({
          "</p>",
          "        <div class=\"hero-actions\">",
          "            <button class=\"btn btn-primary\">"
        }),
        i(3, "Primary Action"),
        t({
          "</button>",
          "            <button class=\"btn btn-secondary\">"
        }),
        i(4, "Secondary Action"),
        t({
          "</button>",
          "        </div>",
          "    </div>",
          "</section>"
        })
      }),
    }


    -- CSS Utility Snippets
    local css_snippets = {
      -- Flexbox Center
      s("flex-center", {
        t({
          "display: flex;",
          "justify-content: center;",
          "align-items: center;"
        })
      }),

      -- Grid Layout

      s("grid-layout", {
        t({
          "display: grid;",

          "grid-template-columns: repeat(auto-fit, minmax("
        }),
        i(1, "300px"),

        t({

          ", 1fr));",
          "gap: "
        }),
        i(2, "2rem"),
        t(";")
      }),

      -- Glassmorphism Effect
      s("glassmorphism", {

        t({

          "background: rgba(255, 255, 255, 0.1);",
          "backdrop-filter: blur(10px);",
          "border-radius: 20px;",
          "border: 1px solid rgba(255, 255, 255, 0.2);",
          "box-shadow: 0 8px 32px rgba(0, 0, 0, 0.1);"

        })
      }),


      -- Smooth Animations
      s("smooth-hover", {
        t({
          "transition: all 0.3s ease;",
          "cursor: pointer;",
        }),
        t({
          "",
          "&:hover {",
          "    transform: translateY(-2px);",
          "    box-shadow: 0 10px 25px rgba(0, 0, 0, 0.2);",
          "}"
        })
      }),

      -- Responsive Typography
      s("responsive-text", {
        t({
          "font-size: clamp("
        }),
        i(1, "1rem"),
        t(", "),
        i(2, "2.5vw"),
        t(", "),
        i(3, "3rem"),
        t(");")

      }),

      -- CSS Reset
      s("reset", {
        t({
          "* {",
          "    margin: 0;",
          "    padding: 0;",
          "    box-sizing: border-box;",
          "}",
          "",
          "body {",
          "    font-family: 'Arial', sans-serif;",
          "    line-height: 1.6;",
          "    color: #333;",
          "}"
        })
      }),
    }

    -- Add snippets to LuaSnip
    ls.add_snippets("html", html_snippets)
    ls.add_snippets("css", css_snippets)

    -- Quick Template Generation Commands
    local function create_project_structure(name, template_type)
      local project_path = vim.fn.expand("~/projects/" .. name)

      -- Create directory structure
      vim.fn.system("mkdir -p " .. project_path)
      vim.fn.system("mkdir -p " .. project_path .. "/css")
      vim.fn.system("mkdir -p " .. project_path .. "/js")
      vim.fn.system("mkdir -p " .. project_path .. "/assets")

      -- Create base files
      local html_file = project_path .. "/index.html"
      local css_file = project_path .. "/css/style.css"
      local js_file = project_path .. "/js/script.js"

      -- Generate HTML based on template type
      local html_content = ""
      if template_type == "glassmorphism" then
        html_content = [[

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>]] .. name .. [[</title>
    <link rel="stylesheet" href="css/style.css">

</head>
<body>
    <main>
        <section class="hero">
            <div class="glass-container">
                <h1>Welcome to ]] .. name .. [[</h1>
                <p>Your amazing content here</p>
                <button class="cta-button">Get Started</button>
            </div>
        </section>
    </main>
    <script src="js/script.js"></script>
</body>
</html>]]
      else
        html_content = [[
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>]] .. name .. [[</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>
    <main>
        <h1>Welcome to ]] .. name .. [[</h1>
    </main>
    <script src="js/script.js"></script>
</body>
</html>]]
      end
      
      -- Write files
      vim.fn.writefile(vim.split(html_content, "\n"), html_file)
      vim.fn.writefile({"/* CSS for " .. name .. " */", ""}, css_file)
      vim.fn.writefile({"// JavaScript for " .. name, ""}, js_file)
      
      -- Open the project
      vim.cmd("edit " .. html_file)
      vim.cmd("vsplit " .. css_file)
      
      vim.notify("Project '" .. name .. "' created successfully!", vim.log.levels.INFO)
    end

    -- Commands for quick project creation
    vim.api.nvim_create_user_command("NewProject", function(opts)
      local name = opts.args
      if name == "" then
        name = vim.fn.input("Project name: ")
      end
      create_project_structure(name, "basic")
    end, { nargs = "?" })

    vim.api.nvim_create_user_command("NewGlassProject", function(opts)

      local name = opts.args
      if name == "" then
        name = vim.fn.input("Project name: ")
      end
      create_project_structure(name, "glassmorphism")
    end, { nargs = "?" })

    -- Keymaps for quick access
    map("n", "<leader>hp", ":NewProject<CR>", { desc = "New HTML Project" })
    map("n", "<leader>hg", ":NewGlassProject<CR>", { desc = "New Glassmorphism Project" })
    map("n", "<leader>hb", ":!wslview %<CR>", { desc = "Open in Browser" })

    -- Live server simulation (requires Python)
    map("n", "<leader>hs", ":!cd %:p:h && python -m http.server 8000<CR>", { desc = "Start Local Server" })

    -- Quick HTML/CSS insertion
    map("i", "<C-h>", "<ESC>:lua require('luasnip').expand_or_jump()<CR>", { desc = "Expand Snippet" })

    vim.notify("HTML/CSS Template System loaded successfully!", vim.log.levels.INFO)

end,
}

What I've Completed - Phase 1:
✅ HTML/CSS Template System with:

LuaSnip integration with your existing setup
Pre-built templates: HTML5 boilerplate, glassmorphism landing pages, card layouts, navigation
CSS utility snippets: Flexbox, Grid, glassmorphism effects, smooth animations
Project structure automation: Creates full project folders with proper file organization
Quick commands: :NewProject and :NewGlassProject
Keymaps integration: Uses your existing keymap style with <leader> prefix

Next Steps for Claude.ai #2:
PROMPT FOR NEXT CLAUDE.AI SESSION:
"I'm continuing a freelance HTML/CSS project setup. The previous Claude completed Phase 1: HTML/CSS Template System with LuaSnip integration, project structure automation, and quick commands.
COMPLETED:

✅ HTML/CSS Template System (lua/zedocean/plugins/html-templates.lua)
✅ Snippet library (HTML5, glassmorphism, cards, navigation)
✅ Project structure automation
✅ Quick commands and keymaps

CURRENT TASK - Phase 2:
Create a comprehensive CSS Framework Library with multiple design styles:

Style Variations System: Classic vs Modern, Simple vs Rich, Functional vs Emotional
Component Library: Buttons, forms, layouts, animations
Color scheme generators
Typography systems
Responsive utilities

CONTEXT: First-time freelancer, uses Neovim + lazygit + tmux, needs to create standout designs that beat 99% of competitors. Focus on glassmorphism, modern trends, and easy client customization.
REQUIREMENTS:

Create CSS framework as separate Lua plugin
Include style toggles/variations
Make it work with existing html-templates.lua
Add commands for style switching
Continue the same keymap pattern (<leader>h prefix)

Continue with Phase 2 and provide Phase 3 prompt at the end."
Install the template system by:

Copy the artifact content to ~/.config/nvim/lua/zedocean/plugins/html-templates.lua
Restart Neovim or run :Lazy reload
Use :NewProject mysite or <leader>hp to create projects
Use snippets like html5, glass-landing, navbar in HTML files

This foundation will make you incredibly fast at creating professional websites. The next phase will add the design variety system to blow away your competition!
