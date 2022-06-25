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

if has('nvim')
lua << EOF
  local which_key = require('which-key')
  which_key.register({
    a = {
      name = 'all-buffers',
      d = {'<Plug>(toggle-lsp-diag)', 'lsp-diag-toggle'},
      g = {'<cmd>GitGutterToggle<CR>', 'git-gutter-toggle'},
      v = {'<Plug>(toggle-lsp-diag-vtext)', 'lsp-diag-vtext-toggle'},
    },
    b = {
      name = 'buffer',
      g = {'<cmd>GitGutterBufferToggle<CR>', 'git-gutter-toggle'},
      h = {'<cmd>GitGutterLineHighlightsToggle<CR>', 'git-gutter-line-highlights'},
    },
    f = {
      name = 'fzf',
      f = {'<cmd>call _PhdzFzfProjectFiles()<CR>', 'project-files'},
    },
    g = {
      name = 'git',
      b = {"<cmd>BCommits<CR>", "fzf-git-buffer-commits"},
      c = {"<cmd>Commits<CR>", "fzf-git-project-commits"},
      f = {"<cmd>GFiles<CR>", "fzf-git-files"},
      s = {"<cmd>GFiles?<CR>", "fzf-git-status"},
    },
    v = {
      name = 'vim',
      b = {'<cmd>Buffers<CR>', 'fzf-open-buffers'},
      c = {'<cmd>Colors<CR>', 'fzf-colors'},
      k = {'<cmd>Marks<CR>', 'fzf-marks'},
      m = {'<cmd>Maps<CR>', 'fzf-normal-mode-mappings'},
    },
  }, { prefix = '<leader>' })
EOF
endif

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
