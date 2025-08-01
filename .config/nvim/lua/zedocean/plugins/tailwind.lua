return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        tailwindcss = {},
      },
    },
  },
  {
    "NvChad/nvim-colorizer.lua",
    opts = {
      user_default_options = {
        tailwind = true,
      },
    },
  },
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      { 
        "roobert/tailwindcss-colorizer-cmp.nvim", 
        config = true 
      },
    },
    opts = function(_, opts)
      -- Ensure opts.formatting is initialized
      opts.formatting = opts.formatting or {}
      opts.formatting.format = opts.formatting.format or function() end
      
      -- Original LazyVim kind icon formatter
      local format_kinds = opts.formatting.format

      opts.formatting.format = function(entry, item)
        format_kinds(entry, item) -- Add icons
        return require("tailwindcss-colorizer-cmp").formatter(entry, item)
      end
    end,
  },
}
