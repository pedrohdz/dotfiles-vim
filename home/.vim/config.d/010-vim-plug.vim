function _PhdzPluginInstallPath()
  if has('nvim')
    return '~/.vim/plugged-nvim'
  endif
  return '~/.vim/plugged'
endfunction

call plug#begin(_PhdzPluginInstallPath())

" -----------------------------------------------------------------------------
" LSP
if has('nvim')
  Plug 'hrsh7th/cmp-buffer'
  Plug 'hrsh7th/cmp-cmdline'
  Plug 'hrsh7th/cmp-nvim-lsp'
  Plug 'hrsh7th/cmp-path'
  Plug 'hrsh7th/nvim-cmp'
  Plug 'neovim/nvim-lspconfig'
  Plug 'onsails/lspkind.nvim'
  Plug 'williamboman/nvim-lsp-installer'

  " For vsnip users.
  Plug 'hrsh7th/cmp-vsnip'
  Plug 'hrsh7th/vim-vsnip'

else
  Plug 'neoclide/coc.nvim', {'branch': 'release'}
endif

" -----------------------------------------------------------------------------
" Airline - Trying it out
" TODO - Replace Powerline in Vim as well?
if has('nvim')
  Plug 'vim-airline/vim-airline'
  Plug 'vim-airline/vim-airline-themes'
endif

" -----------------------------------------------------------------------------
" Color configuration
Plug 'altercation/vim-colors-solarized'
Plug 'dhruvasagar/vim-railscasts-theme'
Plug 'morhetz/gruvbox'
Plug 'nanotech/jellybeans.vim'
Plug 'romainl/Apprentice'

Plug 'vim-scripts/colorsel.vim'
Plug 'xolox/vim-colorscheme-switcher'

" -----------------------------------------------------------------------------
" New plugins (post `dr-vimfiles*`)
"Plug 'dense-analysis/ale'
Plug 'airblade/vim-gitgutter'
Plug 'cespare/vim-toml', { 'branch': 'main', 'for': 'toml' }
Plug 'farmergreg/vim-lastplace'
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
Plug 'lambdalisue/fern.vim'
Plug 'mustache/vim-mustache-handlebars'
Plug 'pearofducks/ansible-vim'
Plug 'rust-lang/rust.vim', { 'for': 'rust' }
Plug 'tomtom/tcomment_vim'
Plug 'towolf/vim-helm'

if has('nvim')
  Plug 'WhoIsSethDaniel/toggle-lsp-diagnostics.nvim'
  Plug 'folke/trouble.nvim'
  Plug 'folke/which-key.nvim'
  Plug 'jose-elias-alvarez/null-ls.nvim'
  Plug 'kyazdani42/nvim-web-devicons'
  Plug 'nvim-lua/plenary.nvim'  " Required by null-ls.nvim & telescope.nvim
  Plug 'nvim-telescope/telescope.nvim'
  Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
endif

if has('conceal')
  Plug 'Yggdroot/indentLine'
end

" -----------------------------------------------------------------------------
" Graduated from dr-vimfiles
Plug 'elzr/vim-json'
Plug 'kevinoid/vim-jsonc'

" -----------------------------------------------------------------------------
" From original dr-vimfiles
Plug 'ctrlpvim/ctrlp.vim'
Plug 'godlygeek/tabular'
Plug 'jlanzarotta/bufexplorer'
Plug 'majutsushi/tagbar'
Plug 'mattn/gist-vim'
Plug 'mattn/webapi-vim'
Plug 'othree/xml.vim'
Plug 'pangloss/vim-javascript'
"Plug 'scrooloose/nerdcommenter'  " Replaced by tomtom/tcomment_vim
"Plug 'scrooloose/syntastic'  " Replacing with dense-analysis/ale
Plug 'sjl/gundo.vim'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-haml'
Plug 'tpope/vim-markdown'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-speeddating'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'vim-scripts/HTML-AutoCloseTag'
Plug 'vim-scripts/YankRing.vim'
Plug 'xolox/vim-misc'  " Requires by xolox/vim-colorscheme-switcher

" -----------------------------------------------------------------------------
" dr-vimfiles-devops
Plug 'chr4/nginx.vim'
Plug 'hashivim/vim-consul'
Plug 'hashivim/vim-packer'
Plug 'hashivim/vim-terraform'
Plug 'hashivim/vim-vagrant'

" -----------------------------------------------------------------------------
" dr-vimfiles-nodejs
"Plug 'suan/vim-instant-markdown'
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install'  }

" -----------------------------------------------------------------------------
" dr-vimfiles-python
Plug 'Glench/Vim-Jinja2-Syntax'
Plug 'Rykka/InstantRst'
" Plug 'SirVer/ultisnips'  " Revisit
Plug 'pedrohdz/vim-yaml-folds'
"Plug 'hdima/python-syntax'
Plug 'honza/vim-snippets'
"Plug 'hynek/vim-python-pep8-indent'
Plug 'ingydotnet/yaml-vim'
"Plug 'jmcantrell/vim-virtualenv'


" -----------------------------------------------------------------------------
" Old
"Plug 'Raimondi/delimitMate'

call plug#end()
