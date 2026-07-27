local M = {}

-- ----------------------------------------------------------------------------
--
-- ----------------------------------------------------------------------------
M.find_relative_project_root = function(fname)
  local util = require('lspconfig.util')

  local git_ancestor = util.find_git_ancestor(fname)
  local node_modules_ancestor = util.find_node_modules_ancestor(fname)
  local json_ancestor = util.find_package_json_ancestor(fname)

  return git_ancestor or node_modules_ancestor or json_ancestor
end

M.find_buffer_project_root = function()
  local utils = require('telescope.utils')
  return M.find_relative_project_root(utils.buffer_dir())
end

M.find_cwd_project_root = function()
  return M.find_relative_project_root(vim.fn.getcwd())
end


-- ----------------------------------------------------------------------------
--
-- ----------------------------------------------------------------------------
M.wrapper_dir_wrapper = function(func, dir_func, opts)
  opts = vim.deepcopy(opts) or {}
  return function()
    opts.cwd = dir_func() -- For Telescope
    opts.path = opts.cwd  -- For nvim-tree
    func(opts)
  end
end

M.with_buffer_project_root = function(func, opts)
  return M.wrapper_dir_wrapper(func, M.find_buffer_project_root, opts)
end

M.with_cwd_project_root = function(func, opts)
  return M.wrapper_dir_wrapper(func, M.find_cwd_project_root, opts)
end

M.with_buffer_dir = function(func, opts)
  local utils = require('telescope.utils')
  return M.wrapper_dir_wrapper(func, utils.buffer_dir, opts)
end

M.with_cwd = function(func, opts)
  return M.wrapper_dir_wrapper(func, vim.fn.getcwd, opts)
end


-- ----------------------------------------------------------------------------
--
-- ----------------------------------------------------------------------------
M.path_reference = function(absolute)
  return function()
    local bufname = vim.api.nvim_buf_get_name(0)
    local path = vim.fn.fnamemodify(bufname, absolute and ':p' or ':.')

    local mode = vim.fn.mode()
    local line_start, line_end

    if mode == 'v' or mode == 'V' or mode == '\22' then
      line_start = vim.fn.line('v')
      line_end = vim.fn.line('.')
      if line_start > line_end then
        line_start, line_end = line_end, line_start
      end

      -- Leave Visual mode so the "-- VISUAL --" indicator doesn't
      -- immediately overwrite the notify message below.
      local esc = vim.api.nvim_replace_termcodes('<Esc>', true, false, true)
      vim.api.nvim_feedkeys(esc, 'nx', false)
    else
      line_start = vim.fn.line('.')
      line_end = line_start
    end

    local reference
    if line_start == line_end then
      reference = string.format('%s#L%d', path, line_start)
    else
      reference = string.format('%s#L%d-%d', path, line_start, line_end)
    end

    vim.fn.setreg('+', reference)
    vim.notify('Copied: ' .. reference)
  end
end

return M
