if v:version > 700
    " Highlight the current line
    autocmd WinEnter * setlocal cursorline
    autocmd WinLeave * setlocal nocursorline
    set cursorline
    set cursorcolumn

    " Highlight column
    autocmd WinEnter * setlocal colorcolumn=+1
    autocmd WinLeave * setlocal colorcolumn=0
    set colorcolumn=+1
endif
