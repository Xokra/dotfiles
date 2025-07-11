return {
  "dhruvasagar/vim-table-mode",
  config = function()
    -- Plugin-specific configurations
    vim.g.table_mode_map_prefix = "<Leader>tm" -- Use `<Leader>tm` for plugin's internal mappings
    vim.g.table_mode_corner = "|" -- Customize table corner character
    vim.g.table_mode_corner_corner = "+" -- Customize table intersection character
    vim.g.table_mode_auto_align = 1 -- Auto-align tables when leaving insert mode
  end,
  keys = {
    { "<Leader>tm", ":TableModeToggle<CR>", desc = "Toggle Table Mode" },
    { "<Leader>ta", ":TableModeRealign<CR>", desc = "Realign Table" },
    { "<Leader>tr", ":TableModeInsertRow<CR>", desc = "Insert Row in Table" },
    { "<Leader>tdr", ":TableModeDeleteRow<CR>", desc = "Delete Row in Table" },
    { "<Leader>tc", ":TableModeInsertColumn<CR>", desc = "Insert Column in Table" },
    { "<Leader>tdc", ":TableModeDeleteColumn<CR>", desc = "Delete Column in Table" },
    { "<Leader>te", ":TableModeDisable<CR>", tdesc = "Disable Table Mode" },
  },
  cmd = { "TableModeToggle", "TableAlign" }, -- Lazy load with commands
}
