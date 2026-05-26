---@diagnostic disable: undefined-global

local test_dir = vim.fn.expand("<sfile>:p:h")
local nvim_dir = vim.fn.fnamemodify(test_dir, ":h")

vim.o.more = false
vim.opt.runtimepath:prepend(nvim_dir)
package.path = nvim_dir .. "/?.lua;" .. nvim_dir .. "/?/init.lua;" .. package.path

local config_ok, config_err = pcall(function()
  vim.cmd("source " .. vim.fn.fnameescape(nvim_dir .. "/init.lua"))
end)
if not config_ok then
  io.stdout:write("Failed to source config/nvim/init.lua\n" .. tostring(config_err) .. "\n")
  vim.cmd("cquit 1")
end

local failures = 0
local skipped = 0
local passed = 0

local function write_line(message)
  io.stdout:write(message .. "\n")
end

local function write_error(message)
  io.stdout:write(message .. "\n")
end

local function indent(message)
  return tostring(message):gsub("\n", "\n  ")
end

local function traceback(err)
  if type(err) == "table" and err.skip then
    return err
  end

  return debug.traceback(tostring(err), 2)
end

local function sorted_spec_files()
  local files = vim.fn.glob(test_dir .. "/specs/*_spec.lua", false, true)
  table.sort(files)
  return files
end

for _, file in ipairs(sorted_spec_files()) do
  local ok, spec = xpcall(function()
    return dofile(file)
  end, traceback)
  if not ok then
    failures = failures + 1
    write_error("not ok " .. file .. "\n  " .. indent(spec))
  else
    for name, test in pairs(spec) do
      local test_ok, err = xpcall(test, traceback)
      if test_ok then
        passed = passed + 1
        write_line("ok " .. name)
      elseif type(err) == "table" and err.skip then
        skipped = skipped + 1
        write_line("skip " .. name .. ": " .. err.reason)
      else
        failures = failures + 1
        write_error("not ok " .. name .. "\n  " .. indent(err))
      end
    end
  end
end

write_line(string.format("%d passed, %d skipped, %d failed", passed, skipped, failures))

if failures > 0 then
  vim.cmd("cquit 1")
end

vim.cmd("quitall")
