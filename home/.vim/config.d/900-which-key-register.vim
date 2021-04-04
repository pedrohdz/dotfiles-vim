nnoremap <unique> <silent> <leader> :WhichKey '\'<CR>
nnoremap <unique> <silent> <localleader> :WhichKey '<Space>'<CR>
call which_key#register('\', "g:which_key_leader_map")
call which_key#register('<Space>', "g:which_key_localleader_map")
