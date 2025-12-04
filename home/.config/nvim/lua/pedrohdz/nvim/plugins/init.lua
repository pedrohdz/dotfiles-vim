return {
  'dmitmel/cmp-cmdline-history',
  'hrsh7th/cmp-buffer',
  'hrsh7th/cmp-cmdline',
  'hrsh7th/cmp-nvim-lsp',
  'hrsh7th/cmp-nvim-lua',
  'hrsh7th/cmp-path',
  'hrsh7th/nvim-cmp',
  'neovim/nvim-lspconfig',
  'onsails/lspkind.nvim',
  'windwp/nvim-autopairs',

  {
    'nvim-tree/nvim-web-devicons',
    opts = {}
  },

  -- For vsnip users.
  'hrsh7th/cmp-vsnip',
  'hrsh7th/vim-vsnip',

  {
    'sudormrfbin/cheatsheet.nvim',
    dependencies = {
      { 'nvim-telescope/telescope.nvim' },
      { 'nvim-lua/popup.nvim' },
      { 'nvim-lua/plenary.nvim' },
    }
  },


  -- -----------------------------------------------------------------------------
  -- New plugins (post `dr-vimfiles*`)
  'farmergreg/vim-lastplace',
  'mustache/vim-mustache-handlebars',
  'pearofducks/ansible-vim',
  'towolf/vim-helm',
  { 'cespare/vim-toml',                   branch = 'main', ft = 'toml' },
  { 'lewis6991/gitsigns.nvim' },
  { 'lukas-reineke/indent-blankline.nvim' },
  { 'numToStr/Comment.nvim' },
  { 'rust-lang/rust.vim',                 ft = 'rust' },

  {
    'nvim-lualine/lualine.nvim',
    dependencies = {
      'nvim-tree/nvim-web-devicons',
    },
  },

  {
    'stevearc/oil.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons', lazy = true },
    version = 'v2.*',
  },


  {
    's1n7ax/nvim-window-picker',
    version = 'v2.*',
    config = function()
      require('window-picker').setup()
    end,
  },

  -- {
  --   'nvim-telescope/telescope-file-browser.nvim',
  --   dependencies = {
  --     'nvim-telescope/telescope.nvim',
  --     'nvim-lua/plenary.nvim',
  --   }
  -- },

  {
    'folke/todo-comments.nvim',
    version = 'v1.*',
    dependencies = {
      'nvim-lua/plenary.nvim',
    }
  },

  {
    'echasnovski/mini.ai',
    version = 'v0.13.0', -- FIXME - needs to be updated
    config = function()
      require('mini.ai').setup()
    end,
  },

  -- -----------------------------------------------------------------------------
  -- Graduated from dr-vimfiles
  'elzr/vim-json',
  'kevinoid/vim-jsonc',
  'pedrohdz/vim-yaml-folds',

  -- -----------------------------------------------------------------------------
  -- From original dr-vimfiles
  'godlygeek/tabular',
  'jlanzarotta/bufexplorer',
  'majutsushi/tagbar',
  'mattn/gist-vim',
  'mattn/webapi-vim',
  'othree/xml.vim',
  'pangloss/vim-javascript',
  'sjl/gundo.vim',
  'tpope/vim-fugitive',
  'tpope/vim-haml',
  'tpope/vim-repeat',
  'tpope/vim-sensible',
  'tpope/vim-speeddating',
  'tpope/vim-surround',
  'tpope/vim-unimpaired',
  'vim-scripts/HTML-AutoCloseTag',
  'vim-scripts/YankRing.vim', -- TODO - Find something newer?

  -- -----------------------------------------------------------------------------
  -- dr-vimfiles-devops
  'chr4/nginx.vim',
  'hashivim/vim-consul',
  'hashivim/vim-packer',
  'hashivim/vim-terraform',
  'hashivim/vim-vagrant',

  -- -----------------------------------------------------------------------------
  -- dr-vimfiles-python
  'Glench/Vim-Jinja2-Syntax',
  'Rykka/InstantRst',
  'honza/vim-snippets',
}
