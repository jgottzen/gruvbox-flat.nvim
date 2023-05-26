# Gruvbox Flat

A dark beautiful Neovim theme written in Lua.
- Forked from [Gruvbox Flat](https://github.com/eddyekofo94/gruvbox-flat.nvim)

<img width="1540" alt="gruvbox flat" src="https://github.com/jgottzen/gruvbox-flat.nvim/assets/905941/0fbb2b48-4775-469b-a34e-6de60b11edc8">

## ✨ Features

- supports the latest Neovim 0.8 features like TreeSitter and LSP
- vim terminal colors

## ⚡️ Requirements

- Neovim >= 0.8.0

## 📦 Installation

Install the theme with your preferred package manager:

[packer](https://github.com/wbthomason/packer.nvim)

```lua
use("jgottzen/gruvbox-flat.nvim")
```

[lazy.nvim](https://github.com/folke/lazy.nvim)

```lua
{ "jgottzen/gruvbox-flat.nvim", priority = 1000 }
```

## 🚀 Usage

Enable the colorscheme:

```lua
vim.cmd.colorscheme("gruvbox-flat")
```

## ⚙️ Configuration

The default settings are:

```lua
require("gruvbox").setup({
  style = nil, -- "dark"|"hard"|nil
  transparent = false,
  italics = {
    comments = true,
    keywords = true,
    functions = false,
    variables = false,
  },
  hide_inactive_statusline = false,
  colors = {}, -- table<string, string>, change default color values, the value can refer to another color by name
  theme = {}, -- table<string, GruvboxFlatHighlightGroup>, override or add highlight groups, color values can refer to a color by name
  dark_float = true,
})
```

An example:
```lua
require("gruvbox").setup({
  style = "dark",
  colors = {
    error = "red",
  },
  theme = {
    -- vim-illuminate highlighting causes the selection to be indistinguishable from its illumination,
    -- so we set visual to be darker
    Visual = { bg = "bg0" },
    VisualNOS = { bg = "bg0" },

    FloatBorder = { bg = "bg2" },

    -- Fix the separator between extension and main statusline being too dark,
    StatusLine = { bg = "bg_visual" },
    StatusLineNC = { bg = "bg_visual" },

    TabLineFill = { bg = "#1d2021" },

    -- symbols-outline
    FocusedSymbol = { fg = "bg1", bg = "orange_light", bold = true, italic = true },
  },
  dark_sidebar = false,
})
```
