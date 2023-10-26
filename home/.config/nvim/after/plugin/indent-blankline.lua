-- require('indent_blankline').setup {
--   char = '┊',
--   space_char_blankline = ' ',
--   show_current_context = true,
--   show_current_context_start = true,
--   use_treesitter = true,
-- }

-- FIXME - Update v3 scope settings like v2 context settings.
require('ibl').setup({
  indent = {
    char = '┊',
    smart_indent_cap = true,
  },
  scope = {
    enabled = true,
    include = {
      node_type = { ['*'] = {'*'}, },
    },
  },
})
