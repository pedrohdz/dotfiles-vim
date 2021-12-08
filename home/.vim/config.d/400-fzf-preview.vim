




" nnoremap <unique> <silent> <Leader>f*     :<C-u>CocCommand fzf-preview.Lines --add-fzf-arg=--no-sort --add-fzf-arg=--query="'<C-r>=expand('<cword>')<CR>"<CR>
" nnoremap <unique> <silent> <Leader>f/     :<C-u>CocCommand fzf-preview.Lines --add-fzf-arg=--no-sort --add-fzf-arg=--query="'"<CR>
" nnoremap <unique> <silent> <Leader>f<C-o> :<C-u>CocCommand fzf-preview.Jumps<CR>
" nnoremap <unique> <silent> <Leader>fl     :<C-u>CocCommand fzf-preview.LocationList<CR>
" nnoremap <unique> <silent> <Leader>fo     :<C-u>CocCommand fzf-preview.FromResources buffer project_mru<CR>
" nnoremap <unique> <silent> <Leader>fp     :<C-u>CocCommand fzf-preview.FromResources project_mru git<CR>
" nnoremap <unique> <silent> <Leader>fq     :<C-u>CocCommand fzf-preview.QuickFix<CR>
" nnoremap <unique> <silent> <Leader>ft     :<C-u>CocCommand fzf-preview.BufferTags<CR>
"
" nnoremap <unique>          <Leader>fG     :<C-u>CocCommand fzf-preview.ProjectGrep<Space>
" xnoremap <unique>          <Leader>fG     "sy:CocCommand   fzf-preview.ProjectGrep<Space>-F<Space>"<C-r>=substitute(substitute(@s, '\n', '', 'g'), '/', '\\/', 'g')<CR>"

let g:which_key_leader_map.f = {
    \ 'name' : '+fzf',
    \ 'b'    : [':Buffers', 'open-buffers'],
    \ 'G'    : 'fzf-grep',
\ }


" :Rg [PATTERN] 	rg search result (ALT-A to select all, ALT-D to deselect all)
" :Colors 	Color schemes
" :Maps 	Normal mode mappings


" :Files [PATH] 	Files (runs $FZF_DEFAULT_COMMAND if defined)
" :GFiles [OPTS] 	Git files (git ls-files)
" :GFiles? 	Git files (git status)
" :Ag [PATTERN] 	ag search result (ALT-A to select all, ALT-D to deselect all)
" :Lines [QUERY] 	Lines in loaded buffers
" :BLines [QUERY] 	Lines in the current buffer
" :Tags [QUERY] 	Tags in the project (ctags -R)
" :BTags [QUERY] 	Tags in the current buffer
" :Marks 	Marks
" :Windows 	Windows
" :Locate PATTERN 	locate command output
" :History 	v:oldfiles and open buffers
" :History: 	Command history
" :History/ 	Search history
" :Snippets 	Snippets (UltiSnips)
" :Commits 	Git commits (requires fugitive.vim)
" :BCommits 	Git commits for the current buffer; visual-select lines to track changes in the range
" :Commands 	Commands
" :Helptags 	Help tags 1
" :Filetypes 	File types



"------------------------------------------------------------------------------
" Git
"------------------------------------------------------------------------------
" nnoremap <unique> <silent> <Leader>fga    :<C-u>CocCommand fzf-preview.GitActions<CR>
" nnoremap <unique> <silent> <Leader>fgc    :<C-u>CocCommand fzf-preview.Changes<CR>
" nnoremap <unique> <silent> <Leader>fgs    :<C-u>CocCommand fzf-preview.GitStatus<CR>

let g:which_key_leader_map.f.g = {
    \ 'name' : '+git',
    \ 'a' : 'fzf-git-actions',
    \ 's' : 'fzf-git-changes',
    \ 'c' : 'fzf-git-status',
\ }
