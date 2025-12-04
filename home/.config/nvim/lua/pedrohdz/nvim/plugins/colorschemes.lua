return {
  -- ----
  -- Color Schemes
  -- ----
  {
    'metalelf0/jellybeans-nvim',
    lazy = false,
    priority = 1000,
    dependencies = {
      'rktjmp/lush.nvim'
    },
    config = function()
      vim.cmd.colorscheme('jellybeans-nvim')
    end,
  },
  {
    'nanotech/jellybeans.vim',
    lazy = false,
    priority = 1000,
    -- config = function()
    --   vim.cmd.colorscheme('jellybeans')
    -- end,
  },

  {
    'altercation/vim-colors-solarized',
    priority = 1000,
  },
  {
    'dhruvasagar/vim-railscasts-theme',
    priority = 1000,
  },
  {
    'morhetz/gruvbox',
    priority = 1000,
  },
  {
    'romainl/Apprentice',
    priority = 1000,
  },

  -- ----
  -- Other
  -- ----
  'vim-scripts/colorsel.vim',
}
