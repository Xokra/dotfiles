return {
  "nvim-telescope/telescope.nvim",
  branch = "0.1.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    "nvim-tree/nvim-web-devicons",
    "folke/todo-comments.nvim",
    -- Additional useful extensions
    "nvim-telescope/telescope-ui-select.nvim",
    "nvim-telescope/telescope-file-browser.nvim",
  },
  config = function()
    local telescope = require("telescope")
    local actions = require("telescope.actions")
    local builtin = require("telescope.builtin")
    
    -- Enhanced telescope configuration
    telescope.setup({
      defaults = {
        -- Appearance
        prompt_prefix = "🔍 ",
        selection_caret = "➤ ",
        entry_prefix = "  ",
        initial_mode = "insert",
        selection_strategy = "reset",
        sorting_strategy = "ascending",
        layout_strategy = "horizontal",
        
        -- Layout configuration
        layout_config = {

          horizontal = {
            prompt_position = "top",
            preview_width = 0.55,
            results_width = 0.8,
          },
          vertical = {
            mirror = false,
          },
          width = 0.87,
          height = 0.80,
          preview_cutoff = 120,
        },
        

        -- File handling
        file_ignore_patterns = {
          "node_modules",
          ".git/",
          ".DS_Store",
          "*.pyc",
          "*.pyo",
          "*.pyd",
          "__pycache__",

          ".pytest_cache",

          ".mypy_cache",
          "*.min.js",
          "*.min.css",
          "dist/",
          "build/",
          "coverage/",
          ".next/",
          ".nuxt/",
          ".vuepress/",
          ".serverless/",
          ".fusebox/",
          ".dynamodb/",

          ".tern-port",
          ".env",
          ".env.local",
          ".env.development.local",
          ".env.test.local",
          ".env.production.local",
          "npm-debug.log*",
          "yarn-debug.log*",
          "yarn-error.log*",
        },
        
        -- Path display
        path_display = { 
          "truncate", 

          truncate = 3,
        },

        
        -- Color and highlighting

        color_devicons = true,
        use_less = true,
        set_env = { ["COLORTERM"] = "truecolor" },
        
        -- Performance

        cache_picker = {
          num_pickers = 10,
        },
        
        -- Enhanced mappings
        mappings = {
          i = {

            -- Navigation
            ["<C-n>"] = actions.cycle_history_next,
            ["<C-p>"] = actions.cycle_history_prev,
            ["<C-j>"] = actions.move_selection_next,
            ["<C-k>"] = actions.move_selection_previous,
            
            -- Selection actions
            ["<C-c>"] = actions.close,

            ["<Down>"] = actions.move_selection_next,
            ["<Up>"] = actions.move_selection_previous,

            ["<CR>"] = actions.select_default,

            ["<C-x>"] = actions.select_horizontal,
            ["<C-v>"] = actions.select_vertical,
            ["<C-t>"] = actions.select_tab,

            
            -- Quickfix and location list
            ["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
            ["<M-q>"] = actions.send_selected_to_qflist + actions.open_qflist,

            
            -- Scroll preview

            ["<C-u>"] = actions.preview_scrolling_up,
            ["<C-d>"] = actions.preview_scrolling_down,

            
            -- Toggle selection
            ["<Tab>"] = actions.toggle_selection + actions.move_selection_worse,
            ["<S-Tab>"] = actions.toggle_selection + actions.move_selection_better,
            
            -- File browser specific
            ["<C-o>"] = function(prompt_bufnr)
              return require("telescope").extensions.file_browser.actions.open(prompt_bufnr)
            end,

            
            -- Clear input
            ["<C-l>"] = actions.complete_tag,
            
            -- Paste from system clipboard

            ["<C-r>"] = actions.paste_register,

          },

          n = {
            -- Navigation

            ["<esc>"] = actions.close,
            ["<CR>"] = actions.select_default,
            ["<C-x>"] = actions.select_horizontal,

            ["<C-v>"] = actions.select_vertical,
            ["<C-t>"] = actions.select_tab,
            
            -- Quickfix
            ["<C-q>"] = actions.send_to_qflist + actions.open_qflist,

            ["<M-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
            
            -- Movement
            ["j"] = actions.move_selection_next,
            ["k"] = actions.move_selection_previous,
            ["H"] = actions.move_to_top,
            ["M"] = actions.move_to_middle,
            ["L"] = actions.move_to_bottom,
            
            -- Scroll
            ["<Down>"] = actions.move_selection_next,
            ["<Up>"] = actions.move_selection_previous,
            ["gg"] = actions.move_to_top,
            ["G"] = actions.move_to_bottom,

            
            -- Scroll preview

            ["<C-u>"] = actions.preview_scrolling_up,
            ["<C-d>"] = actions.preview_scrolling_down,

            
            -- Toggle selection
            ["<Tab>"] = actions.toggle_selection + actions.move_selection_worse,
            ["<S-Tab>"] = actions.toggle_selection + actions.move_selection_better,
            
            -- Select all
            ["<C-a>"] = actions.select_all,
            
            -- Drop all

            ["<C-r>"] = actions.drop_all,
            
            -- Toggle help
            ["?"] = actions.which_key,
          },
        },
        
        -- Grep configuration
        vimgrep_arguments = {

          "rg",
          "--color=never",
          "--no-heading",
          "--with-filename",
          "--line-number",
          "--column",
          "--smart-case",
          "--hidden",
          "--glob=!.git/",
        },
      },
      
      -- ================================
      -- PICKER SPECIFIC CONFIGURATIONS

      -- ================================
      
      pickers = {
        -- File finders
        find_files = {

          theme = "dropdown",
          previewer = false,
          hidden = true,
          find_command = { "rg", "--files", "--hidden", "--glob", "!.git/*" },
        },
        
        oldfiles = {
          theme = "dropdown",
          previewer = false,
        },
        
        buffers = {
          theme = "dropdown",

          previewer = false,
          initial_mode = "normal",
          mappings = {
            i = {
              ["<C-d>"] = actions.delete_buffer,
            },
            n = {
