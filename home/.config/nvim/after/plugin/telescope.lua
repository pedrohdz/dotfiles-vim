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

-- Thank you:
--   - https://github.com/nvim-telescope/telescope.nvim/wiki/Configuration-Recipes#using-nvim-window-picker-to-choose-a-target-window-when-opening-a-file-from-any-picker
local function window_picker(prompt_bufnr)
  -- Use nvim-window-picker to choose the window by dynamically attaching a function
  local action_set = require('telescope.actions.set')
  local action_state = require('telescope.actions.state')

  local picker = action_state.get_current_picker(prompt_bufnr)
  picker.get_selection_window = function(picker, entry)
    local picked_window_id = require('window-picker').pick_window() or vim.api.nvim_get_current_win()
    -- Unbind after using so next instance of the picker acts normally
    picker.get_selection_window = nil
    return picked_window_id
  end

  return action_set.edit(prompt_bufnr, 'edit')
end

telescope.setup({
  defaults = {
    mappings = {
      i = {
        ['<C-g>'] = window_picker,
        ['<C-o>'] = trouble.open,
      },
      n = {
        ['<C-g>'] = window_picker,
        ['<C-o>'] = trouble.open
      },
    },
    vimgrep_arguments = vimgrep_arguments,
    file_ignore_patterns = {
      '^.git/',
    }
  },
})
