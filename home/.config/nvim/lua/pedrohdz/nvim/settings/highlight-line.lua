-- Create an augroup for highlight-line related autocommands
local autocmd_group = vim.api.nvim_create_augroup('highlight-line', { clear = true })

-- Enable cursorline when entering a window
vim.api.nvim_create_autocmd('WinEnter', {
  group = autocmd_group,
  callback = function()
    vim.wo.colorcolumn = '+1'
    vim.wo.cursorcolumn = true
    vim.wo.cursorline = true
  end,
})

-- Disable cursorline when leaving a window
vim.api.nvim_create_autocmd('WinLeave', {
  group = autocmd_group,
  callback = function()
    vim.wo.colorcolumn = '0'
    vim.wo.cursorcolumn = false
    vim.wo.cursorline = false
  end,
})

-- Set the defaults.  Needed for initial startup.
vim.wo.colorcolumn = '+1'
vim.wo.cursorcolumn = true
vim.wo.cursorline = true
