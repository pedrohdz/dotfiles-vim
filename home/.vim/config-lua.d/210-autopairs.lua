local cmp           = require('cmp')
local autopairs_cmp = require('nvim-autopairs.completion.cmp')


require("nvim-autopairs").setup({})

cmp.event:on(
  'confirm_done',
  autopairs_cmp.on_confirm_done()
)
