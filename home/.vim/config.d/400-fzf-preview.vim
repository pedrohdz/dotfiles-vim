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
    f = {
      name = 'fzf',
      g = {
        name = 'Git',
        b = {"<cmd>BCommits<CR>", "git-buffer-commits"},
        c = {"<cmd>Commits<CR>", "git-project-commits"},
        f = {"<cmd>GFiles<CR>", "git-files"},
        s = {"<cmd>GFiles?<CR>", "git-status"},
      },
      s = {
        name = 'Search',
        a = {'<cmd>Ag<CR>', 'ag search result (ALT-A to select all, ALT-D to deselect all)'},
        f = {'<cmd>call _PhdzFzfProjectFiles()<CR>', 'project-files'},
        r = {'<cmd>Rg<CR>', 'rg search result (ALT-A to select all, ALT-D to deselect all)'},
      },
      v = {
        name = 'Vim',
        C = {'<cmd>Commands<CR>', 'Commands'},
        L = {'<cmd>BLines<CR>', 'Lines in the current buffer'},
        T = {'<cmd>BTags<CR>', 'Tags in the current buffer'},
        a = {'<cmd>History<CR>', 'v:oldfiles and open buffers'},
        b = {'<cmd>Buffers<CR>', 'open-buffers'},
        o = {'<cmd>Colors<CR>', 'colors'},
        c = {'<cmd>History:<CR>', 'Command history'},
        h = {'<cmd>Helptags<CR>', 'Help tags 1'},
        k = {'<cmd>Marks<CR>', 'marks'},
        l = {'<cmd>Lines<CR>', 'Lines in loaded buffers'},
        m = {'<cmd>Maps<CR>', 'normal-mode-mappings'},
        s = {'<cmd>History/<CR>', 'Search history'},
        t = {'<cmd>Filetypes<CR>', 'File types'},
        t = {'<cmd>Tags<CR>', 'Tags in the project (ctags -R)'},
        w = {'<cmd>Windows<CR>', 'Windows'},
      },
    },
  }, {
    prefix = '<leader>',
    noremap = true,
    silent = true,
  })
EOF
endif

" :Locate PATTERN 	locate command output
" :Snippets 	Snippets (UltiSnips)
