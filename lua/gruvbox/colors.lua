local util = require("gruvbox.util")

local M = {}

---@param config? GruvboxFlatConfig
---@return GruvboxFlatColorScheme
function M.setup(config)
  config = config or require("gruvbox.config")

  -- Color Palette
  ---@class GruvboxFlatColorScheme
  ---@field none "NONE"
  ---@field reverse "reverse"
  ---@field bg string
  ---@field bg2 string
  ---@field bg_visual string
  ---@field border string
  ---@field border_highlight string
  ---@field line_cursor string
  ---@field prompt_border string
  ---@field bg_highlight string
  ---@field fg string
  ---@field fg_light string
  ---@field fg_dark string
  ---@field tree_normal string
  ---@field comment string
  ---@field fg_gutter string
  ---@field dark5 string
  ---@field blue string
  ---@field aqua string
  ---@field purple string
  ---@field orange string
  ---@field yellow string
  ---@field yellow2 string
  ---@field bg_yellow string
  ---@field green string
  ---@field red string
  ---@field red1 string
  ---@field black string
  ---@field git { delete: string, add: string, change: string, bg_red: string, ignore: string }
  ---@field gitSigns { delete: string, add: string, change: string }
  ---@field diff { delete: string, add: string, change: string, text: string }
  ---@field bg_popup string
  ---@field bg_statusline string
  ---@field bg_sidebar string
  ---@field bg_float string
  ---@field bg_search string
  ---@field fg_search string
  ---@field fg_sidebar string
  ---@field error string
  ---@field warning string
  ---@field info string
  ---@field hint string
  local colors = {}

  colors = {
    none = "NONE",
    reverse = "reverse",
    bg = "#32302f",
    bg2 = "#282828",
    bg_visual = "#45403d",
    border = "#5a524c",
    line_cursor = "#45403d",
    prompt_border = "#ddc7a1",
    bg_highlight = "#5a524c",
    fg = "#d4be98",
    fg_light = "#ddc7a1",
    fg_dark = "#d4be98",
    tree_normal = "#aa9987",
    comment = "#7c6f64",
    fg_gutter = "#5a524c",
    dark5 = "#5a524c",
    blue = "#7daea3",
    aqua = "#89b482",
    purple = "#d3869b",
    orange = "#e78a4e",
    yellow = "#d8a657",
    yellow2 = "#b47109",
    bg_yellow = "#a96b2c",
    green = "#a9b665",
    red = "#ea6962",
    red1 = "#c14a4a",
    black = "#1d2021",
    git = { delete = "#c14a4a", add = "#6f8352", change = "#b47109", bg_red = "#ae5858" },
    gitSigns = { delete = "#ae5858", add = "#6f8352", change = "#a96b2c" },
  }

  -- set the background to dark
  if vim.g.gruvbox_flat_style == "dark" then
    colors.bg = "#282828"
    colors.bg2 = "#242424"
    colors.bg_highlight = "#45403d"
    colors.line_cursor = "#32302f"
    colors.prompt_border = "#45403d"

  -- set the background to hard
  elseif vim.g.gruvbox_flat_style == "hard" then
    colors.bg = "#1d2021"
    colors.bg2 ="#17191a"
    colors.bg_highlight = "#3c3836"
    colors.line_cursor = util.lighten(colors.bg, 0.97) -- util.darken("#282828", 0.90)
    colors.border = colors.bg_highlight
    colors.prompt_border = "#45403d"
    colors.bg_visual = "#3c3836"
    colors.comment = "#6a635d"
  end

  util.bg = colors.bg

  colors.diff = {
    add = util.darken(colors.git.add, 0.15),
    delete = util.darken(colors.git.delete, 0.15),
    change = util.darken(colors.git.change, 0.15),
    text = colors.fg_gutter,
  }

  colors.gitSigns = {
    add = util.brighten(colors.gitSigns.add, 0.2),
    change = util.brighten(colors.gitSigns.change, 0.2),
    delete = util.brighten(colors.gitSigns.delete, 0.2),
  }

  colors.git.ignore = colors.fg_gutter
  colors.black = util.darken(colors.bg, 0.8, "#000000")
  colors.border_highlight = colors.border

  -- Popups and statusline always get a dark background
  colors.bg_popup = colors.bg2
  colors.bg_statusline = colors.bg2

  -- Sidebar and Floats are configurable
  colors.bg_sidebar = config.darkSidebar and colors.bg2 or colors.bg
  colors.bg_float = config.darkFloat and colors.bg2 or colors.bg

  colors.bg_search = colors.bg_highlight -- Disabled
  colors.fg_search = colors.fg -- Disabled
  colors.fg_sidebar = colors.fg_dark

  colors.error = colors.red1
  colors.warning = colors.yellow
  colors.info = colors.blue
  colors.hint = colors.aqua

  util.color_overrides(colors, config)

  M.colors = colors
  return colors
end

return M
