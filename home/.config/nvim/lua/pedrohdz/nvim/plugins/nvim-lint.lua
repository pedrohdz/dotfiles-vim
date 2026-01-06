-- Plugin from:
--    https://github.com/mfussenegger/nvim-lint
-- An asynchronous linter plugin for Neovim complementary to the built-in
-- Language Server Protocol support.

local function setup()
  local lint = require('lint')

  lint.linters_by_ft = {
    ansible = { 'ansible_lint' },
    bash = { 'bash', 'shellcheck' },
    lua = { 'luacheck' },
    nix = { 'nix' },
    sh = { 'shellcheck' },
    yaml = { 'yamllint' },
    zsh = { 'zsh' },
  }

  local augroup = vim.api.nvim_create_augroup(
    'phdz-lint',
    { clear = true }
  )
  vim.api.nvim_create_autocmd(
    {
      'BufReadPost',
      'BufWritePost',
      'InsertLeave',
    },
    {
      group = augroup,
      callback = function()
        lint.try_lint()
        -- lint.try_lint('cspell')
      end,
    })
end

return {
  'mfussenegger/nvim-lint',
  config = setup,
}
