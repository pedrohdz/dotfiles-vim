" -----------------------------------------------------------------------------
" Color Scheme Settings
" -----------------------------------------------------------------------------
if $TERM == 'xterm-color' && &t_Co == 8
  set t_Co=16
endif

" Automatically turn syntax hilighting on if the terminal can handle it.  All
" color schema configuration *MUST* happen before activating the schema, else
" the modifcations will not take.
if &t_Co > 2 || has("gui_running")
  syntax on
  set background=dark

  " Configured in: 400-colorscheme_jellybeans.vim
  colorscheme jellybeans

  " Configured in: 400-colorscheme_solarized.vim
  "colorscheme solarized

  " Configured in: 400-colorscheme_gruvbox.vim
  "colorscheme gruvbox

  " colorscheme torte
endif
