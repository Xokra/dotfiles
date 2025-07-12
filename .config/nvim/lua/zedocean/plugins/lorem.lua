-- ~/.config/nvim/lua/plugins/lorem.lua
-- Lorem ipsum plugins for lazy.nvim

return {
  -- Plugin 1: lorem.nvim - Simple lorem ipsum generator
  {

    "derektata/lorem.nvim",

    cmd = { "Lorem", "LoremIpsum" },
    config = function()
      require("lorem").setup({
        sentenceLength = "mixed", -- "short", "medium", "long", "mixed"

        comma_chance = 0.2,
        max_commas_per_sentence = 2,
      })
    end,
  },

  -- Plugin 2: Lorem.nvim (alternative) - More feature-rich

  {
    "vim-scripts/loremipsum",
    cmd = { "Loremipsum" },
  },

  -- Plugin 3: Another lorem ipsum option
  {
    "tpope/vim-speeddating", -- This is just an example of additional plugin
    lazy = true,
  },
}
