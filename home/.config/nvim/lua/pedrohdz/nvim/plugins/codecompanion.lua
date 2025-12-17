local function options()
  return {
    show_token_count = true,

    adapters = {
      acp = {
        -- OpenAI (codex)
        codex = function()
          return require('codecompanion.adapters').extend('codex', {
            defaults = {
              auth_method = 'openai-api-key', -- 'openai-api-key'|'codex-api-key'|'chatgpt'
            },
            env = {
              OPENAI_API_KEY = 'cmd:pass show dev-vm/app/nvim/codecompanion/codex',
            },
          })
        end,
      },
    },
    interactions = {
      background = {
        adapter = 'codex',
      },
      chat = {
        adapter = 'codex',
      },
      cmd = {
        adapter = 'codex',
      },
      inline = {
        adapter = 'codex',
      },
    },
  }
end

return {
  'olimorris/codecompanion.nvim',
  version = '>18.0.0',
  opts = options(),
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-treesitter/nvim-treesitter',
    -- 'ravitemer/mcphub.nvim' -- TODO - https://github.com/ravitemer/mcphub.nvim
  },
}
