" Key mapping
" -----------------------------------------------------------------------------

" See the cheatsheet.
map <unique> <S-F1> :help drcheat<cr>:resize 10000<cr>

" Visually select the text that was last edited/pasted
nmap <unique> gV `[v`]


" General
" -----------------------------------------------------------------------------
let g:bufExplorerDisableDefaultKeyMapping = 1


" Function keys
" -----------------------------------------------------------------------------
if !has('nvim')
  map <unique> <F2>   :ToggleBufExplorer<CR>
endif

map <unique> <F5> :GundoToggle<cr>
map <unique> <F6> :YRShow<cr>
set pastetoggle=<F7>


" Leader mapping
" -----------------------------------------------------------------------------
" Clear the search highlight
map <unique> <leader>\ :nohlsearch<cr>

map <unique> <leader>CN :%s/^\n\+/\r/<cr>:let @/=''<cr>
map <unique> <leader>CT :retab<cr>
map <unique> <leader>CW :%s/\s\+$//<cr>:let @/=''<cr>

if has('nvim')
lua << EOF
  local which_key = require('which-key')
  which_key.register({
    C = {
      name = 'clean',
      N = 'clean-vertical-whitespace',
      T = 'clean-tabs',
      W = 'clean-whitespace',
    }
  }, { prefix = '<leader>' })
EOF
endif


" Toggle spelling hints
nmap <unique> <leader>ts :set spell!<cr>


" Inserts the path of the currently edited file into a command - Command mode: Ctrl+P
cmap <unique> <C-P> <C-R>=expand("%:p:h") . "/" <CR>
