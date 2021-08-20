function _PhdzVimDiffConfig()
  if(!&diff)
    return
  endif

  if(get(w:, '_phdz_vimdiff_loaded', 0))
    return
  endif
  let w:_phdz_vimdiff_loaded = 1

  call setpos('.', [0, 1, 1, 0])
endfunction

augroup _phdz_vim_diff_config
  autocmd!
  autocmd BufEnter * if(&diff) | call _PhdzVimDiffConfig()
augroup END
