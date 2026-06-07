local assert = require("tests.helpers.assert")

local T = {}

T["LazyVim.root() resolves to git root for deeply nested nvim config buffer"] = function()
  -- Load user options so vim.g.root_spec takes effect.
  require("config.options")

  -- Point the current buffer at a path deep inside the nvim config subtree.
  -- Without vim.g.root_spec = { ".git", "cwd" }, LazyVim.root() returns
  -- config/nvim because the "lua" pattern fires before ".git".
  local buf = vim.api.nvim_create_buf(false, true)
  local deep_path = vim.fn.getcwd() .. "/config/nvim/lua/plugins/snacks.lua"
  vim.api.nvim_buf_set_name(buf, deep_path)
  vim.api.nvim_set_current_buf(buf)

  -- Clear root cache so it re-detects for the new buffer.
  require("lazyvim.util.root").cache = {}

  local root = require("lazyvim.util.root").get()

  vim.api.nvim_buf_delete(buf, { force = true })

  local git = vim.fs.find(".git", { path = vim.fn.getcwd(), upward = true })[1]
  local expected = git and vim.fn.fnamemodify(git, ":h") or vim.fn.getcwd()

  assert.equal(root, expected, "LazyVim.root() should return the git root, not an intermediate directory")
end

return T
