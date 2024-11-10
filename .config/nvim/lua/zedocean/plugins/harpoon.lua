return {
  "ThePrimeagen/harpoon",
  branch = "harpoon2",
  config = function()
    local harpoon = require("harpoon")
    harpoon:setup()

    vim.keymap.set("n", "<m-a><m-o>", function()
      harpoon:list():add()
    end)
    vim.keymap.set("n", "<m-a><m-u>", function()
      harpoon.ui:toggle_quick_menu(harpoon:list())
    end)

    -- Set <Alt>1..<Alt>5 be my shortcuts to moving to the files
    for _, idx in ipairs({ 1, 2, 3, 4, 5, 6, 7, 8, 9 }) do
      vim.keymap.set("n", string.format("<m-%d>", idx), function()
        harpoon:list():select(idx)
      end)
    end
  end,
}
