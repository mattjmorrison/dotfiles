---@diagnostic disable: undefined-global

-- This script is run by `make lint-lua-diagnostics` through headless Neovim.
--
-- The goal is to make command-line checks fail for the same LuaLS warnings and
-- errors that appear in the Neovim UI. Running `lua-language-server --check`
-- directly is close, but it does not load LazyVim's Neovim-specific LuaLS
-- settings the same way the editor does. Running inside Neovim gives us the
-- same runtime, plugin config, workspace library, and generated Neovim API
-- annotations that normal editing uses.
local test_dir = vim.fn.expand("<sfile>:p:h")
local nvim_dir = vim.fn.fnamemodify(test_dir, ":h")

-- `example.lua` is the generated LazyVim starter file. It returns before any of
-- its example specs are loaded, but LuaLS still analyzes the dead sample code if
-- we open the file. Skipping it keeps this check focused on active config.
local ignored_files = {
  [nvim_dir .. "/lua/plugins/example.lua"] = "LazyVim starter example with intentionally inactive sample code",
}

local severity_names = {
  [vim.diagnostic.severity.ERROR] = "error",
  [vim.diagnostic.severity.WARN] = "warning",
}

-- In normal interactive Neovim, LazyVim/Mason may point `lua_ls` at a Mason
-- install under the user's home directory. The Makefile runs this script inside
-- `nix develop`, where `lua-language-server` is available on PATH. Prefer that
-- binary so preflight uses the repo's pinned dev-shell tool instead of mutable
-- Mason state.
if vim.fn.executable("lua-language-server") == 1 then
  vim.lsp.config("lua_ls", {
    cmd = { "lua-language-server" },
  })
end

local function write_error(message)
  io.stdout:write(message .. "\n")
end

local function sorted_lua_files()
  -- Open files in a stable order so failures print deterministically.
  local files = vim.fn.glob(nvim_dir .. "/**/*.lua", false, true)
  table.sort(files)
  return files
end

local buffers = {}

-- Opening each Lua file as a real buffer triggers LazyVim's normal LSP attach
-- flow. We keep the buffer ids so diagnostics can be collected after LuaLS has
-- had time to analyze them.
for _, file in ipairs(sorted_lua_files()) do
  if not ignored_files[file] then
    vim.cmd("edit " .. vim.fn.fnameescape(file))
    table.insert(buffers, vim.api.nvim_get_current_buf())
  end
end

-- `vim.diagnostic.get()` only returns useful results after LuaLS attaches. If
-- LuaLS never attaches, that should fail the target; otherwise preflight could
-- pass merely because the diagnostic source did not start.
local lsp_ready = vim.wait(15000, function()
  for _, buf in ipairs(buffers) do
    if #vim.lsp.get_clients({ bufnr = buf, name = "lua_ls" }) == 0 then
      return false
    end
  end

  return true
end, 100)

if not lsp_ready then
  write_error("lua_ls did not attach to every Lua buffer")
  vim.cmd("cquit 1")
end

-- Give LuaLS a short extra window after attach to publish diagnostics for all
-- opened buffers, then treat warnings and errors as build failures. Hints and
-- information-level diagnostics are intentionally ignored because they are too
-- noisy for preflight.
vim.defer_fn(function()
  local failures = 0

  for _, buf in ipairs(buffers) do
    local file = vim.api.nvim_buf_get_name(buf)
    local diagnostics = vim.diagnostic.get(buf, {
      severity = { min = vim.diagnostic.severity.WARN },
    })

    table.sort(diagnostics, function(a, b)
      if a.lnum == b.lnum then
        return a.col < b.col
      end

      return a.lnum < b.lnum
    end)

    for _, diagnostic in ipairs(diagnostics) do
      -- Convert LuaLS's 0-based positions to conventional file:line:column
      -- output so terminal errors are easy to jump to.
      failures = failures + 1
      local severity = severity_names[diagnostic.severity] or "diagnostic"
      local code = diagnostic.code and (" [" .. diagnostic.code .. "]") or ""
      local message = diagnostic.message:gsub("\n", " ")

      write_error(
        string.format("%s:%d:%d: %s%s: %s", file, diagnostic.lnum + 1, diagnostic.col + 1, severity, code, message)
      )
    end
  end

  if failures > 0 then
    write_error(string.format("%d Lua language diagnostics found", failures))
    vim.cmd("cquit 1")
    return
  end

  vim.cmd("quitall")
end, 5000)
