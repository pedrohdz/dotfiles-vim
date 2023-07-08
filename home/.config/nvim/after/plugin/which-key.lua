local builtin = require('telescope.builtin')
local which_key = require('which-key')

local register = require('which-key').register

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

register({
  d = {
    name = 'diagnostics',
    f = { vim.diagnostic.open_float, 'open-diagnostics-float' },
    o = { vim.diagnostic.setloclist, 'open-diagnostics-list' },
  },
  s = {
    name = 'Switch/toggle',
    G = { '<cmd>Gitsigns toggle_signs<CR>', 'Gitsigns toggle (all buffers)' },
    d = { '<Plug>(toggle-lsp-diag)', 'LSP diag toggle (all buffers)' },
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

register({
  ['[g'] = { vim.diagnostic.goto_prev, 'goto-prev-diagnostics' },
  [']g'] = { vim.diagnostic.goto_next, 'goto-next-diagnostics' },
}, {
  mode = 'n',
  noremap = true,
  nowait = true,
  silent = true,
})


-- ----------------------------------------------------------------------------
-- New custom mappings
-- ----------------------------------------------------------------------------
local find_files = require('telescope.builtin').find_files
local find_files_opts = { follow = true, hidden = true, }
local with_buffer_dir = require('pedrohdz.utils').with_buffer_dir
local with_buffer_project_root = require('pedrohdz.utils').with_buffer_project_root
local with_cwd = require('pedrohdz.utils').with_cwd
local with_cwd_project_root = require('pedrohdz.utils').with_cwd_project_root

local quick_opts = function(mode)
  return {
    mode = mode or 'n',
    noremap = true,
    nowait = true,
    silent = true,
  }
end

-- ----
-- Function keys
-- ----
vim.opt.pastetoggle = '<F7>'

register(
  {
    ['<F2>'] = { '<cmd>ToggleBufExplorer<cr>', 'Buffer Explorer' },
    ['<S-F2>'] = { builtin.buffers, 'Telescope Buffers' },
    -- ['<S-F4>'] = AVAILABLE
    ['<F5>'] = { '<cmd>GundoToggle<cr>', 'GundoToggle' },
    ['<F6>'] = { '<cmd>YRShow<cr>', 'YRShow' },
    ['<F7>'] = 'Paste toggle',
  },
  quick_opts()
)

-- ----
-- Help
-- ----
register({ ['<F1>'] = { '<cmd>WhichKey<cr>', 'WhichKey all' } }, quick_opts())
register({ ['<S-F1>'] = { builtin.keymaps, 'Telescope Vim keymaps' } }, quick_opts())

register({ ['<F1>'] = { '<cmd>WhichKey "" i<cr>', 'WhichKey INSERT' } }, quick_opts('i'))
register({ ['<F1>'] = { '<cmd>WhichKey "" v<cr>', 'WhichKey VISUAL' } }, quick_opts('v'))

register({ ['<leader><F1>'] = { '<cmd>WhichKey <leader><cr>', 'WhichKey <leader> all' } }, quick_opts())
register({ ['<leader><F1>'] = { '<cmd>WhichKey <leader> v<cr>', 'WhichKey <leader> VISUAL' } }, quick_opts('v'))

register({ ['<localleader><F1>'] = { '<cmd>WhichKey <localleader><cr>', 'WhichKey <localleader> all' } }, quick_opts())
register({ ['<localleader><F1>'] = { '<cmd>WhichKey <localleader> v<cr>', 'WhichKey <localleader> VISUAL' } },
  quick_opts('v'))

-- ----
-- Common WhichKey names
-- ----
register({ ['<leader>r'] = { name = 'Relative to buffer' } })

-- ----
-- Find Files
-- ----
register({
    ['<F3>'] = { with_cwd(find_files, find_files_opts), 'Files, CWD' },
    ['<S-F3>'] = { with_cwd_project_root(find_files, find_files_opts), 'Files, CWD project root', },

    -- Relative to Buffer --
    ['<leader>r<F3>'] = { with_buffer_dir(find_files, find_files_opts), 'Files, buf dir' },
    ['<leader>r<S-F3>'] = { with_buffer_project_root(find_files, find_files_opts), 'Files, buf project root', },
  },
  quick_opts()
)

-- ----
-- Find Strings
-- ----
register({
  -- ['?'] = { '<cmd>Cheatsheet<cr>', 'Cheatsheet' },

  -- ----
  -- Live Grep
  -- ----
  ['/'] = { with_cwd(builtin.live_grep), 'String search, CWD' },
  ['?'] = { with_cwd_project_root(builtin.live_grep), 'String search, CWD project root' },

  -- Relative to Buffer --
  ['r/'] = { with_buffer_dir(builtin.live_grep), 'String search, buf dir' },
  ['r?'] = { with_buffer_project_root(builtin.live_grep), 'String search, buf project root' },

  -- ----
  -- Grep Current String --
  -- ----
  ['*'] = { with_cwd(builtin.grep_string), 'Grep current string, CWD' },
  ['#'] = { with_cwd_project_root(builtin.grep_string), 'Grep current string, CWD project root' },

  -- Relative to Buffer --
  ['r*'] = { with_buffer_dir(builtin.grep_string), 'Grep current string, buf dir' },
  ['r#'] = { with_buffer_project_root(builtin.grep_string), 'Grep current string, buf project root' },
}, {
  mode = 'n',
  noremap = true,
  nowait = true,
  prefix = '<leader>',
  silent = true,
})


-- ----
-- Trouble
-- ----
local trouble = require("trouble")
local trouble_func = function(func)
  return function()
    func({skip_groups = true, jump = true})
  end
end

register(
  {
    [']r'] = { trouble_func(trouble.next), 'Trouble - next' },
    [']R'] = { trouble_func(trouble.last), 'Trouble - last' },
    ['[r'] = { trouble_func(trouble.previous), 'Trouble - back' },
    ['[R'] = { trouble_func(trouble.first), 'Trouble - first' },
  },
  quick_opts()
)


-- ----------------------------------------------------------------------------
-- Other
-- ----------------------------------------------------------------------------
register({
  C = {
    name = 'clean',
    N = 'clean-vertical-whitespace',
    T = 'clean-tabs',
    W = 'clean-whitespace',
  },
  ['\\'] = { '<cmd>nohlsearch<cr>', 'Clear search highlights' }
}, { prefix = '<leader>' })
