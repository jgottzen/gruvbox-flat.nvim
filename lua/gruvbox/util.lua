local hsluv = require("gruvbox.hsluv")

local util = {}

local white = "#ffffff"

---@param hex_str string
---@return integer[]
local function hex_to_rgb(hex_str)
  local hex = "[abcdef0-9][abcdef0-9]"
  local pat = "^#(" .. hex .. ")(" .. hex .. ")(" .. hex .. ")$"
  hex_str = string.lower(hex_str)

  assert(string.find(hex_str, pat) ~= nil, "hex_to_rgb: invalid hex_str: " .. tostring(hex_str))

  local r, g, b = string.match(hex_str, pat)
  return { tonumber(r, 16), tonumber(g, 16), tonumber(b, 16) }
end

---@param color1 string foreground color
---@param color2 string background color
---@param alpha number number between 0 and 1. 0 results in bg, 1 results in fg
---@return string
function util.blend(color1, color2, alpha)
  local hex_color1 = hex_to_rgb(color1)
  local hex_color2 = hex_to_rgb(color2)

  ---@param i integer
  ---@return integer
  local function blend_channel(i)
    local ret = (alpha * hex_color1[i] + ((1 - alpha) * hex_color2[i]))
    return math.floor(math.min(math.max(0, ret), 255) + 0.5)
  end

  return string.format("#%02X%02X%02X", blend_channel(1), blend_channel(2), blend_channel(3))
end

---@param color1 string
---@param amount integer
---@param color2 string
---@return string
function util.darken(color1, amount, color2)
  return util.blend(color1, color2, math.abs(amount))
end

---@param color1 string
---@param amount integer
---@param color2? string
---@return string
function util.lighten(color1, amount, color2)
  return util.blend(color1, color2 or white, math.abs(amount))
end

---@param color string
---@param percentage integer
---@return string
function util.brighten(color, percentage)
  local hsl = hsluv.hex_to_hsluv(color)
  local larp_space = 100 - hsl[3]
  if percentage < 0 then
    larp_space = hsl[3]
  end
  hsl[3] = hsl[3] + larp_space * percentage
  return hsluv.hsluv_to_hex(hsl)
end

return util
