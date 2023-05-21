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
M.wrapper_dir_wrapper = function (func, dir, opts)
  opts = vim.deepcopy(opts) or {}
  opts.cwd = dir
  return function()
    func(opts)
  end
end

M.with_buffer_project_root = function(func, opts)
  return M.wrapper_dir_wrapper(func, M.find_buffer_project_root(), opts)
end

M.with_cwd_project_root = function(func, opts)
  return M.wrapper_dir_wrapper(func, M.find_cwd_project_root(), opts)
end

M.with_buffer_dir = function(func, opts)
  local utils = require('telescope.utils')
  return M.wrapper_dir_wrapper(func, utils.buffer_dir(), opts)
end

M.with_cwd = function(func, opts)
  return M.wrapper_dir_wrapper(func, vim.fn.getcwd(), opts)
end

return M
