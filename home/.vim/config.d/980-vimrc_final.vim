
" Loaded after .vimrc, so anything in here will override the .vimrc settings

" User preferences
" -----------------------------------------------------------------------------
" Tabs
"set expandtab
"set shiftwidth=4
"set softtabstop=4
"set tabstop=4
"set smartindent
"set smarttab
"set autoindent

" Viewing/moving around
"set nowrap
"set scrolloff=3
"set sidescrolloff=3
"set showmode
"set foldlevelstart=0
"set foldmethod=marker
"set listchars=tab:▸-,trail:·
set nolist
set nonumber
set textwidth=79
set modeline
set modelines=5


" User plugin configurations
" -----------------------------------------------------------------------------
" let g:yankring_history_dir=$HOME.'/.vim/tmp/yankring/'
" let g:MarkdownPreviewUserStyles=$HOME.'/path/to/user/styles/'
let g:RefreshRunningBrowserDefault = 'chrome'
" let g:snips_author = 'Your Name'

" JSlint
" -----------------------------------------------------------------------------
let g:syntastic_javascript_checkers = [ 'jshint', 'jslint' ]
let g:syntastic_javascript_jslint_conf = ""

" vim-colorscheme-switcher
" -----------------------------------------------------------------------------
" let g:colorscheme_switcher_exclude = [ 'blue', 'cataracts', 'shine', 'snowblind', 'solarized' ]

" User key mapping
" -----------------------------------------------------------------------------
" <F1>-<F8> are reserved for .vimrc

" User leader mapping
" -----------------------------------------------------------------------------


" User file type utility settings
" -----------------------------------------------------------------------------


" User file handling and settings
" -----------------------------------------------------------------------------


" User themes and GUI settings
" -----------------------------------------------------------------------------

" colorscheme colorblind
" colorscheme bloodshot
" colorscheme cataracts
" colorscheme snowblind


" User GUI specific settings (could be in .gvimrc.local)
" -----------------------------------------------------------------------------
" if has('gui_running')
  " set guifont=MesloLGM:h12
  " if has('gui_macvim')
    " set transparency=5
  " end
" endif

set mouse=
