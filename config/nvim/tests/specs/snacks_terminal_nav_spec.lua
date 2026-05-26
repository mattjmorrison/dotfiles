local assert = require("tests.helpers.assert")

local T = {}

local function terminal_keys()
  return require("snacks").config.get("terminal", {}).win.keys
end

local function with_mux_mock(test)
  local original = package.loaded["smart-splits.mux"]
  local calls = {}

  package.loaded["smart-splits.mux"] = {
    move_pane = function(direction, same_tabpage, mode)
      table.insert(calls, {
        direction = direction,
        same_tabpage = same_tabpage,
        mode = mode,
      })
    end,
  }

  local ok, err = pcall(test, calls)
  package.loaded["smart-splits.mux"] = original

  if not ok then
    error(err, 0)
  end
end

local function assert_mux_call(calls, direction)
  assert.equal(#calls, 1, "expected one tmux fallback call")
  assert.equal(calls[1].direction, direction)
  assert.equal(calls[1].same_tabpage, true)
  assert.equal(calls[1].mode, "wrap")
end

local function assert_terminal_key_falls_back_to_tmux(key_name, lhs, direction)
  with_mux_mock(function(calls)
    vim.cmd("silent! only")
    vim.cmd("enew")
    vim.bo.filetype = "snacks_terminal"

    local key = terminal_keys()[key_name]
    local terminal = {
      is_floating = function()
        return false
      end,
    }

    assert.truthy(key, "missing Snacks terminal key mapping: " .. key_name)
    assert.equal(key[1], lhs, key_name .. " should be bound to " .. lhs)
    assert.equal(key.expr, true, key_name .. " should be an expr mapping")
    assert.equal(key.mode, "t", key_name .. " should be a terminal-mode mapping")

    assert.equal(key[2](terminal), "", key_name .. " should return an empty string to the terminal")

    local called = vim.wait(100, function()
      return #calls == 1
    end)

    assert.truthy(called, key_name .. " did not fall back to tmux")
    assert_mux_call(calls, direction)
  end)
end

T["terminal <C-h> falls back to tmux on the left edge"] = function()
  assert_terminal_key_falls_back_to_tmux("nav_h", "<C-h>", "left")
end

T["terminal <C-j> falls back to tmux on the bottom edge"] = function()
  assert_terminal_key_falls_back_to_tmux("nav_j", "<C-j>", "down")
end

T["terminal <C-k> falls back to tmux on the top edge"] = function()
  assert_terminal_key_falls_back_to_tmux("nav_k", "<C-k>", "up")
end

T["terminal <C-l> falls back to tmux on the right edge"] = function()
  assert_terminal_key_falls_back_to_tmux("nav_l", "<C-l>", "right")
end

return T
