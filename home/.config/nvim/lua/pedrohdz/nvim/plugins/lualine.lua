return {
  "nvim-lualine/lualine.nvim",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  init = function()
    vim.api.nvim_set_hl(0, "WinSeparator", { guibg = nil })
    vim.opt.laststatus = 3
    vim.opt.winbar = "%=%m %f"
  end,
  opts = {
    -- options = { theme = "jellybeans" },
  },
}
