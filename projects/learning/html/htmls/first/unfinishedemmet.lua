-- lua/plugins/emmet.lua
return {
  "mattn/emmet-vim",
  ft = { "html", "css", "javascript", "typescript", "jsx", "tsx" },
  config = function()
    -- Enable Emmet for specific filetypes
    vim.g.user_emmet_install_global = 0
    vim.g.user_emmet_mode = 'iv'

    
    -- Custom Emmet settings

    vim.g.user_emmet_settings = {
      variables = {
        lang = 'en',
        charset = 'UTF-8'
      },

      html = {
        default_attributes = {
          option = { value = nil },
          textarea = { id = nil, name = nil, cols = 10, rows = 10 },
          meta = { charset = 'UTF-8' },
          style = { type = 'text/css' },
          script = { type = 'text/javascript' },
          img = { src = '', alt = '' },
          a = { href = '' },
        },
        snippets = {
          html = '<!DOCTYPE html>\n<html lang="${lang}">\n<head>\n\t<meta charset="${charset}">\n\t<meta name="viewport" content="width=device-width, initial-scale=1.0">\n\t<title></title>\n</head>\n<body>\n\t${child}|\n</body>\n</html>',
        },
      },
    }
    
    -- Keybindings
    vim.keymap.set('i', '<C-e>', '<C-y>,', { desc = 'Emmet expand' })
    vim.keymap.set('n', '<leader>ee', '<C-y>,', { desc = 'Emmet expand' })
    
    -- Auto-commands for specific filetypes
    vim.api.nvim_create_autocmd("FileType", {
      pattern = { "html", "css", "javascript", "typescript", "jsx", "tsx" },
      callback = function()

        vim.cmd("EmmetInstall")

      end,
    })

  end

}

-- Also add nvim-cmp for better completion
-- lua/plugins/cmp.lua
return {
  "hrsh7th/nvim-cmp",
  dependencies = {
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
    "hrsh7th/cmp-cmdline",
    "hrsh7th/cmp-nvim-lsp",
    "saadparwaiz1/cmp_luasnip",
    "onsails/lspkind.nv
