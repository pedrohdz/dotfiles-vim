-- ----------------------------------------------------------------------------
-- https://github.com/stevearc/oil.nvim
-- ----------------------------------------------------------------------------
local oil = require('oil')


-- ----------------------------------------------------------------------------
-- Helpers
-- ----------------------------------------------------------------------------
local is_always_hidden           = function(name, _)
  return (
    name:match([[~$]])
    or name:match([[^%..*%.swp$]])
    or name:match([[^%.terraform$]])
    or name:match([[^%.terraform%.lock%.hcl$]])
    or name:match([[^terraform%.tfstate$]])
    or name:match([[^terraform%.tfstate%.backup$]])
  )
end

-- Thank you:
--  - https://github.com/stevearc/oil.nvim/issues/360#issuecomment-2099555989
local window_picker              = function()
  local entry_path = vim.fn.fnamemodify(
    vim.fn.simplify(
      vim.fn.expand(oil.get_current_dir() .. oil.get_cursor_entry().parsed_name)
    ),
    ':~:.'
  )

  local window_id = require('window-picker').pick_window({
    filter_rules = {
      autoselect_one = true,
      include_current_win = true,
    },
  })

  if not window_id then
    print('Unable to pick window')
    return
  end

  oil.close()
  vim.api.nvim_set_current_win(window_id)
  vim.cmd.edit(entry_path)
end

local _actions                   = {}

_actions.help                    = {
  'actions.show_help',
  desc = 'Show help (<C-?>)'
}

_actions.select_vertical         = {
  'actions.select',
  opts = {
    close = true,
    vertical = true,
  },
  desc = 'Open in a right vertical split'
}

_actions.select_vertical_left    = {
  'actions.select',
  opts = {
    close = true,
    split = 'aboveleft',
    vertical = true,
  },
  desc = 'Open in a left vertical split'
}

_actions.select_horizontal       = {
  'actions.select',
  opts = {
    close = true,
    horizontal = true,
  },
  desc = 'Open in a lower horizontal split'
}

_actions.select_horizontal_above = {
  'actions.select',
  opts = {
    close = true,
    horizontal = true,
    split = 'aboveleft',
  },
  desc = 'Open in a upper horizontal split'
}

-- ----------------------------------------------------------------------------
-- Configure
-- ----------------------------------------------------------------------------
oil.setup({
  default_file_explorer = true,
  delete_to_trash = true,
  silence_scp_warning = true,
  skip_confirm_for_simple_edits = true,

  columns = {
    'icon',
    'type',
    'permissions',
    'size',
    'mtime',
  },
  keymaps = {
    ['<C-s>'] = false,
    ['<C-h>'] = false,
    ['g?'] = false,

    ['<M-?>'] = _actions.help,
    ['<M-p>'] = window_picker,

    ['<M-v>'] = _actions.select_vertical,
    ['<M-V>'] = _actions.select_vertical_left,
    ['<M-h>'] = _actions.select_horizontal,
    ['<M-H>'] = _actions.select_horizontal_above,
  },
  view_options = {
    show_hidden = true,
    is_always_hidden = is_always_hidden
  },
})


-- ----------------------------------------------------------------------------
-- Key maps
-- ----------------------------------------------------------------------------
vim.keymap.set('n', '-', oil.open, { desc = 'Oil reletive to buffer' })
vim.keymap.set('n', '_', function() oil.open(vim.fn.getcwd()) end, { desc = 'Oil CWD' })
