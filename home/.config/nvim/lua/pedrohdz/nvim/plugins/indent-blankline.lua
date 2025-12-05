return {
  "lukas-reineke/indent-blankline.nvim",
  main = "ibl",
  opts = {
    indent = {
      char = "┊",
      smart_indent_cap = true,
    },
    scope = {
      enabled = true,
      include = {
        node_type = { ["*"] = { "*" } },
      },
    },
  },
}
