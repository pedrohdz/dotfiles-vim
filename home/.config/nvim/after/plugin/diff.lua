local lsp_config_callback = function(opt)
  vim.schedule(function()
    local window_id = vim.fn.win_getid(vim.fn.bufwinnr(opt.buf))
    if not vim.wo[window_id].diff then
      return
    end

    vim.api.nvim_win_set_cursor(window_id, { 1, 0 })
  end)
end

vim.api.nvim_create_autocmd(
  'BufWinEnter',
  {
    pattern = '*',
    callback = lsp_config_callback,
    group = vim.api.nvim_create_augroup('phdz-diff', {}),
    desc = 'Move cursor to top of the window on a diff.'
  }
)
