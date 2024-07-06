local chatgpt = require('chatgpt')
local job = require('plenary.job')

local command = { 'pass', 'show', 'local/api/chatgpt.nvim' } -- 'ws-avi-pedher-m1 ChatGPT.nvim'

local _, code = job:new({
  command = command[1],
  args = vim.list_slice(command, 2, #command),
}):sync()

if code ~= 0 then
  return
end

chatgpt.setup({
  api_key_cmd = table.concat(command, ' ')
})
