return {
  "rmagatti/auto-session",
  config = function()
    -- Set sessionoptions before setting up auto-session

    vim.o.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"

    require("auto-session").setup({

      log_level = "info",
      auto_session_suppress_dirs = { "~/", "~/Projects", "~/Downloads", "/" },

      auto_session_use_git_branch = false,
      auto_session_enabled = true,

      auto_save_enabled = true,
      auto_restore_enabled = true,
      -- Important: Set session name based on working directory

      session_lens = {
        buftypes_to_ignore = {},
        load_on_setup = true,
        theme_conf = { border = true },
        previewer = false,
      },
    })
  end,
}
