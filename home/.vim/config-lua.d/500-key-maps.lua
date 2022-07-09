local which_key = require('which-key')
local builtin = require('telescope.builtin')

which_key.register({
  d = {
    name = 'diagnostics',
    f = { vim.diagnostic.open_float, 'open-diagnostics-float' },
    o = { vim.diagnostic.setloclist, 'open-diagnostics-list' },
  },
  s = {
    name = 'Switch/toggle',
    G = {'<cmd>GitGutterToggle<CR>', 'Git gutter toggle (all buffers)'},
    d = {'<Plug>(toggle-lsp-diag)', 'LSP diag toggle (all buffers)'},
    g = {'<cmd>GitGutterBufferToggle<CR>', 'Git gutter toggle (local buffer)'},
    h = {'<cmd>GitGutterLineHighlightsToggle<CR>', 'Git gutter line highlights (local buffer)'},
    s = 'Spell checking',
    t = {'<cmd>TroubleToggle<cr>', 'Toggle'},
    v = {'<Plug>(toggle-lsp-diag-vtext)', 'LSP diag vtext toggle (all buffers)'},
  },
  T = {
    name = 'Trouble',
    c = {'<cmd>TroubleClose<cr>', 'Close'},
    r = {'<cmd>TroubleRefresh<cr>', 'Refresh'},
    t = {'<cmd>TroubleToggle<cr>', 'Toggle'},
  },
  t = {
    name = 'Telescope',
    f = {
      name = 'Files',
      F = {builtin.git_files, 'Fuzzy search git ls-files'},
      f = {builtin.find_files, 'Files in CWD'},
      g = {builtin.grep_string, 'Grep for string under cursor in CWD'},
      l = {builtin.live_grep, 'String search in CWD'},
    },
    g = {
      name = 'Git',
      C = {builtin.git_bcommits, 'Commit diffs (buffer)'},
      S = {builtin.git_stash, 'Stash'},
      b = {builtin.git_branches, 'Branches, checkout <cr>, track <C-t>. rebase <C-r>'},
      c = {builtin.git_commits, 'Commit diffs (workspace)'},
      s = {builtin.git_status, 'Status'},
    },
    o = {
      name = 'Other',
      t = {'<cmd>TodoTelescope<cr>', 'LSP definitions'},
    },
    p = {
      name = 'Telescope pickers',
      P = {builtin.planets, 'Planets'},
      b = {builtin.builtin, 'Built-ins'},
      l = {builtin.reloader, 'Lua module reload'},
      s = {builtin.symbols, 'symbols inside data/telescope-sources/*.json'},
    },
    v = {
      name = 'Vim',
      C = {builtin.commands, 'Commands'},
      D = {builtin.colorscheme, 'Colorschemes'},
      F = {builtin.filetypes, 'Filetypes'},
      H = {builtin.highlights, 'Highlights'},
      M = {builtin.man_pages, 'Manpage'},
      O = {builtin.vim_options, 'Vim options'},
      P = {builtin.pickers, 'Previous pickers'},
      Q = {builtin.quickfixhistory, 'Quickfix history'},
      S = {builtin.spell_suggest, 'Spelling suggestions'},
      T = {builtin.tags, 'Tags'},
      a = {builtin.autocommands, 'Autocommands'},
      b = {builtin.buffers, 'Buffers'},
      c = {builtin.command_history, 'Commands history'},
      f = {builtin.current_buffer_fuzzy_find, 'Buffer live fuzzy search'},
      h = {builtin.help_tags, 'Help tags'},
      j = {builtin.jumplist, 'Jump List'},
      k = {builtin.keymaps, 'Normal mode keymappings'},
      l = {builtin.loclist, 'Locations (current window'},
      m = {builtin.marks, 'Marks'},
      o = {builtin.oldfiles, 'Previously open files'},
      p = {builtin.resume, 'Resume previous picker results'},
      q = {builtin.quickfix, 'Quickfix list'},
      r = {builtin.registers, 'Registers'},
      s = {builtin.search_history, 'Searches history'},
      t = {builtin.current_buffer_tags, 'Buffer tags'},
    },
  },
}, {
  prefix = '<leader>',
  noremap = true,
  silent = true,
})

which_key.register({
  ['[g'] = { vim.diagnostic.goto_prev, 'goto-prev-diagnostics' },
  [']g'] = { vim.diagnostic.goto_next, 'goto-next-diagnostics' },
}, {
  noremap = true,
  silent = true,
})
