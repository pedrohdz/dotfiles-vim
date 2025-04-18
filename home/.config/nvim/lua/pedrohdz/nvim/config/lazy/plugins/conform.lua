-- For more information:
--   https://github.com/stevearc/conform.nvim

local function prettier_config()
  -- Supports:
  --    Angular, CSS, Flow, GraphQL, HTML, JSON, JSX, JavaScript, LESS,
  --    Markdown, SCSS, TypeScript, Vue, YAML,
  return { 'prettierd', 'prettier', stop_after_first = true }
end

local function keys()
  return {
    {
      '<localleader>f',
      function()
        require('conform').format({ async = true })
      end,
      mode = '',
      desc = 'Format buffer',
    },
  }
end

return {
  'stevearc/conform.nvim',

  event = { 'BufWritePre' },
  cmd = { 'ConformInfo' },
  keys = keys(),
  opts = {
    formatters_by_ft = {
      javascript = prettier_config(),
      json = prettier_config(),
      markdown = prettier_config(),
      yaml = prettier_config(),
    },
    default_format_opts = {
      lsp_format = 'fallback',
    },
  },
}
