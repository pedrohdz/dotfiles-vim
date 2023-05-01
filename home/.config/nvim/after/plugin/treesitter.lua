require('nvim-treesitter.configs').setup({
  auto_install = true,
  ensure_installed = {
    'bash',
    'c',
    'java',
    'json',
    'lua',
    'make',
    'markdown',
    'markdown_inline',
    'python',
    'rst',
    'rust',
    'vim',
    'yaml',
  },
})
