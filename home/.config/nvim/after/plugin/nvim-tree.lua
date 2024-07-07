-- ----------------------------------------------------------------------------
-- https://github.com/nvim-tree/nvim-tree.lua
-- ----------------------------------------------------------------------------
local nvtree = require("nvim-tree")
local nvtree_view = require("nvim-tree.view")

-- ----------------------------------------------------------------------------
-- Configuration
-- ----------------------------------------------------------------------------
local height_ratio = 0.8 -- You can change this
local width_ratio = 0.7  -- You can change this too


-- ----------------------------------------------------------------------------
-- Automatically resize the floating window when neovim's window size changes
-- ----------------------------------------------------------------------------
vim.api.nvim_create_augroup("NvimTreeResize", {
  clear = true,
})

vim.api.nvim_create_autocmd({ "VimResized" }, {
  group = "NvimTreeResize",
  callback = function()
    if nvtree_view.is_visible() then
      nvtree_view.close()
      nvtree.open()
    end
  end
})


-- ----------------------------------------------------------------------------
-- Configuration/setup
-- ----------------------------------------------------------------------------
local float_open_win_config = function()
  local screen_w = vim.opt.columns:get()
  local screen_h = vim.opt.lines:get() - vim.opt.cmdheight:get()
  local window_w = screen_w * width_ratio
  local window_h = screen_h * height_ratio
  local window_w_int = math.floor(window_w)
  local window_h_int = math.floor(window_h)
  local center_x = (screen_w - window_w) / 2
  local center_y = ((vim.opt.lines:get() - window_h) / 2) - vim.opt.cmdheight:get()

  return {
    border = 'rounded',
    relative = 'editor',
    row = center_y,
    col = center_x,
    width = window_w_int,
    height = window_h_int,
  }
end


nvtree.setup({
  disable_netrw = false,
  hijack_netrw = false,
  renderer = {
    icons = {
      bookmarks_placement = 'signcolumn',
      diagnostics_placement = 'signcolumn',
      git_placement = 'signcolumn',
      modified_placement = 'signcolumn',
    }
  },
  view = {
    signcolumn = 'yes',
    float = {
      enable = true,
      open_win_config = float_open_win_config,
    },
    width = function()
      return math.floor(vim.opt.columns:get() * width_ratio)
    end,
  },
})
