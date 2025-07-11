return {
  "folke/persistence.nvim",
  event = "BufReadPre", -- Load when opening a buffer
  opts = {
    dir = vim.fn.expand("~/.nvim/sessions/"), -- Where to save session files
    options = { "buffers", "curdir", "tabpages", "winsize" }, -- What to save
  },
  config = function(_, opts)
    require("persistence").setup(opts)
    -- Auto-save session on exit
    vim.api.nvim_create_autocmd("VimLeave", {
      callback = function()
        require("persistence").save()
      end,
    })
  end,
}
