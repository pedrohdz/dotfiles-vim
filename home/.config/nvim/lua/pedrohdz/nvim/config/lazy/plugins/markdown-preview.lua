-- The following error was fixed:
--    Vim:E117: Unknown function: mkdp#util#install when install by lazy.nvim
-- By the change suggested in:
--    - https://github.com/iamcco/markdown-preview.nvim/issues/690#issuecomment-2288249997
return {
  'iamcco/markdown-preview.nvim',
  cmd = {
    'MarkdownPreview',
    'MarkdownPreviewStop',
    'MarkdownPreviewToggle',
  },
  ft = {
    'Avante',
    'markdown',
  },
  build = function()
    vim.cmd('Lazy load markdown-preview.nvim')
    vim.fn['mkdp#util#install']()
  end,
}
