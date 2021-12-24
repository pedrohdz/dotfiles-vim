" -----------------------------------------------------------------------------
" Public funcations
" -----------------------------------------------------------------------------
function! PhdzUpdateBuffer()
  if &diff
    call PhdzHudApplyCurrentOrSimple()
    return
  endif
  call PhdzHudApplyCurrentOrFull()
endfunction

function! PhdzHudApplyCurrentOrFull()
  call _PhdzHudApplyCurrentOrDefaultTo(_PHDZ_HUD_CONSTANT_FULL())
endfunction

function! PhdzHudApplyCurrentOrSimple()
  call _PhdzHudApplyCurrentOrDefaultTo(_PHDZ_HUD_CONSTANT_SIMPLE())
endfunction

function! PhdzHudApplyCurrentOrNone()
  call _PhdzHudApplyCurrentOrDefaultTo(_PHDZ_HUD_CONSTANT_NONE())
endfunction

function! PhdzHudToggle()
  let l:previous_state = exists("b:_phdz_hud_current_state") ? b:_phdz_hud_current_state : _PHDZ_HUD_CONSTANT_NONE()
  if l:previous_state == _PHDZ_HUD_CONSTANT_FULL()
    call PhdzHudApplySimple()
  elseif l:previous_state == _PHDZ_HUD_CONSTANT_SIMPLE()
    call PhdzHudApplyNone()
  elseif l:previous_state == _PHDZ_HUD_CONSTANT_NONE()
    call PhdzHudApplyFull()
  else
    echoerr printf("Error - Unknown HUD state of '%s', switching to '%s'.", l:previous_state, _PHDZ_HUD_CONSTANT_FULL())
    call PhdzHudApplyFull()
  endif

  echomsg printf("Changed HUD from '%s' to '%s'", l:previous_state, b:_phdz_hud_current_state)
endfunction

function! PhdzHudApplyFull()
  let b:_phdz_hud_current_state = _PHDZ_HUD_CONSTANT_FULL()
  call _PhdzTryExecute(":GitGutterEnable")
  call _PhdzTryExecute(":IndentLinesEnable")
  call _PhdzTryExecute(":ToggleDiagOn")
  setlocal list
  setlocal number
  setlocal signcolumn=yes
endfunction

function! PhdzHudApplySimple()
  let b:_phdz_hud_current_state = _PHDZ_HUD_CONSTANT_SIMPLE()
  call _PhdzTryExecute(":GitGutterDisable")
  call _PhdzTryExecute(":IndentLinesEnable")
  call _PhdzTryExecute(":ToggleDiagOff")
  setlocal list
  setlocal number
  setlocal signcolumn=no
endfunction

function! PhdzHudApplyNone()
  let b:_phdz_hud_current_state = _PHDZ_HUD_CONSTANT_NONE()
  call _PhdzTryExecute(":GitGutterDisable")
  call _PhdzTryExecute(":IndentLinesDisable")
  call _PhdzTryExecute(":ToggleDiagOff")
  setlocal nolist
  setlocal nonumber
  setlocal signcolumn=no
endfunction


" -----------------------------------------------------------------------------
" Constants
" -----------------------------------------------------------------------------
function! _PHDZ_HUD_CONSTANT_FULL()
  return "FULL"
endfunction

function! _PHDZ_HUD_CONSTANT_SIMPLE()
  return "SIMPLE"
endfunction

function! _PHDZ_HUD_CONSTANT_NONE()
  return "NONE"
endfunction


" -----------------------------------------------------------------------------
" Internal funcations
" -----------------------------------------------------------------------------
function! _PhdzHudApplyCurrentOrDefaultTo(value)
  let l:state = exists("b:_phdz_hud_current_state") ? b:_phdz_hud_current_state : a:value
  if l:state == _PHDZ_HUD_CONSTANT_FULL()
    call PhdzHudApplyFull()
  elseif l:state == _PHDZ_HUD_CONSTANT_SIMPLE()
    call PhdzHudApplySimple()
  elseif l:state == _PHDZ_HUD_CONSTANT_NONE()
    call PhdzHudApplyNone()
  else
    echoerr printf("Error - Unknown HUD state of '%s', defaulting to '%s'.", l:state, _PHDZ_HUD_CONSTANT_FULL())
    call PhdzHudApplyFull()
  endif
endfunction

function! _PhdzTryExecute(commannd)
  try
    execute a:commannd
  catch /.*/
    if has('nvim')
      echoerr printf("ERROR - Failed to execute '%s'.", a:commannd)
    endif
  endtry
endfunction


" -----------------------------------------------------------------------------
" Internal funcations
" -----------------------------------------------------------------------------
augroup phdz_hub
  autocmd!
  " autocmd BufNewFile,BufRead,BufEnter * call PhdzUpdateBuffer()
  autocmd BufNewFile,BufRead * call PhdzUpdateBuffer()
augroup END

nmap <F1>   :<C-E><C-U>call PhdzHudToggle()<CR>
