-- Bootstrap Packer if it is not already setup...
local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path })
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  use 'dmitmel/cmp-cmdline-history'
  use 'folke/trouble.nvim'
  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/cmp-cmdline'
  use 'hrsh7th/cmp-nvim-lsp'
  use 'hrsh7th/cmp-nvim-lua'
  use 'hrsh7th/cmp-path'
  use 'hrsh7th/nvim-cmp'
  use 'kyazdani42/nvim-web-devicons'
  use 'onsails/lspkind.nvim'
  use 'windwp/nvim-autopairs'

  use {
    'williamboman/mason.nvim',
    'williamboman/mason-lspconfig.nvim',
    'neovim/nvim-lspconfig',
  }

  -- For vsnip users.
  use 'hrsh7th/cmp-vsnip'
  use 'hrsh7th/vim-vsnip'

  use {
    'jose-elias-alvarez/null-ls.nvim',
    requires = {
      { 'nvim-lua/plenary.nvim' },
    }
  }

  use {
    'nvim-telescope/telescope.nvim',
    -- tag = '0.1.6',
    requires = { { 'nvim-lua/plenary.nvim' } }
  }

  use {
    'sudormrfbin/cheatsheet.nvim',
    requires = {
      { 'nvim-telescope/telescope.nvim' },
      { 'nvim-lua/popup.nvim' },
      { 'nvim-lua/plenary.nvim' },
    }
  }

  use {
    'nvim-treesitter/nvim-treesitter',
    run = function()
      local ts_update = require('nvim-treesitter.install').update({ with_sync = true })
      ts_update()
    end,
  }

  -- -----------------------------------------------------------------------------
  -- Color configuration
  use 'altercation/vim-colors-solarized'
  use 'dhruvasagar/vim-railscasts-theme'
  use 'morhetz/gruvbox'
  use 'nanotech/jellybeans.vim'
  use 'romainl/Apprentice'

  use 'vim-scripts/colorsel.vim'

  -- -----------------------------------------------------------------------------
  -- New plugins (post `dr-vimfiles*`)
  use 'farmergreg/vim-lastplace'
  use 'junegunn/fzf'
  use 'junegunn/fzf.vim'
  use 'lambdalisue/fern.vim'
  use 'mustache/vim-mustache-handlebars'
  use 'pearofducks/ansible-vim'
  use 'towolf/vim-helm'
  use { 'cespare/vim-toml', branch = 'main', ft = 'toml' }
  use { 'lewis6991/gitsigns.nvim' }
  use { 'lukas-reineke/indent-blankline.nvim' }
  use { 'numToStr/Comment.nvim' }
  use { 'rust-lang/rust.vim', ft = 'rust' }

  use {
    'nvim-lualine/lualine.nvim',
    requires = { 'nvim-tree/nvim-web-devicons', opt = true },
  }

  use({
    'stevearc/oil.nvim',
    requires = { 'nvim-tree/nvim-web-devicons', opt = true },
    tag = 'v2.*',
  })

  use {
    'nvim-tree/nvim-tree.lua',
    requires = { 'nvim-tree/nvim-web-devicons', opt = true },
    tag = 'v1.*',
  }

  use {
    's1n7ax/nvim-window-picker',
    tag = 'v2.*',
    config = function()
      require('window-picker').setup()
    end,
  }

  -- use {
  --   'nvim-telescope/telescope-file-browser.nvim',
  --   requires = {
  --     'nvim-telescope/telescope.nvim',
  --     'nvim-lua/plenary.nvim',
  --   }
  -- }

  use {
    'folke/todo-comments.nvim',
    tag = 'v1.*',
    requires = {
      'nvim-lua/plenary.nvim',
    }
  }

  --  Remember to run the following:
  --    cd $HOME/.local/share/nvim/site/pack/packer/start/avante.nvim
  --    make
  --  Fix is from:
  --    - https://github.com/yetone/avante.nvim/issues/547#issuecomment-2334232455
  use {
    'yetone/avante.nvim',
    requires = {
      -- Required plugins
      'nvim-treesitter/nvim-treesitter',
      'stevearc/dressing.nvim',
      'nvim-lua/plenary.nvim',
      'MunifTanjim/nui.nvim',
      'MeanderingProgrammer/render-markdown.nvim',
      { 'nvim-tree/nvim-web-devicons', opt = true },
      { 'HakonHarnes/img-clip.nvim',   opt = true },
      { 'zbirenbaum/copilot.lua',      opt = true },
    }
  }

  use {
    'folke/which-key.nvim',
    -- tag = 'v1.*',  -- the `*` does not seem to work
    tag = 'v1.6.1', -- FIXME - needs to be updated
    requires = {
      'nvim-lua/plenary.nvim',
    }
  }

  use {
    'echasnovski/mini.ai',
    tag = 'v0.13.0', -- FIXME - needs to be updated
    config = function()
      require('mini.ai').setup()
    end,
  }

  -- -----------------------------------------------------------------------------
  -- Graduated from dr-vimfiles
  use 'elzr/vim-json'
  use 'kevinoid/vim-jsonc'
  use 'pedrohdz/vim-yaml-folds'

  use({
    'iamcco/markdown-preview.nvim',
    run = function() vim.fn['mkdp#util#install']() end,
  })

  -- -----------------------------------------------------------------------------
  -- From original dr-vimfiles
  use 'godlygeek/tabular'
  use 'jlanzarotta/bufexplorer'
  use 'majutsushi/tagbar'
  use 'mattn/gist-vim'
  use 'mattn/webapi-vim'
  use 'othree/xml.vim'
  use 'pangloss/vim-javascript'
  use 'sjl/gundo.vim'
  use 'tpope/vim-fugitive'
  use 'tpope/vim-haml'
  use 'tpope/vim-markdown'
  use 'tpope/vim-repeat'
  use 'tpope/vim-sensible'
  use 'tpope/vim-speeddating'
  use 'tpope/vim-surround'
  use 'tpope/vim-unimpaired'
  use 'vim-scripts/HTML-AutoCloseTag'
  use 'vim-scripts/YankRing.vim' -- TODO - Find something newer?

  -- -----------------------------------------------------------------------------
  -- dr-vimfiles-devops
  use 'chr4/nginx.vim'
  use 'hashivim/vim-consul'
  use 'hashivim/vim-packer'
  use 'hashivim/vim-terraform'
  use 'hashivim/vim-vagrant'

  -- -----------------------------------------------------------------------------
  -- dr-vimfiles-python
  use 'Glench/Vim-Jinja2-Syntax'
  use 'Rykka/InstantRst'
  use 'honza/vim-snippets'

  if packer_bootstrap then
    require('packer').sync()
  end
end)
