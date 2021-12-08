function _PhdzPluginInstallPath()
  if has('nvim')
    return '~/.vim/plugged-nvim'
  endif
  return '~/.vim/plugged'
endfunction

call plug#begin(_PhdzPluginInstallPath())

" -----------------------------------------------------------------------------
" Conquer of Completion (CoC)
if has('nvim')
  Plug 'neovim/nvim-lspconfig'
  Plug 'ms-jpq/coq_nvim', {'branch': 'coq'}
  Plug 'ms-jpq/coq.artifacts', {'branch': 'artifacts'}
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
Plug 'farmergreg/vim-lastplace'
Plug 'lambdalisue/fern.vim'
Plug 'liuchengxu/vim-which-key'
Plug 'mustache/vim-mustache-handlebars'
Plug 'pearofducks/ansible-vim'
Plug 'tomtom/tcomment_vim'
Plug 'towolf/vim-helm'

" Fuzzy Finder
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'

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
Plug 'SirVer/ultisnips'
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
