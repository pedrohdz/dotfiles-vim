local OPENAI_API_KEY = 'cmd:pass show "dev-vm/app/nvim/codecompanion/codex"'
local CODEX_CONFIG_FILE = '~/.codex/config.toml'
local BASE_CODEX_PROFILE = 'codex'


local function generate_codex_config(config)
  config = config or {}
  local default_command = { 'codex-acp' }

  for key, value in pairs(config) do
    vim.list_extend(default_command, { '-c', key .. '=' .. value })
  end

  return function()
    return require('codecompanion.adapters').extend('codex', {
      defaults = {
        auth_method = 'openai-api-key',
      },
      commands = {
        default = default_command,
      },
      env = {
        OPENAI_API_KEY = OPENAI_API_KEY,
      },
    })
  end
end

local function get_codex_profile_configs()
  local profiles = { [BASE_CODEX_PROFILE] = {} }
  local codex_config_file =   vim.fn.expand(CODEX_CONFIG_FILE)
  local status, lines = pcall(
    vim.fn.readfile,
    codex_config_file
  )
  if not status then
    vim.notify('Unable to read: "' .. codex_config_file .. '"', vim.log.levels.ERROR) -- respects :messages/notify UI
    return profiles
  end

  for _, line in ipairs(lines) do
    local name = line:match("^%[profiles%.([%w_-]+)%]%s*$")
    if name then
      profiles[ BASE_CODEX_PROFILE .. '-' .. name] = { profile = name }
    end
  end
  return profiles
end

local function get_options()
  local options = {
    display = {
      chat = {
        -- show_settings = true,
        show_token_count = true,
      },
    },

    -- opts = {
    --   log_level = "TRACE", -- TRACE|DEBUG|ERROR|INFO
    -- },

    adapters = {
      acp = {
        opts = {
          show_presets = false,
        },
      },
      http = {
        opts = {
          show_presets = false,
        },
        copilot = "copilot",
      },
    },

    interactions = {
      background = {
        adapter = BASE_CODEX_PROFILE,
      },
      chat = {
        adapter = BASE_CODEX_PROFILE,
      },
      cmd = {
        adapter = BASE_CODEX_PROFILE,
      },
      inline = {
        adapter = BASE_CODEX_PROFILE,
      },
    },
  }

  for name, config in pairs(get_codex_profile_configs()) do
    ---@type table<string, fun(): table>
    options.adapters.acp = options.adapters.acp or {}
    options.adapters.acp[name] = generate_codex_config(config)
  end
  return options
end

return {
  'olimorris/codecompanion.nvim',
  version = '>18.0.0',
  config = true,
  opts = get_options(),
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-treesitter/nvim-treesitter',
    -- 'ravitemer/mcphub.nvim' -- TODO - https://github.com/ravitemer/mcphub.nvim
  },
}
