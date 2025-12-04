-- nvim-tree Lazy specification + configuration ------------------------------
--
-- We lazy-load on:
--   • require('nvim-tree')  or require('nvim-tree.api')
--   • the listed commands / keymaps
-- This guarantees the plugin is available when which-key’s config calls
--   require("nvim-tree.api").tree
--
local function nvim_tree_config()
  ---------------------------------------------------------------------------
  -- Local helpers -----------------------------------------------------------
  ---------------------------------------------------------------------------
  local height_ratio = 0.80
  local width_ratio  = 0.70

  local function float_open_win_config()
    local screen_w   = vim.opt.columns:get()
    local screen_h   = vim.opt.lines:get() - vim.opt.cmdheight:get()
    local window_w   = math.floor(screen_w * width_ratio)
    local window_h   = math.floor(screen_h * height_ratio)
    local center_x   = (screen_w - window_w) / 2
    local center_y   = ((vim.opt.lines:get() - window_h) / 2) - vim.opt.cmdheight:get()

    return {
      border   = 'rounded',
      relative = 'editor',
      row      = center_y,
      col      = center_x,
      width    = window_w,
      height   = window_h,
    }
  end

  local function on_attach(bufnr)
    local api  = require('nvim-tree.api')
    local function opts(desc)
      return { desc = 'nvim-tree: ' .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
    end
    api.config.mappings.default_on_attach(bufnr)
    vim.keymap.set('n', '<Esc>', api.tree.close, opts('Close'))
  end

  ---------------------------------------------------------------------------
  -- nvim-tree setup ---------------------------------------------------------
  ---------------------------------------------------------------------------
  require('nvim-tree').setup({
    on_attach = on_attach,
    update_focused_file = {
      enable = true,
      update_root = { enable = true },
    },
    renderer = {
      icons = {
        bookmarks_placement   = 'signcolumn',
        diagnostics_placement = 'signcolumn',
        git_placement         = 'signcolumn',
        modified_placement    = 'signcolumn',
      },
    },
    view = {
      signcolumn = 'yes',
      float = {
        enable          = true,
        open_win_config = float_open_win_config,
      },
      width = function()
        return math.floor(vim.opt.columns:get() * width_ratio)
      end,
    },
  })

  ---------------------------------------------------------------------------
  -- Auto-resize when the Neovim window is resized ---------------------------
  ---------------------------------------------------------------------------
  local api   = require('nvim-tree.api')
  local view  = require('nvim-tree.view')
  local group = vim.api.nvim_create_augroup('NvimTreeResize', { clear = true })

  vim.api.nvim_create_autocmd('VimResized', {
    group = group,
    callback = function()
      if view.is_visible() then
        view.close()
        api.tree.open()
      end
    end,
  })
end

return {
  'nvim-tree/nvim-tree.lua',
  module = { 'nvim-tree', 'nvim-tree.api' },
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  cmd = { 'NvimTreeToggle', 'NvimTreeOpen', 'NvimTreeFocus', 'NvimTreeFindFile', 'NvimTreeRefresh' },
  keys = {
    { '<leader>n', '<cmd>NvimTreeToggle<cr>', desc = 'Toggle NvimTree' },
  },
  config = nvim_tree_config,
}
