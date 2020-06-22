" Preferences
" -----------------------------------------------------------------------------
set modelines=0
set encoding=utf-8
set scrolloff=3
set sidescrolloff=3
set autoindent
set smartindent
set showmode
set showcmd
set hidden
set wildmenu
set wildmode=list:longest
set noerrorbells
set novisualbell
set ttyfast
set ruler
set backspace=indent,eol,start
set number
set title
set laststatus=2
set splitbelow splitright
set tabstop=2
set shiftwidth=2
set softtabstop=2
set smarttab
set expandtab
set nowrap
set list
set listchars=tab:▸-,eol:¬,trail:·
set foldlevelstart=0
set foldmethod=marker
set formatoptions=tcq
set autowrite

set pastetoggle=<F7>

if has("mouse")
 set mouse=a
endif

" Backups
set history=1000
set undolevels=1000
set backup
set directory=.
set viminfo='500,:1000,/1000,f1,n~/.viminfo

" Searching
set incsearch
set showmatch
set hlsearch
runtime macros/matchit.vim

" Popup menu behavior
set completeopt=longest,menu
set pumheight=20

let mapleader = '\'
