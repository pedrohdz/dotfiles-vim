-- ----------------------------------------------------------------------------
-- https://github.com/stevearc/oil.nvim
-- ----------------------------------------------------------------------------
local oil = require('oil')

-- TODO - Nice to have: Would be nice to get this to work with window-picker.
--  - https://github.com/stevearc/oil.nvim/issues/360#issuecomment-2099555989
--
-- local smart_split = function()
--   local entry = oil.get_cursor_entry()
--   local dir = oil.get_current_dir()
--   -- local current_window_id = vim.api.nvim_get_current_win()
--   local picked_window_id = require('window-picker').pick_window({
--     filter_rules = { include_current_win = false },
--   })
--
--   if picked_window_id == nil then
--     oil.close()
--     vim.cmd(string.format('vsplit %s/%s', dir, entry.name))
--   end
--   -- oil.select()
--   -- print(vim.inspect(entry))
--   -- print(dir)
--   -- print(picked_window_id)
-- end

oil.setup({
  default_file_explorer = true,
  delete_to_trash = true,
  silence_scp_warning = true,
  skip_confirm_for_simple_edits = true,
  keymaps = {
    ["<C-s>"] = {
      "actions.select",
      opts = {
        close = true,
        vertical = true,
      },
      desc = "Open the entry in a vertical split"
    },
    -- ["<C-f>"] = {
    --   smart_split
    -- }
  },
  view_options = {
    show_hidden = true,
    is_always_hidden = function(name, _)
      return (
        name:match([[~$]])
        or name:match([[^%..*%.swp$]])
        or name:match([[^%.terraform$]])
        or name:match([[^%.terraform%.lock%.hcl$]])
        or name:match([[^terraform%.tfstate$]])
        or name:match([[^terraform%.tfstate%.backup$]])
      )
    end
  },
})
