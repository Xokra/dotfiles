require("zedocean.core")

require("zedocean.lazy")

-- Function to detect operating system
local function get_os()
  local uname = vim.fn.system("uname -s"):gsub("%s+", "")
  if uname == "Linux" then
    -- Check if we're in WSL
    local wsl_check = vim.fn.system("uname -r"):lower()
    if string.match(wsl_check, "microsoft") or string.match(wsl_check, "wsl") then
      return "wsl"
    else
      return "linux"
    end
  elseif uname == "Darwin" then
    return "mac"
  else
    return "unknown"
  end
end

-- Function to get Windows username (only for WSL)
local function get_windows_username()
  local handle = io.popen("cmd.exe /c 'echo %USERNAME%' 2>/dev/null")
  if handle then
    local username = handle:read("*a"):gsub("%s+", "")
    handle:close()
    return username ~= "" and username or "dixie"
  end
  return "dixie"
end

-- Function to get the correct target path based on OS
local function get_alacritty_target()
  local os = get_os()

  if os == "wsl" then
    local windows_user = get_windows_username()
    return "/mnt/c/Users/" .. windows_user .. "/AppData/Roaming/Alacritty/alacritty.toml"
  elseif os == "mac" then
    return vim.fn.expand("~/.config/alacritty/alacritty.toml")
  elseif os == "linux" then
    return vim.fn.expand("~/.config/alacritty/alacritty.toml")
  else
    return vim.fn.expand("~/.config/alacritty/alacritty.toml")
  end
end

-- Function to create target directory based on OS
local function create_target_dir()
  local os = get_os()

  if os == "wsl" then
    local windows_user = get_windows_username()
    vim.fn.system(string.format("mkdir -p '/mnt/c/Users/%s/AppData/Roaming/Alacritty'", windows_user))
  else
    vim.fn.system("mkdir -p ~/.config/alacritty")
  end
end

-- Function to sync Alacritty config
local function sync_alacritty_config()
  local source = vim.fn.expand("%:p")
  local target = get_alacritty_target()

  -- Check if we're editing the dotfiles version

  if string.match(source, "dotfiles.*alacritty.toml") then
    -- Create target directory
    create_target_dir()

    -- Remove existing file first (in case it's a broken symlink or empty)
    vim.fn.system(string.format("rm -f '%s'", target))

    -- Copy from dotfiles to target
    local result = vim.fn.system(string.format("cp '%s' '%s'", source, target))
    if vim.v.shell_error == 0 then
      vim.notify("Alacritty config synced to system!", vim.log.levels.INFO)
    else
      vim.notify("Failed to sync Alacritty config: " .. result, vim.log.levels.ERROR)
    end
  elseif
    string.match(source, "AppData.*Alacritty.*alacritty.toml")
    or string.match(source, "%.config.*alacritty.*alacritty.toml")
  then
    -- Use lowercase alacritty (standard convention)

    local dotfiles_target = vim.fn.expand("~/dotfiles/.config/alacritty/alacritty.toml")

    -- Create dotfiles directory if it doesn't exist

    vim.fn.system("mkdir -p ~/dotfiles/.config/alacritty")

    -- Remove existing file first
    vim.fn.system(string.format("rm -f '%s'", dotfiles_target))

    -- Copy from system to dotfiles
    local result = vim.fn.system(string.format("cp '%s' '%s'", source, dotfiles_target))
    if vim.v.shell_error == 0 then
      vim.notify("Alacritty config synced to dotfiles!", vim.log.levels.INFO)
    else
      vim.notify("Failed to sync Alacritty config: " .. result, vim.log.levels.ERROR)
    end
  end
end

-- Autocommand to sync on save
vim.api.nvim_create_autocmd({ "BufWritePost" }, {
  pattern = { "*alacritty.toml" },
  callback = sync_alacritty_config,
})

-- Keymap to manually sync
vim.keymap.set("n", "<leader>;k", function()
  sync_alacritty_config()
end, { desc = "Sync Alacritty Config" })

-- Optional: Keymap to open Alacritty config (use lowercase)
vim.keymap.set("n", "<leader>;q", function()
  vim.cmd("edit " .. vim.fn.expand("~/dotfiles/.config/alacritty/alacritty.toml"))
end, { desc = "Edit Alacritty Config" })
