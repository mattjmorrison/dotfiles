local M = {}

function M.current_win()
  return vim.api.nvim_get_current_win()
end

function M.vertical_split()
  local left = vim.api.nvim_get_current_win()
  vim.cmd("vsplit")
  local right = vim.api.nvim_get_current_win()

  return {
    left = left,
    right = right,
  }
end

function M.horizontal_split()
  local top = vim.api.nvim_get_current_win()
  vim.cmd("split")
  local bottom = vim.api.nvim_get_current_win()

  return {
    top = top,
    bottom = bottom,
  }
end

return M
