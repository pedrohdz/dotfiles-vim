" Turning off PowerLine while testing out AirLine
finish

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
        \'/opt/devenv/opt/python/powerline-status/lib/python3.9',
        \'/opt/devenv/opt/python/powerline-status/lib/python3.8',
        \'/opt/devenv/opt/python/powerline-status/lib/python3.7',
        \'~/.local/opt/python/powerline/lib/python3.9',
        \'~/.local/opt/python/powerline/lib/python3.8',
        \'~/.local/opt/python/powerline/lib/python3.7',
        \]
  let path = _PhdzFindPowerline(paths)

  exe 'set rtp+=' . path
endfunction

call _PhdzLoadPowerline()
