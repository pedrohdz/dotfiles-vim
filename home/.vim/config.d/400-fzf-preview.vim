nnoremap <unique> <silent> <Leader>f*     :<C-u>CocCommand fzf-preview.Lines --add-fzf-arg=--no-sort --add-fzf-arg=--query="'<C-r>=expand('<cword>')<CR>"<CR>
nnoremap <unique> <silent> <Leader>f/     :<C-u>CocCommand fzf-preview.Lines --add-fzf-arg=--no-sort --add-fzf-arg=--query="'"<CR>
nnoremap <unique> <silent> <Leader>f<C-o> :<C-u>CocCommand fzf-preview.Jumps<CR>
nnoremap <unique> <silent> <Leader>fB     :<C-u>CocCommand fzf-preview.AllBuffers<CR>
nnoremap <unique> <silent> <Leader>fb     :<C-u>CocCommand fzf-preview.Buffers<CR>
nnoremap <unique> <silent> <Leader>fl     :<C-u>CocCommand fzf-preview.LocationList<CR>
nnoremap <unique> <silent> <Leader>fo     :<C-u>CocCommand fzf-preview.FromResources buffer project_mru<CR>
nnoremap <unique> <silent> <Leader>fp     :<C-u>CocCommand fzf-preview.FromResources project_mru git<CR>
nnoremap <unique> <silent> <Leader>fq     :<C-u>CocCommand fzf-preview.QuickFix<CR>
nnoremap <unique> <silent> <Leader>ft     :<C-u>CocCommand fzf-preview.BufferTags<CR>

nnoremap <unique>          <Leader>fG     :<C-u>CocCommand fzf-preview.ProjectGrep<Space>
xnoremap <unique>          <Leader>fG     "sy:CocCommand   fzf-preview.ProjectGrep<Space>-F<Space>"<C-r>=substitute(substitute(@s, '\n', '', 'g'), '/', '\\/', 'g')<CR>"

let g:which_key_leader_map.f = {
    \ 'name' : '+fzf',
    \ 'G'    : 'fzf-grep',
\ }


"------------------------------------------------------------------------------
" Git
"------------------------------------------------------------------------------
nnoremap <unique> <silent> <Leader>fga    :<C-u>CocCommand fzf-preview.GitActions<CR>
nnoremap <unique> <silent> <Leader>fgc    :<C-u>CocCommand fzf-preview.Changes<CR>
nnoremap <unique> <silent> <Leader>fgs    :<C-u>CocCommand fzf-preview.GitStatus<CR>

let g:which_key_leader_map.f.g = {
    \ 'name' : '+git',
    \ 'a' : 'fzf-git-actions',
    \ 's' : 'fzf-git-changes',
    \ 'c' : 'fzf-git-status',
\ }
