autocmd BufEnter * if(&diff) | call setpos('.', [0, 1, 1, 0])
