if !has('nvim')
  finish
endif

lua << EOF
  require('which-key').setup({})
EOF
