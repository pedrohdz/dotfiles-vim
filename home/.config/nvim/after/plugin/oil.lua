-- ----------------------------------------------------------------------------
-- https://github.com/stevearc/oil.nvim
-- ----------------------------------------------------------------------------
local oil = require('oil')

oil.setup({
  default_file_explorer = true,
  delete_to_trash = true,
  silence_scp_warning = true,
  skip_confirm_for_simple_edits = true,
  view_options = {
    show_hidden = true,
  },
})
