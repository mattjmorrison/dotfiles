local function grid_line(colors)
  local text = {}
  for index, color in ipairs(colors) do
    if index > 1 then
      text[#text + 1] = { "██", hl = "DashboardRubikBorder" }
    end
    for _ = 1, 5 do
      text[#text + 1] = { "██", hl = "DashboardRubik" .. color }
    end
  end
  return { align = "center", text = text }
end

local function border_line()
  local text = {}
  for _ = 1, 17 do
    text[#text + 1] = { "██", hl = "DashboardRubikBorder" }
  end
  return { align = "center", text = text }
end

return {
  {
    "snacks.nvim",
    opts = function(_, opts)
      opts.dashboard = opts.dashboard or {}

      vim.api.nvim_set_hl(0, "DashboardRubikBorder", { fg = "#000000" })
      vim.api.nvim_set_hl(0, "DashboardRubikRed", { fg = "#e06c75" })
      vim.api.nvim_set_hl(0, "DashboardRubikLightBlue", { fg = "#8cc8ff" })
      vim.api.nvim_set_hl(0, "DashboardRubikBlue", { fg = "#61afef" })
      vim.api.nvim_set_hl(0, "DashboardRubikDarkBlue", { fg = "#2f6fb3" })
      vim.api.nvim_set_hl(0, "DashboardRubikBlueGreen", { fg = "#6fc9bb" })
      vim.api.nvim_set_hl(0, "DashboardRubikDarkBlueGreen", { fg = "#4c9a8d" })
      vim.api.nvim_set_hl(0, "DashboardRubikLightGreen", { fg = "#b7e880" })
      vim.api.nvim_set_hl(0, "DashboardRubikGreen", { fg = "#98c379" })
      vim.api.nvim_set_hl(0, "DashboardRubikDarkGreen", { fg = "#5f8f45" })
      vim.api.nvim_set_hl(0, "DashboardRubikYellow", { fg = "#e5c07b" })
      vim.api.nvim_set_hl(0, "DashboardRubikWhite", { fg = "#dcdfe4" })
      vim.api.nvim_set_hl(0, "DashboardRubikOrange", { fg = "#d19a66" })

      opts.dashboard.sections = {
        { padding = 1 },
        grid_line({ "LightBlue", "Blue", "DarkBlue" }),
        grid_line({ "LightBlue", "Blue", "DarkBlue" }),
        grid_line({ "LightBlue", "Blue", "DarkBlue" }),
        grid_line({ "LightBlue", "Blue", "DarkBlue" }),
        grid_line({ "LightBlue", "Blue", "DarkBlue" }),
        border_line(),
        grid_line({ "BlueGreen", "Red", "DarkBlueGreen" }),
        grid_line({ "BlueGreen", "Red", "DarkBlueGreen" }),
        grid_line({ "BlueGreen", "Red", "DarkBlueGreen" }),
        grid_line({ "BlueGreen", "Red", "DarkBlueGreen" }),
        grid_line({ "BlueGreen", "Red", "DarkBlueGreen" }),
        border_line(),
        grid_line({ "LightGreen", "Green", "DarkGreen" }),
        grid_line({ "LightGreen", "Green", "DarkGreen" }),
        grid_line({ "LightGreen", "Green", "DarkGreen" }),
        grid_line({ "LightGreen", "Green", "DarkGreen" }),
        grid_line({ "LightGreen", "Green", "DarkGreen" }),
        { section = "keys", gap = 1, padding = 1 },
        { section = "startup" },
      }
    end,
  },
}
