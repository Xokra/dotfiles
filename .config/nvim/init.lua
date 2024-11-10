require("zedocean.core")
require("zedocean.lazy")
-- Add this to your Neovim config (e.g., init.lua or a separate file like alacritty.lua)

-- Function to sync Alacritty config
local function sync_alacritty_config()
  local source = vim.fn.expand("%:p")
  local target = "/mnt/c/Users/dixie/AppData/Roaming/Alacritty/alacritty.toml"

  -- Check if we're editing the dotfiles version

  if string.match(source, "dotfiles.*alacritty.toml") then
    vim.fn.system(string.format("cp %s %s", source, target))
    vim.notify("Alacritty config synced to Windows!", vim.log.levels.INFO)
  elseif string.match(source, "AppData.*Alacritty.*alacritty.toml") then
    local dotfiles_target = vim.fn.expand("~/dotfiles/alacritty/.config/alacritty/alacritty.toml")

    vim.fn.system(string.format("cp %s %s", source, dotfiles_target))
    vim.notify("Alacritty config synced to dotfiles!", vim.log.levels.INFO)
  end
end

-- Autocommand to sync on save
vim.api.nvim_create_autocmd({ "BufWritePost" }, {
  pattern = { "*alacritty.toml" },
  callback = sync_alacritty_config,
})

-- Keymap to manually sync (useful if you want to force a sync)
vim.keymap.set("n", "<leader>;k", function()
  sync_alacritty_config()
end, { desc = "Sync Alacritty Config" })

-- Optional: Keymap to open Alacritty config
vim.keymap.set("n", "<leader>;q", function()
  vim.cmd("edit " .. vim.fn.expand("~/dotfiles/alacritty/.config/alacritty/alacritty.toml"))
end, { desc = "Edit Alacritty Config" })
