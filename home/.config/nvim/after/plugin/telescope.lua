-- ----------------------------------------------------------------------------
-- https://github.com/nvim-telescope/telescope.nvim
-- ----------------------------------------------------------------------------
local trouble = require('trouble.sources.telescope')
local telescope = require('telescope')

local vimgrep_arguments = {
  'rg',
  '--color=never',
  '--column',
  '--hidden',
  '--line-number',
  '--no-heading',
  '--smart-case',
  '--with-filename',
}

telescope.setup {
  defaults = {
    mappings = {
      i = { ['<c-o>'] = trouble.open },
      n = { ['<c-o>'] = trouble.open },
    },
    vimgrep_arguments = vimgrep_arguments,
    file_ignore_patterns = {
      '^.git/',
    }
  },
}
