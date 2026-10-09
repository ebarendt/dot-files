return {
  -- Configure TokyoNight with the "day" style
  {
    "folke/tokyonight.nvim",
    -- opts = { style = "day" },
  },

  -- Tell LazyVim to load the TokyoNight Day colorscheme
  {
    "LazyVim/LazyVim",
    opts = {
      -- colorscheme = "tokyonight-day",
      colorscheme = "tokyonight",
    },
  },
}
