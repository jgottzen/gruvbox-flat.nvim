local util = require("gruvbox.util")

local M = {}

---@param config GruvboxFlatConfig
---@return GruvboxFlatColorPaletter
function M.setup(config)
  ---Color Palette
  ---@class GruvboxFlatColorPaletter
  local colors = {
    bg0 = "#282626",
    bg = "#32302f",
    bg1 = "#45403d",
    bg2 = "#282828",
    bg_visual = "#45403d",
    bg_highlight = "#5a524c",
    border = "#5a524c",
    fg = "#d4be98",
    fg_light = "#ddc7a1",
    fg_dark = "#5a524c",
    gray = "#aa9987",
    dark_gray = "#7c6f64",
    blue = "#7daea3",
    blue_bright = "#0087a0",
    aqua = "#89b482",
    purple = "#d3869b",
    orange = "#e78a4e",
    orange_light = "#a96b2c",
    yellow = "#d8a657",
    yellow_dark = "#b47109",
    green = "#a9b665",
    green_light = "#6f8352",
    green_dark = "#1e2718",
    red = "#ea6962",
    red_dark = "#c14a4a",
    pink = "#ae5858",
  }

  if config.style == "dark" then
    colors.bg = "#282828"
    colors.bg0 = util.darken("#282828", 0.8, "#000000")
    colors.bg1 = "#32302f"
    colors.bg2 = "#242424"
    colors.bg_highlight = "#45403d"
  elseif config.style == "hard" then
    colors.bg = "#1d2021"
    colors.bg0 = util.darken("#1d2021", 0.8, "#000000")
    colors.bg1 = util.lighten("#1d2021", 0.97)
    colors.bg2 = "#17191a"
    colors.bg_visual = "#3c3836"
    colors.bg_highlight = "#3c3836"
    colors.border = "#3c3836"
    colors.dark_gray = "#6a635d"
  end

  colors.git = {
    add = colors.green_light,
    change = colors.yellow_dark,
    delete = colors.red_dark,
    ignore = colors.fg_dark,
  }
  colors.diff = {
    add = util.darken(colors.git.add, 0.15, colors.bg),
    change = util.darken(colors.git.change, 0.15, colors.bg),
    delete = util.darken(colors.git.delete, 0.15, colors.bg),
    text = colors.fg_dark,
  }

  colors.git_signs = {
    add = util.brighten(colors.green_light, 0.2),
    change = util.brighten(colors.orange_light, 0.2),
    delete = util.brighten(colors.pink, 0.2),
  }

  colors.error = colors.red_dark
  colors.warn = colors.yellow
  colors.info = colors.blue
  colors.hint = colors.aqua

  for name, color in pairs(config.colors) do
    if colors[color] then
      colors[name] = colors[color]
    else
      colors[name] = color
    end
  end

  M.colors = colors
  return colors
end

return M
