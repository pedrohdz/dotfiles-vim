" File type utility settings
" -----------------------------------------------------------------------------

" Turn wrapping on for text based languages (markdown, txt...)
function! s:setWrapping()
  setlocal wrap linebreak nolist spell
endfunction

" Enable browser refreshing on web languages
function! s:setBrowserEnv()
  if has('mac')
    map <unique> <buffer> <leader>r :RRB<cr>
  endif
endfunction

" Sort CSS selectors and allow for browser refresh
function! s:setCSS()
  call s:setBrowserEnv()
endfunction


" File handling and settings
" -----------------------------------------------------------------------------
if !exists("autocmd_loaded_dr_vimfiles_ilzgh")
  let autocmd_loaded_dr_vimfiles_ilzgh = 1

  " Reload .vimrc after it or vimrc.local been saved
  autocmd! BufWritePost .vimrc source %
  autocmd! BufWritePost .vimrc.local source ~/.vimrc

  " File type settings on load
  autocmd BufRead,BufNewFile *.scss set filetype=scss
  autocmd BufRead,BufNewFile *.m*down set filetype=markdown
  autocmd BufRead,BufNewFile *.as set filetype=actionscript
  autocmd BufRead,BufNewFile *.json set filetype=json

  " Call the file type utility methods
  autocmd BufRead,BufNewFile *.txt call s:setWrapping()
  autocmd BufRead,BufNewFile *.css,*.scss call s:setCSS()
  autocmd BufRead,BufNewFile *.html,*.js,*.haml,*.erb call s:setBrowserEnv()

  " Enable autosave
  autocmd FocusLost * :wa

  " Enable omnicomplete for supported filetypes
  autocmd FileType * if exists("+completefunc") && &completefunc == "" | setlocal completefunc=syntaxcomplete#Complete | endif
  autocmd FileType * if exists("+omnifunc") && &omnifunc == "" | setlocal omnifunc=syntaxcomplete#Complete | endif

endif

