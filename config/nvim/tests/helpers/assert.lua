local M = {}

function M.equal(actual, expected, message)
  if actual ~= expected then
    error(message or string.format("expected %s, got %s", vim.inspect(expected), vim.inspect(actual)), 2)
  end
end

function M.truthy(value, message)
  if not value then
    error(message or string.format("expected truthy value, got %s", vim.inspect(value)), 2)
  end
end

function M.skip(reason)
  error({ skip = true, reason = reason }, 2)
end

return M
