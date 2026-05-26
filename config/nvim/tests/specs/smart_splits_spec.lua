local assert = require("tests.helpers.assert")
local windows = require("tests.helpers.windows")

local T = {}

local function smart_splits_keys()
  return require("plugins.smart-splits")[1].keys
end

local function smart_splits_key(lhs)
  for _, key in ipairs(smart_splits_keys()) do
    if key[1] == lhs then
      return key
    end
  end
end

local function with_smart_splits_mock(test)
  local original = package.loaded["smart-splits"]
  local calls = {}

  package.loaded["smart-splits"] = setmetatable({}, {
    __index = function(_, method)
      return function()
        table.insert(calls, method)
      end
    end,
  })

  local ok, err = pcall(test, calls)
  package.loaded["smart-splits"] = original

  if not ok then
    error(err, 0)
  end
end

local function assert_smart_splits_key(lhs, method)
  with_smart_splits_mock(function(calls)
    local key = smart_splits_key(lhs)

    assert.truthy(key, "missing smart-splits key mapping: " .. lhs)
    assert.equal(type(key[2]), "function", lhs .. " should be mapped to a callback")

    key[2]()

    assert.equal(calls[1], method, lhs .. " should call smart-splits." .. method)
  end)
end

T["<C-l> moves to the right Neovim split"] = function()
  vim.cmd("silent! only")
  vim.cmd("enew")

  local split = windows.vertical_split()
  vim.api.nvim_set_current_win(split.left)

  vim.api.nvim_feedkeys(vim.keycode("<C-l>"), "x", false)

  assert.equal(vim.api.nvim_get_current_win(), split.right)
end

T["<C-h> moves to the left Neovim split"] = function()
  vim.cmd("silent! only")
  vim.cmd("enew")

  local split = windows.vertical_split()
  vim.api.nvim_set_current_win(split.right)

  vim.api.nvim_feedkeys(vim.keycode("<C-h>"), "x", false)

  assert.equal(vim.api.nvim_get_current_win(), split.left)
end

T["<C-j> moves to the lower Neovim split"] = function()
  vim.cmd("silent! only")
  vim.cmd("enew")

  local split = windows.horizontal_split()
  vim.api.nvim_set_current_win(split.top)

  vim.api.nvim_feedkeys(vim.keycode("<C-j>"), "x", false)

  assert.equal(vim.api.nvim_get_current_win(), split.bottom)
end

T["<C-k> moves to the upper Neovim split"] = function()
  vim.cmd("silent! only")
  vim.cmd("enew")

  local split = windows.horizontal_split()
  vim.api.nvim_set_current_win(split.bottom)

  vim.api.nvim_feedkeys(vim.keycode("<C-k>"), "x", false)

  assert.equal(vim.api.nvim_get_current_win(), split.top)
end

T["<BS> also moves to the left pane"] = function()
  assert_smart_splits_key("<BS>", "move_cursor_left")
end

T["<M-h> resizes the left pane"] = function()
  assert_smart_splits_key("<M-h>", "resize_left")
end

T["<M-j> resizes the lower pane"] = function()
  assert_smart_splits_key("<M-j>", "resize_down")
end

T["<M-k> resizes the upper pane"] = function()
  assert_smart_splits_key("<M-k>", "resize_up")
end

T["<M-l> resizes the right pane"] = function()
  assert_smart_splits_key("<M-l>", "resize_right")
end

return T
