vim.lsp.enable({
  'ansiblels',
  'bashls',
  'dockerls',
  'helm_ls',
  'jsonls',
  'lua_ls',
  'nixd',
  'pyright',
  'rust_analyzer',
  'solargraph',
  'terraformls',
  'vimls',
  'yamlls',
})

require('pedrohdz.nvim.settings.lsp.event-attach')
