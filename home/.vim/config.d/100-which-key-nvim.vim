if !has('nvim')
  finish
endif

lua << EOF
  require('which-key').setup({
  layout = {
    height = { min = 10, max = 25 }, -- min and max height of the columns
    width = { min = 20, max = 50 }, -- min and max width of the columns
    spacing = 3, -- spacing between columns
    align = 'left', -- align columns left, center or right
  },
    window = {
      border = 'single', -- none, single, double, shadow
      position = 'top', -- bottom, top
      margin = { 1, 1, 1, 1 }, -- extra window margin [top, right, bottom, left]
      padding = { 1, 1, 1, 1 }, -- extra window padding [top, right, bottom, left]
      winblend = 0
    },
  })
EOF
