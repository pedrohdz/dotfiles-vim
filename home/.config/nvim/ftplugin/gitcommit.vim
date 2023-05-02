" Enable spellchecking
if has('spell')
  setlocal spell
endif

" Automatically wrap at 72 characters
setlocal textwidth=72

" Add the ticket number to the commit
if match(getline(1), '^\s*$') != -1
  let ticket = matchstr(system('git rev-parse --abbrev-ref HEAD'), '\u\+-\d\+')
  if len(ticket) > 0
    call setline(1, printf(' %s', ticket))
  endif
endif

" Goto the to top of the buffer
call setpos('.', [0, 1, 1, 0])
