function _PhdzFindPowerline(pathes)
  for item in a:pathes
    let expanded = expand(item . '/site-packages/powerline/bindings/vim')
    if isdirectory(expanded)
      return expanded
    endif
  endfor
  return ''
endfunction

function _PhdzLoadPowerline()
  let paths = [
        \'~/.local/opt/python/powerline/lib/python3.7',
        \'~/.local/opt/python/powerline/lib/python3.8'
        \]
  let path = _PhdzFindPowerline(paths)

  exe 'set rtp+=' . path
endfunction

call _PhdzLoadPowerline()
