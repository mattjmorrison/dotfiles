local assert = require("tests.helpers.assert")

local T = {}

local function sidekick_keys()
  return require("plugins.sidekick")[1].opts.cli.win.keys
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

local function assert_sidekick_key(key_name, lhs, method)
  with_smart_splits_mock(function(calls)
    local key = sidekick_keys()[key_name]

    assert.truthy(key, "missing Sidekick key mapping: " .. key_name)
    assert.equal(key[1], lhs, key_name .. " should be bound to " .. lhs)
    assert.equal(key.expr, true, key_name .. " should be an expr mapping")
    assert.equal(key[2](), "", key_name .. " should return an empty string to the terminal")

    local called = vim.wait(100, function()
      return #calls == 1
    end)

    assert.truthy(called, key_name .. " did not call smart-splits." .. method)
    assert.equal(calls[1], method, key_name .. " should call smart-splits." .. method)
  end)
end

T["sidekick <C-h> navigates left"] = function()
  assert_sidekick_key("nav_left", "<c-h>", "move_cursor_left")
end

T["sidekick <C-j> navigates down"] = function()
  assert_sidekick_key("nav_down", "<c-j>", "move_cursor_down")
end

T["sidekick <C-k> navigates up"] = function()
  assert_sidekick_key("nav_up", "<c-k>", "move_cursor_up")
end

T["sidekick <C-l> navigates right"] = function()
  assert_sidekick_key("nav_right", "<c-l>", "move_cursor_right")
end

T["sidekick <M-h> resizes left"] = function()
  assert_sidekick_key("resize_left", "<M-h>", "resize_left")
end

T["sidekick <M-j> resizes down"] = function()
  assert_sidekick_key("resize_down", "<M-j>", "resize_down")
end

T["sidekick <M-k> resizes up"] = function()
  assert_sidekick_key("resize_up", "<M-k>", "resize_up")
end

T["sidekick <M-l> resizes right"] = function()
  assert_sidekick_key("resize_right", "<M-l>", "resize_right")
end

return T
