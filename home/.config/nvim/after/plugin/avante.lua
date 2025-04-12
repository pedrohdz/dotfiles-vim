local avante = require('avante')

--  Remember to run the following:
--    cd $HOME/.local/share/nvim/site/pack/packer/start/avante.nvim
--    make
--  Fix is from:
--    - https://github.com/yetone/avante.nvim/issues/547#issuecomment-2334232455

avante.setup({
  provider = 'openai',
  openai = {
    -- FIXME - api_key_name = { 'pass', 'show', 'local/api/chatgpt.nvim' },
    --
    -- Defaults:
    --   endpoint = 'https://api.openai.com/v1',
    --   model = 'gpt-4o',
    --   timeout = 30000, -- Timeout in milliseconds, increase this for reasoning models
    --   temperature = 0,
    --   max_completion_tokens = 16384, -- Increase this to include reasoning tokens (for reasoning models)
    --   reasoning_effort = 'medium', -- low|medium|high, only used for reasoning models
  },
})
