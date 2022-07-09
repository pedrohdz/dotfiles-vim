-- ----------------------------------------------------------------------------
-- https://github.com/nvim-telescope/telescope.nvim
-- ----------------------------------------------------------------------------
local trouble = require("trouble.providers.telescope")
local telescope = require("telescope")

telescope.setup {
  defaults = {
    mappings = {
      i = { ["<c-o>"] = trouble.open_with_trouble },
      n = { ["<c-o>"] = trouble.open_with_trouble },
    },
  },
}
