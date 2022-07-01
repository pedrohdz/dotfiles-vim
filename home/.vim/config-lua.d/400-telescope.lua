-- ----------------------------------------------------------------------------
-- https://github.com/nvim-telescope/telescope.nvim
-- ----------------------------------------------------------------------------
local which_key = require('which-key')
local telescope = require('telescope.builtin')

which_key.register({
  t = {
    name = 'Telescope',
    b = {telescope.buffers, 'Vim buffers'},
    f = {telescope.find_files, 'Find files'},
    g = {telescope.live_grep, 'Search for a string in your current working directory'},
    h = {telescope.help_tags, 'Vim help tags'},
    t = {telescope.builtin, 'Built-in pickers'},
    v = {
      name = 'Vim',
      a = 'hello',
      b = 'hello',
      c = {telescope.buffers, 'foo'},
    }
  },
}, {
  prefix = '<leader>',
  noremap = true,
  silent = true,
})
