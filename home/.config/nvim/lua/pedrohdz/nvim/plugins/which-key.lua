-- More information:
--   https://github.com/folke/which-key.nvim

-- ----------------------------------------------------------------------------
-- Configuration
-- ----------------------------------------------------------------------------
local configuration = function()
  local builtin = require('telescope.builtin')
  local which_key = require('which-key')

  which_key.setup({
    layout = {
      -- width = { min = 20, max = 50 },  -- min and max width of the columns
      spacing = 3, -- spacing between columns
    },
    win = {
      border = 'single', -- none, single, double, shadow
      title = true,
      title_pos = 'center',
    },
  })

  -- --------------------------------------------------------------------------
  -- New custom mappings
  -- --------------------------------------------------------------------------
  -- ----
  -- Function keys
  -- ----
  which_key.add({
    { '<F2>',   builtin.buffers,              desc = 'Telescope Buffers' },
    { '<S-F2>', '<cmd>ToggleBufExplorer<cr>', desc = 'Buffer Explorer' }, -- FIXME - Broken
    -- quick_map({ '<S-F4>', '', desc = '' }),
    { '<F5>',   '<cmd>GundoToggle<cr>',       desc = 'GundoToggle' },
    { '<F6>',   '<cmd>YRShow<cr>',            desc = 'YRShow' },
    { '<F7>',   desc = 'Paste toggle' },
  })

  -- ----
  -- Help
  -- ----
  local which_key_help = function(mode, keys)
    return function()
      which_key.show({ mode = mode, keys = keys })
    end
  end

  which_key.add({
    { '<F1>',   which_key_help('n', ''), desc = 'WhichKey NORMAL' },
    { '<S-F1>', builtin.keymaps,         desc = 'Telescope Vim keymaps' }, -- FIXME - Broken
    { '<F1>',   which_key_help('i', ''), desc = 'WhichKey INSERT',      mode = 'i' },
    { '<F1>',   which_key_help('v', ''), desc = 'WhichKey VISUAL',      mode = 'v' },
  })

  -- ----
  -- Common WhichKey names
  -- ----
  which_key.add({ { '<leader>r', group = 'Relative to buffer' } })

  -- ----
  -- Find Files
  -- ----
  local find_files = require('telescope.builtin').find_files
  local find_files_opts = { follow = true, hidden = true, }
  local with_buffer_dir = require('pedrohdz.utils').with_buffer_dir
  local with_buffer_project_root = require('pedrohdz.utils').with_buffer_project_root
  local with_cwd = require('pedrohdz.utils').with_cwd
  local with_cwd_project_root = require('pedrohdz.utils').with_cwd_project_root
  local nvtree = require("nvim-tree.api").tree

  which_key.add({
    { '<F3>',            with_cwd_project_root(find_files, find_files_opts),    desc = 'Files, CWD project root' },
    { '<S-F3>',          with_cwd(find_files, find_files_opts),                 desc = 'Files, CWD' },
    { '<F4>',            with_cwd_project_root(nvtree.toggle, {}),              desc = 'nvim-tree, CWD project root' },
    { '<S-F4>',          with_cwd(nvtree.toggle, {}),                           desc = 'nvim-tree, CWD' },

    -- Relative to Buffer --
    { '<leader>r<F3>',   with_buffer_dir(find_files, find_files_opts),          desc = 'Files, buf dir' },
    { '<leader>r<F4>',   with_buffer_dir(nvtree.toggle, {}),                    desc = 'nvim-tree, buf dir' },

    -- TODO - Not working
    { '<leader>r<S-F3>', with_buffer_project_root(find_files, find_files_opts), desc = 'Files, buf project root' },
    { '<leader>r<S-F4>', with_buffer_project_root(nvtree.toggle, {}),           desc = 'nvim-tree, buf project root' },
  })

  -- ----
  -- Find Strings
  -- ----
  which_key.add({
    -- { '?',  '<cmd>Cheatsheet<cr>', desc = 'Cheatsheet' },

    -- ----
    -- Live Grep
    -- ----
    { '<leader>/',  with_cwd(builtin.live_grep),                   desc = 'String search, CWD' },
    { '<leader>?',  with_cwd_project_root(builtin.live_grep),      desc = 'String search, CWD project root' },

    -- Relative to Buffer --
    { '<leader>r/', with_buffer_dir(builtin.live_grep),            desc = 'String search, buf dir' },
    { '<leader>r?', with_buffer_project_root(builtin.live_grep),   desc = 'String search, buf project root' },

    -- ----
    -- Grep Current String --
    -- ----
    { '<leader>*',  with_cwd(builtin.grep_string),                 desc = 'Grep current string, CWD' },
    { '<leader>#',  with_cwd_project_root(builtin.grep_string),    desc = 'Grep current string, CWD project root' },

    -- Relative to Buffer --
    { '<leader>r*', with_buffer_dir(builtin.grep_string),          desc = 'Grep current string, buf dir' },
    { '<leader>r#', with_buffer_project_root(builtin.grep_string), desc = 'Grep current string, buf project root' },
  })


  -- ----
  -- Trouble
  -- ----
  local trouble = require("trouble")
  local trouble_func = function(func)
    return function()
      func({ skip_groups = true, jump = true })
    end
  end

  which_key.add({
    { ']r', trouble_func(trouble.next),     desc = 'Trouble - next' },
    { ']R', trouble_func(trouble.last),     desc = 'Trouble - last' },
    { '[r', trouble_func(trouble.previous), desc = 'Trouble - back' },
    { '[R', trouble_func(trouble.first),    desc = 'Trouble - first' },
  })

  which_key.add({
    { '<leader>s',  group = 'Switch/toggle' },
    { '<leader>sG', '<cmd>Gitsigns toggle_signs<CR>', desc = 'Gitsigns toggle (all buffers)' },
    { '<leader>sd', '<Plug>(toggle-lsp-diag)',        desc = 'LSP diag toggle (all buffers)' },
    { '<leader>ss', '<cmd>set spell!<cr>',            desc = 'Spell checking' },
    { '<leader>st', '<cmd>TroubleToggle<cr>',         desc = 'Trouble' },
    { '<leader>sv', '<Plug>(toggle-lsp-diag-vtext)',  desc = 'LSP diag vtext toggle (all buffers)' },
  })

  -- ----------------------------------------------------------------------------
  -- Other
  -- ----------------------------------------------------------------------------
  local clean_trailing_whitespace = function()
    local save = vim.fn.winsaveview()
    vim.cmd([[keeppatterns %s/\s\+$//]])
    vim.fn.winrestview(save)
  end

  which_key.add({
    { "<leader>C",  group = "clean" },
    -- N = { 'clean-vertical-whitespace' }, --  TODO - :%s/^\n\+/\r//<cr>:let @/=''<cr>
    { '<leader>CT', vim.cmd.retab,             desc = 'clean-tabs' },
    { '<leader>CW', clean_trailing_whitespace, desc = 'clean-trailing-whitespace' },
    { '<leader>\\', vim.cmd.nohlsearch,        desc = 'Clear search highlights' },
  })

  which_key.add({
    { '[g', vim.diagnostic.goto_prev, desc = 'goto-prev-diagnostics', },
    { ']g', vim.diagnostic.goto_next, desc = 'goto-next-diagnostics', },
  })
end


-- ----------------------------------------------------------------------------
-- Lazy
-- ----------------------------------------------------------------------------
return {
  'folke/which-key.nvim',
  lazy = false,
  dependencies = {
    'nvim-tree/nvim-web-devicons',
  },
  config = configuration,

  -- keys = {
  --   {
  --     "<leader>?",
  --     function()
  --       require("which-key").show({ global = false })
  --     end,
  --     desc = "Buffer Local Keymaps (which-key)",
  --   },
  -- },
}
