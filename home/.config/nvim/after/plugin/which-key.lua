local builtin = require('telescope.builtin')
local phzutils = require('pedrohdz.utils')
local utils = require('telescope.utils')
local which_key = require('which-key')

which_key.setup({
  layout = {
    height = { min = 10, max = 25 }, -- min and max height of the columns
    width = { min = 20, max = 50 },  -- min and max width of the columns
    spacing = 3,                     -- spacing between columns
    align = 'left',                  -- align columns left, center or right
  },
  window = {
    border = 'single',        -- none, single, double, shadow
    position = 'top',         -- bottom, top
    margin = { 1, 1, 1, 1 },  -- extra window margin [top, right, bottom, left]
    padding = { 1, 1, 1, 1 }, -- extra window padding [top, right, bottom, left]
    winblend = 0
  },
})

which_key.register({
  d = {
    name = 'diagnostics',
    f = { vim.diagnostic.open_float, 'open-diagnostics-float' },
    o = { vim.diagnostic.setloclist, 'open-diagnostics-list' },
  },
  s = {
    name = 'Switch/toggle',
    G = { '<cmd>GitGutterToggle<CR>', 'Git gutter toggle (all buffers)' },
    d = { '<Plug>(toggle-lsp-diag)', 'LSP diag toggle (all buffers)' },
    g = { '<cmd>GitGutterBufferToggle<CR>', 'Git gutter toggle (local buffer)' },
    h = { '<cmd>GitGutterLineHighlightsToggle<CR>', 'Git gutter line highlights (local buffer)' },
    s = { '<cmd>set spell!<cr>', 'Spell checking' },
    t = { '<cmd>TroubleToggle<cr>', 'Toggle' },
    v = { '<Plug>(toggle-lsp-diag-vtext)', 'LSP diag vtext toggle (all buffers)' },
  },
  T = {
    name = 'Trouble',
    c = { '<cmd>TroubleClose<cr>', 'Close' },
    r = { '<cmd>TroubleRefresh<cr>', 'Refresh' },
    t = { '<cmd>TroubleToggle<cr>', 'Toggle' },
  },
  t = {
    name = 'Telescope',
    f = {
      name = 'Files',
      F = { builtin.git_files, 'Fuzzy search git ls-files' },
      f = { builtin.find_files, 'Files in CWD' },
      g = { builtin.grep_string, 'Grep for string under cursor in CWD' },
      l = { builtin.live_grep, 'String search in CWD' },
    },
    g = {
      name = 'Git',
      C = { builtin.git_bcommits, 'Commit diffs (buffer)' },
      S = { builtin.git_stash, 'Stash' },
      b = { builtin.git_branches, 'Branches, checkout <cr>, track <C-t>. rebase <C-r>' },
      c = { builtin.git_commits, 'Commit diffs (workspace)' },
      s = { builtin.git_status, 'Status' },
    },
    o = {
      name = 'Other',
      t = { '<cmd>TodoTelescope<cr>', 'LSP definitions' },
    },
    p = {
      name = 'Telescope pickers',
      P = { builtin.planets, 'Planets' },
      b = { builtin.builtin, 'Built-ins' },
      l = { builtin.reloader, 'Lua module reload' },
      s = { builtin.symbols, 'symbols inside data/telescope-sources/*.json' },
    },
    v = {
      name = 'Vim',
      C = { builtin.commands, 'Commands' },
      D = { builtin.colorscheme, 'Colorschemes' },
      F = { builtin.filetypes, 'Filetypes' },
      H = { builtin.highlights, 'Highlights' },
      M = { builtin.man_pages, 'Manpage' },
      O = { builtin.vim_options, 'Vim options' },
      P = { builtin.pickers, 'Previous pickers' },
      Q = { builtin.quickfixhistory, 'Quickfix history' },
      S = { builtin.spell_suggest, 'Spelling suggestions' },
      T = { builtin.tags, 'Tags' },
      a = { builtin.autocommands, 'Autocommands' },
      b = { builtin.buffers, 'Buffers' },
      c = { builtin.command_history, 'Commands history' },
      f = { builtin.current_buffer_fuzzy_find, 'Buffer live fuzzy search' },
      h = { builtin.help_tags, 'Help tags' },
      j = { builtin.jumplist, 'Jump List' },
      k = { builtin.keymaps, 'Normal mode keymappings' },
      l = { builtin.loclist, 'Locations (current window' },
      m = { builtin.marks, 'Marks' },
      o = { builtin.oldfiles, 'Previously open files' },
      p = { builtin.resume, 'Resume previous picker results' },
      q = { builtin.quickfix, 'Quickfix list' },
      r = { builtin.registers, 'Registers' },
      s = { builtin.search_history, 'Searches history' },
      t = { builtin.current_buffer_tags, 'Buffer tags' },
    },
  },
}, {
  mode = 'n',
  noremap = true,
  nowait = true,
  prefix = '<leader>',
  silent = true,
})

which_key.register({
  ['[g'] = { vim.diagnostic.goto_prev, 'goto-prev-diagnostics' },
  [']g'] = { vim.diagnostic.goto_next, 'goto-next-diagnostics' },
}, {
  mode = 'n',
  noremap = true,
  nowait = true,
  silent = true,
})


-- ----------------------------------------------------------------------------
-- Function keys
-- ----------------------------------------------------------------------------
vim.opt.pastetoggle = '<F7>'

local find_files_opts = { follow = true, hidden = true, }
which_key.register(
  {
    name = 'Function keys',
    ['<S-F1>'] = { '<cmd>Cheatsheet<cr>', 'Cheatsheet' },
    ['<F2>'] = { '<cmd>ToggleBufExplorer<cr>', 'Buffer Explorer' },
    ['<S-F2>'] = { builtin.buffers, 'Telescope Buffers' },

    -- Find Files --
    ['<F3>'] = {
      phzutils.with_cwd(builtin.find_files, find_files_opts),
      'Files, CWD'
    },
    ['<S-F3>'] = {
      phzutils.with_cwd_project_root(builtin.find_files, find_files_opts),
      'Files, CWD project root',
    },

    -- ['<F4>'] = AVAILABLE
    -- ['<S-F4>'] = AVAILABLE
    ['<F5>'] = { '<cmd>GundoToggle<cr>', 'GundoToggle' },
    ['<F6>'] = { '<cmd>YRShow<cr>', 'YRShow' },
    ['<F7>'] = 'Paste toggle',
  }, {
    mode = 'n',
    noremap = true,
    nowait = true,
    silent = true,
  }
)


-- ----------------------------------------------------------------------------
-- New custom mappings
-- ----------------------------------------------------------------------------
which_key.register({
  -- ['?'] = { '<cmd>Cheatsheet<cr>', 'Cheatsheet' },

  -- Live Grep --
  ['/'] = {
    phzutils.with_cwd(builtin.live_grep),
    'String search, CWD'
  },
  ['?'] = {
    phzutils.with_cwd_project_root(builtin.live_grep),
    'String search, CWD project root'
  },

  -- Grep Current String --
  ['*'] = {
    phzutils.with_cwd(builtin.grep_string),
    'Grep current string, CWD'
  },
  ['#'] = {
    phzutils.with_cwd_project_root(builtin.grep_string),
    'Grep current string, CWD project root'
  },

  -- ----
  -- Relative to Buffer
  -- ----
  r = {
    name = 'Relative to buffer',

    -- Find Files --
    ['<F3>'] = {
      phzutils.with_buffer_dir(builtin.find_files, find_files_opts),
      'Files, buf dir'
    },
    ['<S-F3>'] = {
      phzutils.with_buffer_project_root(builtin.find_files, find_files_opts),
      'Files, buf project root',
    },

    -- Live Grep --
    ['/'] = {
      phzutils.with_buffer_dir(builtin.live_grep),
      'String search, buf dir'
    },
    ['?'] = {
      phzutils.with_buffer_project_root(builtin.live_grep),
      'String search, buf project root'
    },

    -- Grep Current String --
    ['*'] = {
      phzutils.with_buffer_dir(builtin.grep_string),
      'Grep current string, buf dir'
    },
    ['#'] = {
      phzutils.with_buffer_project_root(builtin.grep_string),
      'Grep current string, buf project root'
    },
  }
}, {
  mode = 'n',
  noremap = true,
  nowait = true,
  prefix = '<leader>',
  silent = true,
})


-- ----------------------------------------------------------------------------
-- Other
-- ----------------------------------------------------------------------------
which_key.register({
  C = {
    name = 'clean',
    N = 'clean-vertical-whitespace',
    T = 'clean-tabs',
    W = 'clean-whitespace',
  },
  ['\\'] = { '<cmd>nohlsearch<cr>', 'Clear search highlights' }
}, { prefix = '<leader>' })
