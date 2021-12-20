" FIXME
augroup git_gutter
  autocmd!
  autocmd BufRead * GitGutterLineNrHighlightsEnable
augroup end

if exists('g:toggle_lsp_diagnostics_loaded_install')
lua <<EOF
require'toggle_lsp_diagnostics'.init()
EOF
endif

function _PhdzFindProjectRoot ()
  return finddir('.git/..', expand('%:p:h').';')
endfunction

function _PhdzFzfProjectFiles ()
  execute ":Files " . _PhdzFindProjectRoot()
endfunction


let g:which_key_leader_map.a = {
    \ 'name' : '+all-buffers',
    \ 'd'    : ['<Plug>(toggle-lsp-diag)', 'lsp-diag-toggle'],
    \ 'g'    : [':GitGutterToggle', 'git-gutter-toggle'],
    \ 'v'    : ['<Plug>(toggle-lsp-diag-vtext)', 'lsp-diag-vtext-toggle'],
\ }

let g:which_key_leader_map.b = {
    \ 'name' : '+buffer',
    \ 'g'    : [':GitGutterBufferToggle', 'git-gutter-toggle'],
    \ 'h'    : [':GitGutterLineHighlightsToggle', 'git-gutter-line-highlights'],
\ }

let g:which_key_leader_map.f = {
    \ 'name' : '+fzf',
    \ 'f'    : ['_PhdzFzfProjectFiles()', 'project-files'],
\ }

let g:which_key_leader_map.g = {
    \ 'name' : '+git',
    \ 'b' : [":BCommits", "fzf-git-buffer-commits"],
    \ 'c' : [":Commits", "fzf-git-project-commits"],
    \ 'f' : [":GFiles", "fzf-git-files"],
    \ 's' : [":GFiles?", "fzf-git-status"],
\ }

let g:which_key_leader_map.v = {
    \ 'name' : '+vim',
    \ 'b'    : [':Buffers', 'fzf-open-buffers'],
    \ 'c'    : [':Colors', 'fzf-colors'],
    \ 'k'    : [':Marks', 'fzf-marks'],
    \ 'm'    : [':Maps', 'fzf-normal-mode-mappings'],
\ }

" :Rg [PATTERN] 	rg search result (ALT-A to select all, ALT-D to deselect all)
" :Ag [PATTERN] 	ag search result (ALT-A to select all, ALT-D to deselect all)



" :Lines [QUERY] 	Lines in loaded buffers
" :BLines [QUERY] 	Lines in the current buffer
" :Tags [QUERY] 	Tags in the project (ctags -R)
" :BTags [QUERY] 	Tags in the current buffer
" :Windows 	Windows
" :Locate PATTERN 	locate command output
" :History 	v:oldfiles and open buffers
" :History: 	Command history
" :History/ 	Search history
" :Snippets 	Snippets (UltiSnips)
" :Commands 	Commands
" :Helptags 	Help tags 1
" :Filetypes 	File types
