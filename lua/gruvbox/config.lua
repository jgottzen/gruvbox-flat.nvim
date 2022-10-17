---@class GruvboxFlatConfig
---@field transparent boolean
---@field commentStyle string
---@field keywordStyle string
---@field functionStyle string
---@field variableStyle string
---@field hideInactiveStatusline boolean
---@field terminalColors boolean
---@field sidebars string[]
---@field colors table<string, string>
---@field theme table<string, {}>
---@field dev boolean
---@field darkFloat boolean
---@field darkSidebar boolean
---@field transform_colors boolean
local config

-- shim vim for kitty and other generators
vim = vim or { g = {}, o = {} }

---@generic T
---@param key string
---@param default T
---@return T
local function opt(key, default)
  key = "gruvbox_" .. key
  if vim.g[key] == nil then
    return default
  end
  if vim.g[key] == 0 then
    return false
  end
  return vim.g[key]
end

config = {
  transparent = opt("transparent", false),
  commentStyle = opt("italic_comments", true) and "italic" or "NONE",
  keywordStyle = opt("italic_keywords", true) and "italic" or "NONE",
  functionStyle = opt("italic_functions", false) and "italic" or "NONE",
  variableStyle = opt("italic_variables", false) and "italic" or "NONE",
  hideInactiveStatusline = opt("hide_inactive_statusline", false),
  terminalColors = opt("terminal_colors", true),
  sidebars = opt("sidebars", {}),
  colors = opt("colors", {}),
  theme = opt("theme", {}),
  dev = opt("dev", false),
  darkFloat = opt("dark_float", true),
  darkSidebar = opt("dark_sidebar", true),
  transform_colors = false,
}

return config
