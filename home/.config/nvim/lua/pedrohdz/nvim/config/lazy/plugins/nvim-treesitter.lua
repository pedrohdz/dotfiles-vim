local setup = function()
  require('nvim-treesitter.configs').setup({
    auto_install = true,
    ensure_installed = {
      'bash',
      'c',
      'css',
      'csv',
      'dockerfile',
      'dot',
      'git_config',
      'git_rebase',
      'gitcommit',
      'gitignore',
      'groovy',
      'hcl',
      'html',
      'java',
      'json',
      -- 'latex',  -- TODO - Fix this.
      'lua',
      'make',
      'markdown',
      'markdown_inline',
      'nix',
      'python',
      'regex',
      'rst',
      'rust',
      'terraform',
      'tmux',
      'toml',
      'vim',
      'vimdoc',
      'yaml',
    },
    highlight = {
      enable = true
    },
  })
end

return {
  'nvim-treesitter/nvim-treesitter',
  config = setup,
  build = function()
    local ts_update = require('nvim-treesitter.install').update({ with_sync = true })
    ts_update()
  end,
}
