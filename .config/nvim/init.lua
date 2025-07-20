require("zedocean.core")

require("zedocean.lazy")

-- =============================================================================
-- ALACRITTY CONFIG AUTO-SYNC SYSTEM
-- Simple: Edit anywhere, saves everywhere automatically
-- =============================================================================

-- Operating System Detection

local function get_os()
  local uname = vim.fn.system("uname -s"):gsub("%s+", "")
  if uname == "Linux" then
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

local function get_windows_username()
  local handle = io.popen("cmd.exe /c 'echo %USERNAME%' 2>/dev/null")
  if handle then
    local username = handle:read("*a"):gsub("%s+", "")
    handle:close()
    return username ~= "" and username or "dixie"
  end

  return "dixie"
end

-- Get all possible config paths
local function get_all_config_paths()
  local os = get_os()
  local paths = {}

  -- Always include dotfiles path
  table.insert(paths, vim.fn.expand("~/dotfiles/.config/alacritty/alacritty.toml"))

  -- Always include local config path
  table.insert(paths, vim.fn.expand("~/.config/alacritty/alacritty.toml"))

  -- Add Windows path only for WSL
  if os == "wsl" then
    local windows_user = get_windows_username()
    table.insert(paths, "/mnt/c/Users/" .. windows_user .. "/AppData/Roaming/Alacritty/alacritty.toml")
  end

  return paths
end

-- Utility functions
local function create_directory(filepath)
  local dir = vim.fn.fnamemodify(filepath, ":h")
  vim.fn.system("mkdir -p '" .. dir .. "'")
end

local function copy_file(source, target)
  create_directory(target)
  local result = vim.fn.system(string.format("cp '%s' '%s'", source, target))
  return vim.v.shell_error == 0
end

local function is_alacritty_config(filepath)
  return string.match(filepath:lower(), "alacritty.*%.toml$") ~= nil
end

-- Main sync function
local function sync_alacritty_configs()
  local current_file = vim.fn.expand("%:p")

  -- Only proceed if we're editing an alacritty config
  if not is_alacritty_config(current_file) then
    return
  end

  local all_paths = get_all_config_paths()
  local synced_count = 0

  -- Copy current file to all other locations
  for _, target_path in ipairs(all_paths) do
    -- Skip if target is the same as current file
    if vim.fn.resolve(current_file) ~= vim.fn.resolve(target_path) then
      if copy_file(current_file, target_path) then
        synced_count = synced_count + 1
      end
    end
  end

  if synced_count > 0 then
    vim.notify(string.format("Alacritty config synced to %d location(s)", synced_count), vim.log.levels.INFO)
  end
end

-- Auto-sync on save
vim.api.nvim_create_autocmd({ "BufWritePost" }, {
  pattern = { "*alacritty.toml", "*alacritty.yml" },
  callback = sync_alacritty_configs,
  desc = "Auto-sync Alacritty config to all locations",
})
