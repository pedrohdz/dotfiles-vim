" Commands and helper functions
" -----------------------------------------------------------------------------

" " Sort CSS properties between the braces alphabetically
" :command! SortCSS :g#\({\n\)\@<=#.,/}/sort | :noh


" Key mapping
" -----------------------------------------------------------------------------

" See the cheatsheet.
map <unique> <S-F1> :help drcheat<cr>:resize 10000<cr>

" Visually select the text that was last edited/pasted
nmap <unique> gV `[v`]

" Leader mapping
" -----------------------------------------------------------------------------
" Clear the search highlight
map <unique> <leader>\ :nohlsearch<cr>

" Collapse all multi-line occurrences of whitespace into one line
map <unique> <leader>CN :%s/^\n\+/\r//<cr>:let @/=''<cr>

" Clean whitespace
map <unique> <leader>CW :%s/\s\+$//<cr>:let @/=''<cr>

" Retab
map <unique> <leader>CT :retab<cr>

" Open current buffer in a new split
map <unique> <leader>s <C-w>v<C-w>l

" Toggle spelling hints
nmap <unique> <leader>ts :set spell!<cr>

" Reload ctags
map <unique> <leader>rt :!ctags --extra=+f -R *<cr><cr>

" Opens an edit command with the path of the currently edited file filled in
map <unique> <leader>e :e <C-R>=expand("%:p:h") . "/" <cr>

" Inserts the path of the currently edited file into a command - Command mode: Ctrl+P
cmap <unique> <C-P> <C-R>=expand("%:p:h") . "/" <CR>

" Closes the window showing the location list from sytastic errors
map <unique> <leader>lc :lcl<cr>


" !- See the statusline plugin for status line settings...

