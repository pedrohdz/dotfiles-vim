-- 
-- https://github.com/folke/todo-comments.nvim
--
require('todo-comments').setup({
  highlight = {
    pattern = [=[.*<(KEYWORDS)\s*[:-]]=],
  },
  search = {
    pattern = [=[\b(KEYWORDS)\b\s*[:-]]=],
  },
})
