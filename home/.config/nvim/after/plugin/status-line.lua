require('lualine').setup({
  options = {
    theme = 'jellybeans'
  }
})

-- Cleaning up the status line
vim.api.nvim_set_hl(0, 'WinSeparator', { guibg = nil })
vim.opt.laststatus = 3

-- TODO - Improve:
--   - https://vi.stackexchange.com/questions/42003/what-does-vlua-mean-in-an-option
--   - https://elianiva.my.id/posts/neovim-lua-statusline/
--   - https://neovim.io/doc/user/options.html#'statusline' - Note:
--      ```
--      set statusline=%!MyStatusLine()
--      ```
vim.opt.winbar = '%=%m %f'
