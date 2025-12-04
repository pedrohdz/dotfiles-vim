return {
  'iamcco/markdown-preview.nvim',

  -- TODO - We need to figure out how to manage this long term.  Potential
  -- options:
  --   - Move this to Nix?
  --   - Setup renovate?
  --   - Find a new, more modern alternative
  commit = 'a923f5fc5ba36a3b17e289dc35dc17f66d0548ee',
  pin = true,

  init = function()
    vim.g.mkdp_auto_close = 0
    vim.g.mkdp_browser = '/bin/true'
    vim.g.mkdp_combine_preview = 0
    vim.g.mkdp_echo_preview_url = 1
    vim.g.mkdp_filetypes = { 'Avante', 'markdown' }
  end,
  cmd = {
    'MarkdownPreview',
    'MarkdownPreviewStop',
    'MarkdownPreviewToggle',
  },
  ft = {
    'Avante',
    'markdown',
  },
  build = 'cd app && yarn install',
}
