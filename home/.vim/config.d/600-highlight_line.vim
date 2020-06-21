" Highlight the current line
if v:version > 700
    autocmd WinEnter * setlocal cursorline
    autocmd WinLeave * setlocal nocursorline
    set cursorline
endif
