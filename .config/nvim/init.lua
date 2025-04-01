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

-- -- Add this to your init.lua
-- local function format_js_headings()
--   local bufnr = 0 -- Current buffer
--   local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
--   local new_lines = {}
--
--   local last_non_empty_was_js = false
--
--   for i = 1, #lines do
--     local current_line = lines[i]
--
--     local is_js_heading = current_line:match("^JS%s+")
--     local is_empty = current_line:match("^%s*$")
--
--     if is_js_heading then
--       -- Starting a new JS section
--       if i > 1 and not last_non_empty_was_js then
--         -- Add exactly 3 blank lines before a new JS heading
--         -- (unless it's the first line or follows another JS heading)
--
--         local empty_count = 0
--         local check_idx = i - 1
--
--         -- Count existing blank lines before this heading
--         while check_idx >= 1 and lines[check_idx]:match("^%s*$") do
--           empty_count = empty_count + 1
--           check_idx = check_idx - 1
--         end
--
--         -- Clear any existing empty lines we've already added
--         while #new_lines > 0 and new_lines[#new_lines]:match("^%s*$") do
--           table.remove(new_lines)
--         end
--
--         -- Add exactly 3 blank lines
--         for _ = 1, 3 do
--           table.insert(new_lines, "")
--         end
--       end
--
--       last_non_empty_was_js = true
--     elseif not is_empty then
--       last_non_empty_was_js = false
--     end
--
--     -- Add the current line
--     table.insert(new_lines, current_line)
--   end
--
--   -- Replace buffer content with our adjusted lines
--   vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, new_lines)
-- end
--
-- -- Create an autocommand to run this function before saving .md files
--
-- vim.api.nvim_create_autocmd("BufWritePre", {
--
--   pattern = "*.md",
--   callback = function()
--     format_js_headings()
--   end,
-- })
--
-- -- Create a command to run this function manually if needed
-- vim.api.nvim_create_user_command("FormatJSHeadings", function()
--   format_js_headings()
-- end, {})
--
-- vim.g.format_sync_post_hook = function()
--   if vim.bo.filetype == "markdown" then
--     format_js_headings()
--     vim.cmd("noautocmd write")
--   end
-- end
--
-- vim.api.nvim_create_autocmd("BufWritePost", { -- Note: BufWritePost instead of BufWritePre
--
--   pattern = "*.md",
--   callback = function()
--     format_js_headings()
--     -- Save again without triggering additional formatting
--     vim.cmd("noautocmd write")
--   end,
-- })
