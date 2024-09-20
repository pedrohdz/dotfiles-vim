-- ----------------------------------------------------------------------------
-- https://github.com/nvim-telescope/telescope.nvim
-- ----------------------------------------------------------------------------
local action_set = require('telescope.actions.set')
local actions = require('telescope.actions')
local telescope = require('telescope')
local transform_mod = require('telescope.actions.mt').transform_mod
local trouble = require('trouble.sources.telescope')


-- ----------------------------------------------------------------------------
-- Custom actions
-- ----------------------------------------------------------------------------
local _actions = {}

-- Thank you:
--   - https://github.com/nvim-telescope/telescope.nvim/wiki/Configuration-Recipes#using-nvim-window-picker-to-choose-a-target-window-when-opening-a-file-from-any-picker
_actions.window_picker = function(prompt_bufnr)
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

_actions.select_horizontal_above = function(prompt_bufnr)
  return action_set.edit(prompt_bufnr, 'leftabove new')
end

_actions.select_vertical_left = function(prompt_bufnr)
  return action_set.edit(prompt_bufnr, 'leftabove vnew')
end

_actions.open_with_trouble = function(prompt_bufnr, opts)
  return trouble.open(prompt_bufnr, opts)
end

_actions = transform_mod(_actions)


-- ----------------------------------------------------------------------------
-- Configure Telescope
-- ----------------------------------------------------------------------------
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

telescope.setup({
  defaults = {
    mappings = {
      i = {
        ['<C-/>'] = false,
        ['<C-_>'] = false,
        ['<C-v>'] = false,
        ['<C-x>'] = false,

        ['<M-?>'] = actions.which_key,

        -- New windows --
        ['<M-v>'] = actions.select_vertical,
        ['<M-V>'] = _actions.select_vertical_left,
        ['<M-h>'] = actions.select_horizontal,
        ['<M-H>'] = _actions.select_horizontal_above,

        -- Other --
        ['<M-p>'] = _actions.window_picker,
        ['<M-t>'] = _actions.open_with_trouble,
      },
      n = {
        ['<C-v>'] = false,
        ['<C-x>'] = false,
        ['<esc>'] = false,
        ['?'] = false,

        ['<C-c>'] = actions.close,
        ['<M-?>'] = actions.which_key,

        -- New windows --
        ['<M-v>'] = actions.select_vertical,
        ['<M-V>'] = _actions.select_vertical_left,
        ['<M-h>'] = actions.select_horizontal,
        ['<M-H>'] = _actions.select_horizontal_above,

        -- Other --
        ['<M-p>'] = _actions.window_picker,
        ['<M-t>'] = _actions.open_with_trouble,
      },
    },
    vimgrep_arguments = vimgrep_arguments,
    file_ignore_patterns = {
      '^.git/',
    }
  },
  pickers = {
    buffers = {
      show_all_buffers = true,
      previewer = true,
      mappings = {
        i = {
          ['<M-d>'] = 'delete_buffer',
        },
        n = {
          ['dd'] = 'delete_buffer',
        },
      }
    }
  },
})
