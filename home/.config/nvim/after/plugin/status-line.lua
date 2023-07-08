require('lualine').setup({
  options = {
    theme = 'jellybeans'
  }
})

-- Cleaning up the status line
vim.api.nvim_set_hl(0, 'WinSeparator', { guibg = nil })
vim.opt.laststatus = 3
vim.opt.winbar = '%=%m %f'
