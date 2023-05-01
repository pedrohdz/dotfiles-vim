"----
" Configuring mattn/gist-vim
"----
let g:gist_detect_filetype = 1
let g:gist_open_browser_after_post = 1

let s:gist_cred_path = expand('~/.vim/private/gist-credentials.vim')
if filereadable(s:gist_cred_path)
  exec 'source ' . s:gist_cred_path
endif
