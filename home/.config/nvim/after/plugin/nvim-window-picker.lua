-- ----------------------------------------------------------------------------
-- https://github.com/s1n7ax/nvim-window-picker
-- ----------------------------------------------------------------------------
local win_picker = require('window-picker')

win_picker.setup({
  -- hint = 'floating-big-letter',
  filter_rules = {
    include_current_win = true,
  },
})
