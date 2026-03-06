return {
  'MeanderingProgrammer/render-markdown.nvim',
  opts = {
    file_types = {
      'Avante',
      'codecompanion',
      'markdown',
    },
    heading = {
      width = 'block',
    },
    code = {
      width = 'block',
    },
  },
  ft = {
    'Avante',
    'codecompanion',
    'markdown',
  },
  dependencies = {
    'nvim-tree/nvim-web-devicons',
    'nvim-treesitter/nvim-treesitter',
  },
}
