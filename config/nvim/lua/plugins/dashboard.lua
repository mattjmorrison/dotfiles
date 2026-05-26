local section_size = 6

local function grid_line(colors, padding)
  local text = {}
  for index, color in ipairs(colors) do
    if index > 1 then
      text[#text + 1] = { "██", hl = "DashboardRubikBorder" }
    end
    for _ = 1, section_size do
      text[#text + 1] = { "██", hl = "DashboardRubik" .. color }
    end
  end
  return { align = "center", text = text, padding = padding }
end

local function border_line()
  local text = {}
  for _ = 1, section_size * 3 + 2 do
    text[#text + 1] = { "██", hl = "DashboardRubikBorder" }
  end
  return { align = "center", text = text }
end

return {
  {
    "snacks.nvim",
    opts = function(_, opts)
      opts.dashboard = opts.dashboard or {}

      vim.api.nvim_set_hl(0, "DashboardRubikBorder", { fg = "#0c1a3f" })
      vim.api.nvim_set_hl(0, "DashboardRubikRed", { fg = "#df1c3c" })
      vim.api.nvim_set_hl(0, "DashboardRubikLightBlue", { fg = "#6acce3" })
      vim.api.nvim_set_hl(0, "DashboardRubikBlue", { fg = "#2fb2ea" })
      vim.api.nvim_set_hl(0, "DashboardRubikDarkBlue", { fg = "#328bcb" })
      vim.api.nvim_set_hl(0, "DashboardRubikBlueGreen", { fg = "#4cbd9f" })
      vim.api.nvim_set_hl(0, "DashboardRubikDarkBlueGreen", { fg = "#8dc44d" })
      vim.api.nvim_set_hl(0, "DashboardRubikLightGreen", { fg = "#3ab676" })
      vim.api.nvim_set_hl(0, "DashboardRubikGreen", { fg = "#5cba4a" })
      vim.api.nvim_set_hl(0, "DashboardRubikDarkGreen", { fg = "#54ba4d" })
      vim.api.nvim_set_hl(0, "DashboardRubikYellow", { fg = "#e5c07b" })
      vim.api.nvim_set_hl(0, "DashboardRubikWhite", { fg = "#dcdfe4" })
      vim.api.nvim_set_hl(0, "DashboardRubikOrange", { fg = "#d19a66" })

      opts.dashboard.sections = {
        grid_line({ "LightBlue", "Blue", "DarkBlue" }),
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
        grid_line({ "BlueGreen", "Red", "DarkBlueGreen" }),
        border_line(),
        grid_line({ "LightGreen", "Green", "DarkGreen" }),
        grid_line({ "LightGreen", "Green", "DarkGreen" }),
        grid_line({ "LightGreen", "Green", "DarkGreen" }),
        grid_line({ "LightGreen", "Green", "DarkGreen" }),
        grid_line({ "LightGreen", "Green", "DarkGreen" }),
        grid_line({ "LightGreen", "Green", "DarkGreen" }, 1),
        { section = "keys", gap = 1, padding = 2 },
        { section = "startup" },
      }
    end,
  },
}
