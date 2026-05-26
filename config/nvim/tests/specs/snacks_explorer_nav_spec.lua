local assert = require("tests.helpers.assert")
local windows = require("tests.helpers.windows")

local T = {}

local function explorer_keys()
  return require("plugins.snacks")[1].opts.picker.sources.explorer.win.list.keys
end

local function set_filetype(win, filetype)
  local buf = vim.api.nvim_create_buf(false, true)
  vim.bo[buf].filetype = filetype
  vim.api.nvim_win_set_buf(win, buf)
end

local function reset_windows()
  vim.cmd("silent! only")
  vim.cmd("enew")
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

local function assert_no_mux_calls(calls)
  assert.equal(#calls, 0, "expected explorer navigation to stay inside Neovim")
end

local function assert_mux_call(calls, direction)
  assert.equal(#calls, 1, "expected one tmux fallback call")
  assert.equal(calls[1].direction, direction)
  assert.equal(calls[1].same_tabpage, true)
  assert.equal(calls[1].mode, "stop")
end

T["explorer <C-j> moves to the lower Neovim window"] = function()
  with_mux_mock(function(calls)
    reset_windows()

    local split = windows.horizontal_split()
    set_filetype(split.top, "snacks_picker_list")
    vim.api.nvim_set_current_win(split.top)

    explorer_keys()["<C-j>"]()

    assert.equal(vim.api.nvim_get_current_win(), split.bottom)
    assert_no_mux_calls(calls)
  end)
end

T["explorer <C-k> moves to the upper Neovim window"] = function()
  with_mux_mock(function(calls)
    reset_windows()

    local split = windows.horizontal_split()
    set_filetype(split.bottom, "snacks_picker_list")
    vim.api.nvim_set_current_win(split.bottom)

    explorer_keys()["<C-k>"]()

    assert.equal(vim.api.nvim_get_current_win(), split.top)
    assert_no_mux_calls(calls)
  end)
end

T["explorer <C-j> falls back to tmux below the last Neovim window"] = function()
  with_mux_mock(function(calls)
    reset_windows()
    set_filetype(vim.api.nvim_get_current_win(), "snacks_picker_list")

    explorer_keys()["<C-j>"]()

    assert_mux_call(calls, "down")
  end)
end

T["explorer <C-k> falls back to tmux above the first Neovim window"] = function()
  with_mux_mock(function(calls)
    reset_windows()
    set_filetype(vim.api.nvim_get_current_win(), "snacks_picker_list")

    explorer_keys()["<C-k>"]()

    assert_mux_call(calls, "up")
  end)
end

T["explorer <C-j> ignores lower Snacks windows when choosing a target"] = function()
  with_mux_mock(function(calls)
    reset_windows()

    local split = windows.horizontal_split()
    set_filetype(split.top, "snacks_picker_list")
    set_filetype(split.bottom, "snacks_picker_input")
    vim.api.nvim_set_current_win(split.top)

    explorer_keys()["<C-j>"]()

    assert.equal(vim.api.nvim_get_current_win(), split.top)
    assert_mux_call(calls, "down")
  end)
end

T["explorer <C-j> moves into a bottom terminal below explorer and dashboard"] = function()
  with_mux_mock(function(calls)
    reset_windows()

    local horizontal = windows.horizontal_split()
    local terminal = horizontal.bottom

    vim.api.nvim_set_current_win(horizontal.top)
    local vertical = windows.vertical_split()
    local explorer = vertical.left
    local dashboard = vertical.right

    set_filetype(explorer, "snacks_picker_list")
    set_filetype(dashboard, "snacks_dashboard")
    set_filetype(terminal, "snacks_terminal")
    vim.api.nvim_set_current_win(explorer)

    explorer_keys()["<C-j>"]()

    assert.equal(vim.api.nvim_get_current_win(), terminal)
    assert_no_mux_calls(calls)
  end)
end

return T
