" Preferences
" -----------------------------------------------------------------------------
set autowrite
set encoding=utf-8
set expandtab
set foldlevelstart=0
set foldmethod=marker
set formatoptions=tcq
set hidden
set list
set listchars=tab:▸-,eol:¬,trail:·
set modeline
set modelines=5
set noerrorbells
set nonumber
set novisualbell
set nowrap
set number
set shiftwidth=2
set showcmd
set showmode
set smartindent
set softtabstop=2
set splitbelow splitright
set tabstop=2
set textwidth=79
set title
set ttyfast
set wildmode=list:longest


set pastetoggle=<F7>

if has("mouse")
 set mouse=a
endif

" Backups
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
