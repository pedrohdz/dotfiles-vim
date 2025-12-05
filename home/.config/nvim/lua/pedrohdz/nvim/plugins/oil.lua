local is_always_hidden = function(name, _)
  return (
    name:match([[~$]])
    or name:match([[^%..*%.swp$]])
    or name:match([[^%.terraform$]])
    or name:match([[^%.terraform%.lock%.hcl$]])
    or name:match([[^terraform%.tfstate$]])
    or name:match([[^terraform%.tfstate%.backup$]])
  )
end

local window_picker = function()
  local oil = require('oil')
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

return {
  'stevearc/oil.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  opts = {
    default_file_explorer = true,
    delete_to_trash = true,
    silence_scp_warning = true,
    skip_confirm_for_simple_edits = true,
    columns = { 'icon' },
    keymaps = {
      ['<C-s>'] = false,
      ['<C-h>'] = false,
      ['g?'] = false,
      ['<M-?>'] = { 'actions.show_help', desc = 'Show help (<C-?>)' },
      ['<M-p>'] = window_picker,
      ['<M-v>'] = { 'actions.select', opts = { close = true, vertical = true }, desc = 'Open in a right vertical split' },
      ['<M-V>'] = { 'actions.select', opts = { close = true, split = 'aboveleft', vertical = true }, desc = 'Open in a left vertical split' },
      ['<M-h>'] = { 'actions.select', opts = { close = true, horizontal = true }, desc = 'Open in a lower horizontal split' },
      ['<M-H>'] = { 'actions.select', opts = { close = true, horizontal = true, split = 'aboveleft' }, desc = 'Open in an upper horizontal split' },
    },
    view_options = {
      show_hidden = true,
      is_always_hidden = is_always_hidden,
    },
  },
}
