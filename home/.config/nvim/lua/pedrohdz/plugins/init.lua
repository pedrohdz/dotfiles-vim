return {
  'dmitmel/cmp-cmdline-history',
  'folke/trouble.nvim',
  'hrsh7th/cmp-buffer',
  'hrsh7th/cmp-cmdline',
  'hrsh7th/cmp-nvim-lsp',
  'hrsh7th/cmp-nvim-lua',
  'hrsh7th/cmp-path',
  'hrsh7th/nvim-cmp',
  'kyazdani42/nvim-web-devicons',
  'onsails/lspkind.nvim',
  'windwp/nvim-autopairs',

  {
    'williamboman/mason.nvim',
    'williamboman/mason-lspconfig.nvim',
    'neovim/nvim-lspconfig',
  },

  -- For vsnip users.
  'hrsh7th/cmp-vsnip',
  'hrsh7th/vim-vsnip',

  {
    'jose-elias-alvarez/null-ls.nvim',
    dependencies = {
      { 'nvim-lua/plenary.nvim' },
    }
  },

  {
    'nvim-telescope/telescope.nvim',
    -- version = '0.1.6',
    dependencies = { { 'nvim-lua/plenary.nvim' } }
  },

  {
    'sudormrfbin/cheatsheet.nvim',
    dependencies = {
      { 'nvim-telescope/telescope.nvim' },
      { 'nvim-lua/popup.nvim' },
      { 'nvim-lua/plenary.nvim' },
    }
  },

  {
    'nvim-treesitter/nvim-treesitter',
    build = function()
      local ts_update = require('nvim-treesitter.install').update({ with_sync = true })
      ts_update()
    end,
  },

  -- -----------------------------------------------------------------------------
  -- Color configuration
  'altercation/vim-colors-solarized',
  'dhruvasagar/vim-railscasts-theme',
  'morhetz/gruvbox',
  'nanotech/jellybeans.vim',
  'romainl/Apprentice',

  'vim-scripts/colorsel.vim',

  -- -----------------------------------------------------------------------------
  -- New plugins (post `dr-vimfiles*`)
  'farmergreg/vim-lastplace',
  'junegunn/fzf',
  'junegunn/fzf.vim',
  'lambdalisue/fern.vim',
  'mustache/vim-mustache-handlebars',
  'pearofducks/ansible-vim',
  'towolf/vim-helm',
  { 'cespare/vim-toml', branch = 'main', ft = 'toml' },
  { 'lewis6991/gitsigns.nvim' },
  { 'lukas-reineke/indent-blankline.nvim' },
  { 'numToStr/Comment.nvim' },
  { 'rust-lang/rust.vim', ft = 'rust' },

  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons', lazy = true },
  },

  {
    'stevearc/oil.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons', lazy = true },
    version = 'v2.*',
  },

  {
    'nvim-tree/nvim-tree.lua',
    dependencies = { 'nvim-tree/nvim-web-devicons', lazy = true },
    version = 'v1.*',
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
    'folke/which-key.nvim',
    -- version = 'v1.*',  -- the `*` does not seem to work
    version = 'v1.6.1', -- FIXME - needs to be updated
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

  {
    'iamcco/markdown-preview.nvim',
    build = function() vim.fn['mkdp#util#install']() end,
  },

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
  'tpope/vim-markdown',
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
