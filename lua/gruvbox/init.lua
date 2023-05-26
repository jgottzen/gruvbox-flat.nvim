local M = {}

---@class GruvboxFlatConfig
---@field style "dark"|"hard"|nil
---@field transparent boolean
---@field hide_inactive_statusline boolean
---@field colors table<string, string>
---@field theme table<string, GruvboxFlatHighlightGroup>
---@field dark_float boolean
M.config = {
  style = nil,
  transparent = false,
  italics = {
    comments = true,
    keywords = true,
    functions = false,
    variables = false,
  },
  hide_inactive_statusline = false,
  colors = {},
  theme = {},
  dark_float = true,
}

---@param opts GruvboxFlatConfig
function M.setup(opts)
  M.config = vim.tbl_deep_extend("force", M.config, opts or {})
end

function M.colorscheme()
  vim.cmd.highlight("clear")

  vim.o.termguicolors = true
  vim.g.colors_name = "gruvbox-flat"

  local theme = require("gruvbox.theme").setup()
  for name, hl in pairs(theme) do
    vim.api.nvim_set_hl(0, name, hl)
  end
end

return M
