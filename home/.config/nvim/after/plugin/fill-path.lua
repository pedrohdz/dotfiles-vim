local foo = function()
  local cwd = vim.fn.fnamemodify(
    vim.fn.simplify(
      vim.fn.getcwd()  -- getcwd() does not make sense to simplify.
    ),
    ':~:.'
  )

  return cwd
end

vim.keymap.set(
  { 'c' },
  '<M-f>',
  foo,
  { noremap = true, expr = true, silent = false }
)
