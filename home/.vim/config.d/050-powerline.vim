if has('nvim')
  finish
endif

function _PhdzGetPowerlineVimPath()
  let l:powerlined_cmd  = "powerline-daemon"
  let l:powerlined_cmd_path = ""

  for l:current_dir in split($PATH, ":")
    let l:current_path = resolve(expand(l:current_dir . "/" . l:powerlined_cmd))
    if filereadable(l:current_path)
      let l:powerlined_cmd_path = l:current_path
      break
    endif
  endfor
  
  if empty(l:powerlined_cmd_path)
    return
  endif

  let l:py_dir = fnamemodify(l:powerlined_cmd_path, ":h:h")
  let l:powerline_vim_dirs = globpath(l:py_dir, "lib/*/site-packages/powerline/bindings/vim", 0, 1)

  if len(l:powerline_vim_dirs) != 1
    return
  endif

  return l:powerline_vim_dirs[0]
endfunction


function _PhdzTryToAppendPowerlinePathToRtp()
  let l:path = _PhdzGetPowerlineVimPath()
  if len(l:path) > 0
    exe 'set rtp+=' . l:path
  endif
endfunction

call _PhdzTryToAppendPowerlinePathToRtp()
