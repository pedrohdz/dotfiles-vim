-- ----------------------------------------------------------------------------
-- https://github.com/nvim-telescope/telescope.nvim
-- ----------------------------------------------------------------------------
local action_set = require('telescope.actions.set')
local actions = require('telescope.actions')
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

local sort_buffers = function(bufnr_a, bufnr_b)
  local path_a = vim.fn.fnamemodify(
    vim.api.nvim_buf_get_name(bufnr_a),
    ':p'
  )
  local path_b = vim.fn.fnamemodify(
    vim.api.nvim_buf_get_name(bufnr_b),
    ':p'
  )
  return path_a < path_b
end

local function get_options()
  return {
    defaults = {
      sorting_strategy = 'ascending',
      vimgrep_arguments = vimgrep_arguments,

      file_ignore_patterns = {
        '^.git/',
      },
      layout_config = {
        prompt_position = 'top',
      },
      mappings = {
        i = {
          ['<C-/>'] = false,
          ['<C-_>'] = false,
          ['<C-v>'] = false,
          ['<C-x>'] = false,

          ['<M-?>'] = actions.which_key,

          -- Prompt history
          ['<C-n>'] = actions.cycle_history_next,
          ['<C-p>'] = actions.cycle_history_prev,

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
    },

    pickers = {
      buffers = {
        select_current = true,
        show_all_buffers = true,
        sort_buffers = sort_buffers,
        theme = "dropdown",

        layout_config = {
          anchor = 'N',
          width = 0.7,
        },
        mappings = {
          i = {
            ['<M-d>'] = 'delete_buffer',
          },
          n = {
            ['dd'] = 'delete_buffer',
          },
        },
        path_display = {
          'filename_first'
        },
      }
    },
  }
end

-- ----------------------------------------------------------------------------
-- Lazy
-- ----------------------------------------------------------------------------
return {
  'nvim-telescope/telescope.nvim',

  opts = get_options(),
  dependencies = {
    'nvim-lua/plenary.nvim',
  },
}
