" Highlight the current line
if v:version > 700
    autocmd WinEnter * setlocal colorcolumn=+1
    autocmd WinLeave * setlocal colorcolumn=0
    set colorcolumn=+1
endif

