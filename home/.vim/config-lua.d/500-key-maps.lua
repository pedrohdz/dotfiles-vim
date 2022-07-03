local which_key = require('which-key')
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
    v = {'<Plug>(toggle-lsp-diag-vtext)', 'LSP diag vtext toggle (all buffers)'},
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
