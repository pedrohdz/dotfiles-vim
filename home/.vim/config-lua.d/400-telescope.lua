-- ----------------------------------------------------------------------------
-- https://github.com/nvim-telescope/telescope.nvim
-- ----------------------------------------------------------------------------
local which_key = require('which-key')
local builtin = require('telescope.builtin')

which_key.register({
  t = {
    name = 'Telescope',
    f = {
      name = 'Files',
      F = {builtin.git_files, 'Fuzzy search git ls-files'},
      f = {builtin.find_files, 'Files in CWD'},
      g = {builtin.grep_string, 'Grep for string under cursor in CWD'},
      l = {builtin.live_grep, 'String search in CWD'},
    },
    g = {
      name = 'Git',
      C = {builtin.git_bcommits, 'Commit diffs (buffer)'},
      S = {builtin.git_stash, 'Stash'},
      b = {builtin.git_branches, 'Branches, checkout <cr>, track <C-t>. rebase <C-r>'},
      c = {builtin.git_commits, 'Commit diffs (workspace)'},
      s = {builtin.git_status, 'Status'},
    },
    l = {
      name = 'Neovim LSP',
      D = {builtin.lsp_definitions, 'Goto definition, word under the cursor'},
      I = {builtin.lsp_implementations, 'Goto implementation, word under the cursor'},
      S = {builtin.lsp_workspace_symbols, 'Document symbols (workspace)'},
      T = {builtin.lsp_type_definitions, 'Goto type definition, word under the cursor'},
      a = {builtin.diagnostics, 'Diagnostics (buffer)'},
      i = {builtin.lsp_incoming_calls, 'Incoming calls, word under the cursor'},
      o = {builtin.lsp_outgoing_calls, 'Outgoing calls, word under the cursor'},
      r = {builtin.lsp_references, 'Refs for word under the cursor'},
      s = {builtin.lsp_document_symbols, 'Document symbols (buffer)'},
      y = {builtin.lsp_dynamic_workspace_symbols, 'Dynamic symbols (workspace)'},
    },
    p = {
      name = 'Telescope pickers',
      P = {builtin.planets, 'Planets'},
      b = {builtin.builtin, 'Built-ins'},
      l = {builtin.reloader, 'Lua module reload'},
      s = {builtin.symbols, 'symbols inside data/telescope-sources/*.json'},
    },
    t = {builtin.treesitter, 'Treesitter'},
    v = {
      name = 'Vim',
      C = {builtin.commands, 'Commands'},
      D = {builtin.colorscheme, 'Colorschemes'},
      F = {builtin.filetypes, 'Filetypes'},
      H = {builtin.highlights, 'Highlights'},
      M = {builtin.man_pages, 'Manpage'},
      O = {builtin.vim_options, 'Vim options'},
      P = {builtin.pickers, 'Previous pickers'},
      Q = {builtin.quickfixhistory, 'Quickfix history'},
      S = {builtin.spell_suggest, 'Spelling suggestions'},
      T = {builtin.tags, 'Tags'},
      a = {builtin.autocommands, 'Autocommands'},
      b = {builtin.buffers, 'Buffers'},
      c = {builtin.command_history, 'Commands history'},
      f = {builtin.current_buffer_fuzzy_find, 'Buffer live fuzzy search'},
      h = {builtin.help_tags, 'Help tags'},
      j = {builtin.jumplist, 'Jump List'},
      k = {builtin.keymaps, 'Normal mode keymappings'},
      l = {builtin.loclist, 'Locations (current window'},
      m = {builtin.marks, 'Marks'},
      o = {builtin.oldfiles, 'Previously open files'},
      p = {builtin.resume, 'Resume previous picker results'},
      q = {builtin.quickfix, 'Quickfix list'},
      r = {builtin.registers, 'Registers'},
      s = {builtin.search_history, 'Searches history'},
      t = {builtin.current_buffer_tags, 'Buffer tags'},
    },
  },
}, {
  prefix = '<leader>',
  noremap = true,
  silent = true,
})
