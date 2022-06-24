"------------------------------------------------------------------------------
" Helper functions
"------------------------------------------------------------------------------
function! PhdzCalculateNewVimPath(path, new_vim_user_home)
  if empty(a:new_vim_user_home)
    throw 'Variable "new_vim_user_home" must be set!'
  endif

  let s:new_vim_user_home = expand(a:new_vim_user_home)
  let s:old_vim_user_home_regex = '\V\^' . escape(expand("~/.vim"), '/\')

  let s:new_runtimepath = []
  for s:current_dir in split(a:path, ",")
    if s:current_dir =~# s:old_vim_user_home_regex . '\(/after\)\*\$'
      let s:current_dir = substitute(s:current_dir, s:old_vim_user_home_regex, s:new_vim_user_home, '')
    endif
    let s:new_runtimepath = add(s:new_runtimepath, s:current_dir)
  endfor

  return join(s:new_runtimepath, ',')
endfunction


function! PhdzUpdateVimPaths()
  if empty($PEDROHDZ_VIM_USER_HOME)
    return
  endif

  let &runtimepath = PhdzCalculateNewVimPath(&runtimepath, $PEDROHDZ_VIM_USER_HOME)
  if has('packages')
    let &packpath = PhdzCalculateNewVimPath(&packpath, $PEDROHDZ_VIM_USER_HOME)
  endif
endfunction


"------------------------------------------------------------------------------
" Setup Vim
"------------------------------------------------------------------------------
call PhdzUpdateVimPaths()
runtime! config.d/*.vim
