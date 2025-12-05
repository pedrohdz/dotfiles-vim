local function foo()
  local cwd = vim.fn.fnamemodify(
    vim.fn.simplify(vim.fn.getcwd()),
    ':~:.'
  )
  return cwd
end

vim.keymap.set({ 'c' }, '<M-f>', foo, { noremap = true, expr = true, silent = false })
