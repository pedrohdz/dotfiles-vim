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
  which_key.add({
    { '<leader>f', group = 'fzf' },
    { '<leader>fg', group = 'Git' },
    { '<leader>fgb', '<cmd>BCommits<CR>', desc = 'git-buffer-commits' },
    { '<leader>fgc', '<cmd>Commits<CR>', desc = 'git-project-commits' },
    { '<leader>fgf', '<cmd>GFiles<CR>', desc = 'git-files' },
    { '<leader>fgs', '<cmd>GFiles?<CR>', desc = 'git-status' },

    { '<leader>fs', group = 'Search' },
    { '<leader>fsa', '<cmd>Ag<CR>', desc = 'ag search result (ALT-A to select all, ALT-D to deselect all)' },
    { '<leader>fsf', '<cmd>call _PhdzFzfProjectFiles()<CR>', desc = 'project-files' },
    { '<leader>fsr', '<cmd>Rg<CR>', desc = 'rg search result (ALT-A to select all, ALT-D to deselect all)' },

    { '<leader>fv', group = 'Vim' },
    { '<leader>fvC', '<cmd>Commands<CR>', desc = 'Commands' },
    { '<leader>fvL', '<cmd>BLines<CR>', desc = 'Lines in the current buffer' },
    { '<leader>fvT', '<cmd>BTags<CR>', desc = 'Tags in the current buffer' },
    { '<leader>fva', '<cmd>History<CR>', desc = 'v:oldfiles and open buffers' },
    { '<leader>fvb', '<cmd>Buffers<CR>', desc = 'open-buffers' },
    { '<leader>fvc', '<cmd>History:<CR>', desc = 'Command history' },
    { '<leader>fvh', '<cmd>Helptags<CR>', desc = 'Help tags 1' },
    { '<leader>fvk', '<cmd>Marks<CR>', desc = 'marks' },
    { '<leader>fvl', '<cmd>Lines<CR>', desc = 'Lines in loaded buffers' },
    { '<leader>fvm', '<cmd>Maps<CR>', desc = 'normal-mode-mappings' },
    { '<leader>fvo', '<cmd>Colors<CR>', desc = 'colors' },
    { '<leader>fvs', '<cmd>History/<CR>', desc = 'Search history' },
    { '<leader>fvt', '<cmd>Tags<CR>', desc = 'Tags in the project (ctags -R)' },
    { '<leader>fvw', '<cmd>Windows<CR>', desc = 'Windows' },
  })
EOF
endif

" :Locate PATTERN 	locate command output
" :Snippets 	Snippets (UltiSnips)
