return {
  {
    "ellisonleao/gruvbox.nvim",
    lazy = true,
  },
  {
    "folke/tokyonight.nvim",
    opts = { style = "moon" },
  },
  {
    "neanias/everforest-nvim",
    version = false,
    lazy = true,
  },
  {
    "projekt0n/github-nvim-theme",
    lazy = true,
  },
  {
    "thedenisnikulin/vim-cyberpunk",
    lazy = false,
    priority = 1000,
    config = function()
      vim.g.cyberpunk_cursorline = "black"
    end,
  },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "",
    },
  },
}
