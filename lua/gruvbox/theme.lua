local util = require("gruvbox.util")

local M = {}

---@param colors GruvboxFlatColorPaletter
local function set_terminal_colors(colors)
  local dark = colors.dark_gray
  -- dark
  vim.g.terminal_color_0 = dark
  vim.g.terminal_color_8 = dark

  -- light
  vim.g.terminal_color_7 = colors.fg
  vim.g.terminal_color_15 = colors.fg

  -- colors
  vim.g.terminal_color_1 = colors.red
  vim.g.terminal_color_9 = colors.red

  vim.g.terminal_color_2 = colors.green
  vim.g.terminal_color_10 = colors.green

  vim.g.terminal_color_3 = colors.yellow
  vim.g.terminal_color_11 = colors.yellow

  vim.g.terminal_color_4 = colors.blue
  vim.g.terminal_color_12 = colors.blue

  vim.g.terminal_color_5 = colors.purple
  vim.g.terminal_color_13 = colors.purple

  vim.g.terminal_color_6 = colors.aqua
  vim.g.terminal_color_14 = colors.aqua
end

---@class GruvboxFlatHighlightGroup
---@field fg? string
---@field bg? string
---@field sp? string
---@field link? string
---@field default? boolean
---@field bold? boolean
---@field italic? boolean
---@field undercurl? boolean
---@field underline? boolean
---@field strikethrough? boolean

---@return table<string, GruvboxFlatHighlightGroup>
function M.setup()
  local config = require("gruvbox").config
  local c = require("gruvbox.colors").setup(config)

  -- Sidebar and Floats are configurable
  local bg_float = config.dark_float and c.bg2 or c.bg

  set_terminal_colors(c)

  ---@type table<string, GruvboxFlatHighlightGroup>
  local theme = {
    -- base nvim groups
    Comment = { fg = c.dark_gray, italic = config.italics.comments }, -- any comment
    ColorColumn = { bg = c.bg_visual }, -- used for the columns set with 'colorcolumn'
    Conceal = { fg = c.fg_dark }, -- placeholder characters substituted for concealed text (see 'conceallevel')
    Cursor = { fg = c.bg, bg = c.fg }, -- character under the cursor
    iCursor = { link = "Cursor" },
    lCursor = { link = "Cursor" },
    vCursor = { link = "Cursor" },
    CurSearch = { link = "IncSearch" },
    CursorIM = { fg = c.bg, bg = c.fg }, -- like Cursor, but used when in IME mode |CursorIM|
    CursorColumn = { bg = c.bg1 }, -- Screen-column at the cursor, when 'cursorcolumn' is set.
    CursorLine = { bg = c.bg1 }, -- Screen-line at the cursor, when 'cursorline' is set.  Low-priority if foreground (ctermfg OR guifg) is not set.
    CursorLineNr = { fg = c.purple }, -- Like LineNr when 'cursorline' or 'relativenumber' is set for the cursor line.
    DiffAdd = { bg = c.diff.add }, -- diff mode: Added line |diff.txt|
    DiffChange = { bg = c.diff.change }, -- diff mode: Changed line |diff.txt|
    DiffDelete = { bg = c.diff.delete }, -- diff mode: Deleted line |diff.txt|
    DiffText = { bg = c.diff.text }, -- diff mode: Changed text within a changed line |diff.txt|
    Directory = { fg = c.blue }, -- directory names (and other special names in listings)
    EndOfBuffer = { fg = c.bg }, -- filler lines (~) after the end of the buffer.  By default, this is highlighted like |hl-NonText|.
    ErrorMsg = { fg = c.error }, -- error messages on the command line
    FloatBorder = { fg = c.border },
    Folded = { fg = c.blue, bg = c.fg_dark }, -- line used for closed folds
    FoldColumn = { bg = c.bg, fg = c.fg_dark }, -- 'foldcolumn'
    IncSearch = { bg = c.orange, fg = c.bg0 }, -- 'incsearch' highlighting; also used for the text replaced with ":s///c"
    LineNr = { fg = c.fg_dark }, -- Line number for ":number" and ":#" commands, and when 'number' or 'relativenumber' option is set.
    MatchParen = { fg = util.lighten(c.purple, 0.95), bold = true }, -- The character under the cursor or just before it, if it is a paired bracket, and its match. |pi_paren.txt|
    MoreMsg = { fg = c.blue }, -- |more-prompt|
    ModeMsg = { fg = c.fg, bold = true }, -- 'showmode' message (e.g., "-- INSERT -- ")
    MsgArea = { fg = c.fg }, -- Area for messages and cmdline
    -- MsgSeparator= { }, -- Separator for scrolled messages, `msgsep` flag of 'display'
    NonText = { fg = c.bg_highlight }, -- '@' at the end of the window, characters from 'showbreak' and other characters that do not really exist in the text (e.g., ">" displayed when a double-wide character doesn't fit at the end of the line). See also |hl-EndOfBuffer|.
    Normal = { fg = c.fg, bg = not config.transparent and c.bg or nil }, -- normal text
    NormalNC = { fg = c.fg, bg = not config.transparent and c.bg or nil }, -- normal text in non-current windows
    NormalFloat = { fg = c.fg, bg = bg_float }, -- Normal text in floating windows.
    Pmenu = { bg = c.bg2, fg = c.fg }, -- Popup menu: normal item.
    PmenuSel = { bg = util.darken(c.fg_dark, 0.8, c.bg) }, -- Popup menu: selected item.
    PmenuSbar = { bg = util.lighten(c.bg2, 0.95) }, -- Popup menu: scrollbar.
    PmenuThumb = { bg = c.fg_dark }, -- Popup menu: Thumb of the scrollbar.
    Question = { fg = c.blue }, -- |hit-enter| prompt and yes/no questions
    QuickFixLine = { bg = c.bg_visual, bold = true }, -- Current |quickfix| item in the quickfix window. Combined with |hl-CursorLine| when the cursor is there.
    SignColumn = { bg = not config.transparent and c.bg or nil, fg = c.fg_dark }, -- column where |signs| are displayed
    Search = { bg = c.bg_highlight, fg = c.fg }, -- Last search pattern highlighting (see 'hlsearch').  Also used for similar items that need to stand out.
    SpecialKey = { fg = c.fg_dark }, -- Unprintable characters: text displayed differently from what it really is.  But not 'listchars' whitespace. |hl-Whitespace|
    SpellBad = { sp = c.error, undercurl = true }, -- Word that is not recognized by the spellchecker. |spell| Combined with the highlighting used otherwise.
    SpellCap = { sp = c.warn, undercurl = true }, -- Word that should start with a capital. |spell| Combined with the highlighting used otherwise.
    SpellLocal = { sp = c.info, undercurl = true }, -- Word that is recognized by the spellchecker as one that is used in another region. |spell| Combined with the highlighting used otherwise.
    SpellRare = { sp = c.hint, undercurl = true }, -- Word that is recognized by the spellchecker as one that is hardly ever used.  |spell| Combined with the highlighting used otherwise.
    StatusLine = { fg = c.fg, bg = c.bg2 }, -- status line of current window
    StatusLineNC = { fg = c.fg_dark, bg = c.bg2 }, -- status lines of not-current windows Note: if this is equal to "StatusLine" Vim will use "^^^" in the status line of the current window.
    Substitute = { bg = c.red, fg = c.bg0 }, -- |:substitute| replacement text highlighting
    TabLine = { bg = c.bg0, fg = c.fg_dark }, -- tab pages line, not active tab page label
    TabLineFill = { bg = c.bg0 }, -- tab pages line, where there are no labels
    TabLineSel = { fg = c.bg0, bg = c.blue }, -- tab pages line, active tab page label
    -- TermCursor  = { }, -- cursor in a focused terminal
    -- TermCursorNC= { }, -- cursor in an unfocused terminal
    Title = { fg = c.blue, bold = true }, -- titles for output from ":set all", ":autocmd" etc.
    VertSplit = { fg = c.bg_highlight }, -- the column separating vertically split windows
    Visual = { bg = c.bg_visual }, -- Visual mode selection
    VisualNOS = { bg = c.bg_visual }, -- Visual mode selection when vim is "Not Owning the Selection".
    WarningMsg = { fg = c.warn }, -- warning messages
    WildMenu = { bg = c.bg_visual }, -- current match in 'wildmenu' completion
    WinBar = { fg = c.fg, bg = c.bg2 },
    WinBarNC = { fg = c.fg_dark, bg = c.bg2 },
    -- WinSeparator = {}, -- use default link to VertSplit
    Whitespace = { fg = c.fg_dark }, -- "nbsp", "space", "tab" and "trail" in 'listchars'

    -- These groups are not listed as default vim groups,
    -- but they are defacto standard group names for syntax highlighting.
    -- commented out groups should chain up to their "preferred" group by default,
    -- Uncomment and edit if you want more specific syntax highlighting.

    Constant = { fg = c.orange }, -- (preferred) any constant
    -- Number        = { }, --   a number constant: 234, 0xff
    -- Boolean       = { }, --  a boolean constant: TRUE, false
    -- Float         = { }, --    a floating point constant: 2.3e10
    String = { fg = c.green }, --   a string constant: "this is a string"
    Character = { fg = c.green }, --  a character constant: 'c', '\n'

    Identifier = { fg = c.red, italic = config.italics.variables }, -- (preferred) any variable name
    Function = { fg = c.blue, italic = config.italics.functions }, -- function name (also: methods for classes)

    Statement = { fg = c.purple }, -- (preferred) any statement
    -- Conditional   = { }, --  if, then, else, endif, switch, etc.
    -- Repeat        = { }, --   for, do, while, etc.
    -- Label         = { }, --    case, default, etc.
    -- Exception     = { }, --  try, catch, throw
    Operator = { fg = c.red }, -- "sizeof", "+", "*", etc.
    Keyword = { fg = c.aqua, italic = config.italics.keywords }, --  any other keyword

    PreProc = { fg = c.aqua }, -- (preferred) generic Preprocessor
    -- Include       = { }, --  preprocessor #include
    -- Define        = { }, --   preprocessor #define
    -- Macro         = { }, --    same as Define
    -- PreCondit     = { }, --  preprocessor #if, #else, #endif, etc.

    Type = { fg = c.yellow }, -- (preferred) int, long, char, etc.
    -- StorageClass  = { }, -- static, register, volatile, etc.
    -- Structure     = { }, --  struct, union, enum, etc.
    -- Typedef       = { }, --  A typedef

    Special = { fg = c.red }, -- (preferred) any special symbol
    -- SpecialChar   = { }, --  special character in a constant
    -- Tag           = { }, --    you can use CTRL-] on this
    -- Delimiter     = { }, --  character that needs attention
    -- SpecialComment= { }, -- special things inside a comment
    -- Debug         = { }, --    debugging statements

    Underlined = { underline = true }, -- (preferred) text that stands out, HTML links
    Bold = { bold = true },
    Italic = { italic = true },

    -- ("Ignore", below, may be invisible...)
    -- Ignore = { }, -- (preferred) left blank, hidden  |hl-Ignore|

    Error = { fg = c.error }, -- (preferred) any erroneous construct
    Todo = { bg = c.yellow, fg = c.bg }, -- (preferred) anything that needs extra attention; mostly the keywords TODO FIXME and XXX

    DiagnosticError = { fg = c.error }, -- Used as the base highlight group. Other LspDiagnostic highlights link to this by default (except Underline)
    DiagnosticSignError = { fg = c.error }, -- Used as the base highlight group. Other LspDiagnostic highlights link to this by default (except Underline)
    DiagnosticUnderlineError = { undercurl = true, sp = c.error }, -- Used to underline "Error" diagnostics

    DiagnosticWarn = { fg = c.warn }, -- Used as the base highlight group. Other LspDiagnostic highlights link to this by default (except Underline)
    DiagnosticSignWarn = { fg = c.warn }, -- Used as the base highlight group. Other LspDiagnostic highlights link to this by default (except Underline)
    DiagnosticUnderlineWarn = { undercurl = true, sp = c.warn }, -- Used to underline "Warning" diagnostics

    DiagnosticInfo = { fg = c.info }, -- Used as the base highlight group. Other LspDiagnostic highlights link to this by default (except Underline)
    DiagnosticSignInfo = { fg = c.info }, -- Used as the base highlight group. Other LspDiagnostic highlights link to this by default (except Underline)
    DiagnosticUnderlineInfo = { undercurl = true, sp = c.info }, -- Used to underline "Information" diagnostics

    DiagnosticHint = { fg = c.hint }, -- Used as the base highlight group. Other LspDiagnostic highlights link to this by default (except Underline)
    DiagnosticSignHint = { fg = c.hint }, -- Used as the base highlight group. Other LspDiagnostic highlights link to this by default (except Underline)
    DiagnosticUnderlineHint = { undercurl = true, sp = c.hint }, -- Used to underline "Hint" diagnostics

    DiagnosticFloatingError = { fg = c.error },
    DiagnosticFloatingWarn = { fg = c.warn },
    DiagnosticFloatingInfo = { fg = c.info },
    DiagnosticFloatingHint = { fg = c.hint },

    DiagnosticVirtualTextError = { fg = c.error }, -- Used for "Error" diagnostic virtual text
    DiagnosticVirtualTextWarning = { fg = c.warn }, -- Used for "Warning" diagnostic virtual text
    DiagnosticVirtualTextInformation = { fg = c.info }, -- Used for "Information" diagnostic virtual text
    DiagnosticVirtualTextHint = { fg = c.hint }, -- Used for "Hint" diagnostic virtual text

    LspReferenceText = { bg = c.bg_visual, bold = true }, -- used for highlighting "text" references
    LspReferenceRead = { bg = c.bg_visual }, -- used for highlighting "read" references
    LspReferenceWrite = { bg = c.bg_visual, bold = true, underline = true, sp = c.orange }, -- used for highlighting "write" references

    ["@constant"] = { fg = c.yellow }, -- For constants
    ["@constructor"] = { fg = c.aqua }, -- For constructor calls and definitions: `= { }` in Lua, and Java constructors.
    ["@field"] = { fg = c.aqua }, -- For fields.
    ["@include"] = { fg = c.blue }, -- For includes: `#include` in C, `use` or `extern crate` in Rust, or `require` in Lua.
    ["@keyword"] = { fg = c.purple, italic = config.italics.keywords }, -- For keywords that don't fall in previous categories.
    ["@keyword.function"] = { fg = c.purple, italic = config.italics.functions }, -- For keywords used to define a fuction.
    ["@label"] = { fg = c.blue }, -- For labels: `label:` in C and `:label:` in Lua.
    ["@namespace"] = { fg = c.red }, -- For identifiers referring to modules and namespaces.
    ["@operator"] = { fg = util.darken(c.orange, 0.85, c.bg) }, -- For any operator: `+`, but also `->` and `*` in C.
    ["@parameter"] = { fg = c.red }, -- For parameters of a function.
    ["@property"] = { fg = c.aqua }, -- Same as `@field`.
    ["@punctutation.bracket"] = { fg = util.darken(c.orange, 0.85, c.bg) }, -- For brackets and parens.
    ["@punctutation.delimiter"] = { fg = c.red }, -- For delimiters ie: `.`
    ["@punctutation.special"] = { fg = util.darken(c.orange, 0.85, c.bg) }, -- For special punctutation that does not fall in the catagories before.
    ["@string.escape"] = { fg = c.red }, -- For escape characters within a string.
    ["@string.regex"] = { fg = c.orange }, -- For regexes.
    ["@tag"] = { fg = c.red }, -- Tags like html tag names.
    ["@text.danger"] = { fg = c.bg, bg = c.error },
    ["@text.danger.comment"] = { fg = c.fg, bg = c.red, bold = true },
    ["@text.note"] = { fg = c.bg, bg = c.info },
    ["@text.reference"] = { fg = c.red },
    ["@text.warning"] = { fg = c.bg, bg = c.warn },
    ["@variable"] = { italic = config.italics.variables }, -- Any variable name that does not have another highlight.
    ["@variable.builtin"] = { fg = c.yellow_dark, bold = true }, -- Variable names that are defined by the languages, like `this` or `self`.

    ["@documentation"] = { fg = c.orange, italic = true },

    ["@annotation"] = { link = "PreProc" }, -- For C++/Dart attributes, annotations that can be attached to the code to denote some kind of meta information.
    ["@attribute"] = { link = "PreProc" }, -- (unstable) TODO: docs
    ["@boolean"] = { link = "Boolean" }, -- For booleans.
    ["@character"] = { link = "Character" }, -- For characters.
    ["@character.special"] = { link = "SpecialChar" }, -- For characters.
    ["@comment"] = { link = "Comment" }, -- For comment blocks.
    ["@conditional"] = { link = "Conditional" }, -- For keywords related to conditionnals.
    ["@constant.builtin"] = { link = "Special" }, -- For constant that are built in the language: `nil` in Lua.
    ["@constant.macro"] = { link = "Define" }, -- For constants that are defined by macros: `NULL` in C.
    ["@debug"] = { link = "Debug" },
    ["@define"] = { link = "Define" },
    -- ["@error"] = { link = "Error" }, -- For syntax/parser errors.
    ["@exception"] = { link = "Exception" }, -- For exception related keywords.
    ["@float"] = { link = "Float" }, -- For floats.
    ["@function"] = { link = "Function" }, -- For function (calls and definitions).
    ["@function.builtin"] = { link = "Special" }, -- For builtin functions: `table.insert` in Lua.
    ["@function.call"] = { link = "@function" },
    ["@function.macro"] = { link = "Macro" },
    ["@keyword.operator"] = { link = "@operator" },
    ["@keyword.return"] = { link = "@keyword" },
    ["@method"] = { link = "Function" },
    ["@method.call"] = { link = "@method" },
    ["@none"] = {},
    ["@number"] = { link = "Number" }, -- For all numbers
    ["@parameter.reference"] = { link = "@parameter" }, -- For references to parameters of a function.
    ["@preproc"] = { link = "PreProc" },
    ["@repeat"] = { link = "Repeat" }, -- For keywords related to loops.
    ["@storageclass"] = { link = "StorageClass" },
    ["@string"] = { link = "String" }, -- For strings.
    ["@string.special"] = { link = "SpecialChar" },
    ["@symbol"] = { link = "Identifier" }, -- For identifiers referring to symbols or atoms.
    ["@tag.attribute"] = { link = "@property" },
    ["@tag.delimiter"] = { link = "Delimiter" },
    ["@text"] = { link = "@none" }, -- For strings considered text in a markup language.
    ["@text.diff.add"] = { link = "diffAdded" },
    ["@text.diff.delete"] = { link = "diffRemoved" },
    ["@text.emphasis"] = { italic = true },
    ["@text.environment"] = { link = "Macro" },
    ["@text.environment.name"] = { link = "Type" },
    ["@text.literal"] = { link = "String" },
    ["@text.math"] = { link = "Special" },
    ["@text.strike"] = { strikethrough = true },
    ["@text.strong"] = { bold = true },
    ["@text.title"] = { link = "Title" },
    ["@text.underline"] = { underline = true },
    ["@text.uri"] = { link = "Underlined" },
    ["@todo"] = { link = "Todo" },
    ["@type"] = { link = "Type" }, -- For types.
    ["@type.builtin"] = { link = "Type" }, -- For builtin types.
    ["@type.definition"] = { link = "Typedef" }, -- For builtin types.
    ["@type.qualifier"] = { link = "Type" }, -- For builtin types.

    ["@punctuation"] = { link = "Delimiter" },
    ["@macro"] = { link = "Macro" },
    ["@structure"] = { link = "Structure" },

    -- link lsp groups to treesitter groups
    ["@lsp.type.class"] = { link = "@type" },
    ["@lsp.type.comment"] = {},
    ["@lsp.type.decorator"] = { link = "@function" },
    ["@lsp.type.enum"] = { link = "@type" },
    ["@lsp.type.enumMember"] = { link = "@constant" },
    ["@lsp.type.function"] = { link = "@function" },
    ["@lsp.type.interface"] = { link = "@type" },
    ["@lsp.type.keyword"] = { link = "@keyword" },
    ["@lsp.type.macro"] = { link = "@macro" },
    ["@lsp.type.method"] = { link = "@method" },
    ["@lsp.type.namespace"] = { link = "@namespace" },
    ["@lsp.type.parameter"] = { link = "@parameter" },
    ["@lsp.type.property"] = { link = "@property" },
    ["@lsp.type.struct"] = { link = "@structure" },
    ["@lsp.type.type"] = { link = "@type" },
    ["@lsp.type.typeParameter"] = { link = "@type.definition" },
    ["@lsp.type.variable"] = { link = "@variable" },

    ["@lsp.mod.documentation"] = { link = "@documentation" },
    ["@lsp.mod.static"] = { link = "@type" },

    -- plugins

    -- LspTrouble
    LspTroubleText = { fg = c.fg },
    LspTroubleCount = { fg = c.purple, bg = c.fg_dark },
    LspTroubleNormal = { fg = c.fg },

    -- lsp-config
    LspInfoBorder = { link = "FloatBorder" },

    -- null-ls
    NullLsInfoBorder = { link = "FloatBorder" },

    -- Illuminate
    illuminatedWord = { bg = c.fg_dark },
    illuminatedCurWord = { bg = c.fg_dark },

    -- diff
    diffAdded = { fg = c.git.add },
    diffRemoved = { fg = c.git.delete },
    diffChanged = { fg = c.git.change },
    diffOldFile = { fg = c.yellow },
    diffNewFile = { fg = c.orange },
    diffFile = { fg = c.blue },
    diffLine = { fg = c.fg_dark },
    diffIndexLine = { fg = c.purple },

    -- Neogit
    NeogitBranch = { fg = c.purple },
    NeogitRemote = { fg = c.purple },
    NeogitHunkHeader = { bg = c.bg_highlight, fg = c.fg },
    NeogitHunkHeaderHighlight = { bg = c.fg_dark, fg = c.blue },
    NeogitDiffContextHighlight = { bg = util.darken(c.fg_dark, 0.5, c.bg), fg = c.fg },
    NeogitDiffDeleteHighlight = { fg = c.git.delete, bg = c.diff.delete },
    NeogitDiffAddHighlight = { fg = c.git.add, bg = c.diff.add },

    -- GitGutter
    GitGutterAdd = { fg = c.git_signs.add }, -- diff mode: Added line |diff.txt|
    GitGutterChange = { fg = c.git_signs.change }, -- diff mode: Changed line |diff.txt|
    GitGutterDelete = { fg = c.git_signs.delete }, -- diff mode: Deleted line |diff.txt|

    -- GitSigns
    GitSignsAdd = { fg = c.git_signs.add },
    GitSignsAddNr = { fg = c.git_signs.add },
    GitSignsAddLn = { fg = c.git_signs.add },
    GitSignsChange = { fg = c.git_signs.change },
    GitSignsChangeNr = { fg = c.git_signs.change },
    GitSignsChangeLn = { fg = c.git_signs.change },
    GitSignsDelete = { fg = c.git_signs.delete },
    GitSignsDeleteNr = { fg = c.git_signs.delete },
    GitSignsDeleteLn = { fg = c.git_signs.delete },
    GitSignsCurrentLineBlame = { fg = c.fg_dark },

    -- Telescope
    TelescopeBorder = { fg = util.darken(c.fg, 0.75, c.bg) },
    TelescopePromptCounter = { link = "Constant" },
    TelescopePromptBorder = { fg = c.fg_light },
    TelescopeResultsBorder = { fg = util.darken(c.fg, 0.75, c.bg) },
    TelescopeSelectionCaret = { fg = c.purple },
    TelescopeSelection = { fg = c.purple, bg = c.bg_highlight },
    TelescopeMatching = { fg = c.blue },
    TelescopeTitle = { link = "Special" },

    -- NvimTree
    NvimTreeNormal = { fg = c.gray },
    NvimTreeFolderIcon = { fg = c.dark_gray },
    NvimTreeRootFolder = { fg = c.fg_light, bold = true },
    NvimTreeSymlink = { fg = c.blue },
    NvimTreeFolderName = { fg = c.gray },
    NvimTreeEmptyFolderName = { fg = c.dark_gray },
    NvimTreeOpenedFolderName = { fg = c.purple },
    NvimTreeOpenedFile = { fg = c.purple },
    NvimTreeGitDirty = { fg = c.yellow_dark },
    NvimTreeGitNew = { fg = c.git.add },
    NvimTreeGitDeleted = { fg = c.git.delete },
    NvimTreeSpecialFile = { fg = c.yellow, underline = true },
    NvimTreeIndentMarker = { fg = c.fg_dark },
    NvimTreeImageFile = { fg = c.fg },
    LspDiagnosticsError = { fg = c.error },
    LspDiagnosticsWarning = { fg = c.warn },
    LspDiagnosticsInformation = { fg = c.info },
    LspDiagnosticsHint = { fg = c.hint },

    -- YaTree
    YaTreeNormal = { fg = c.gray },
    YaTreeDirectoryIcon = { fg = c.blue_bright },
    YaTreeDirectoryName = { fg = c.gray },
    YaTreeFileName = { fg = c.gray },
    YaTreeSymbolicLinkTarget = { fg = c.blue },

    CmpItemAbbr = { fg = c.fg },
    CmpItemAbbrDeprecated = { fg = c.fg, strikethrough = true },
    CmpItemAbbrMatch = { fg = c.green },
    CmpItemAbbrMatchFuzzy = { fg = c.green },
    CmpItemKind = { fg = c.yellow },
    CmpItemKindText = { fg = c.fg },
    CmpItemKindMethod = { fg = c.green },
    CmpItemKindFunction = { fg = c.green },
    CmpItemKindConstructor = { fg = c.green },
    CmpItemKindField = { fg = c.purple },
    CmpItemKindVariable = { fg = c.blue },
    CmpItemKindClass = { fg = c.yellow_dark },
    CmpItemKindInterface = { fg = c.yellow_dark, italic = true },
    CmpItemKindModule = { fg = c.yellow },
    CmpItemKindProperty = { fg = c.blue },
    CmpItemKindUnit = { fg = c.purple },
    CmpItemKindValue = { fg = c.purple },
    CmpItemKindEnum = { fg = c.yellow_dark },
    CmpItemKindKeyword = { fg = c.red },
    CmpItemKindSnippet = { fg = c.aqua },
    CmpItemKindColor = { fg = c.aqua },
    CmpItemKindFile = { fg = c.aqua },
    CmpItemKindReference = { fg = c.aqua },
    CmpItemKindFolder = { fg = c.orange },
    CmpItemKindEnumMember = { fg = c.purple, italic = true },
    CmpItemKindConstant = { fg = c.blue, bold = true },
    CmpItemKindStruct = { fg = c.yellow },
    CmpItemKindEvent = { fg = c.orange },
    CmpItemKindOperator = { fg = c.orange },
    CmpItemKindTypeParameter = { fg = c.yellow },
    CmpItemMenu = { fg = c.yellow },

    -- navic (highlight icons)
    NavicIconsFile = { fg = c.aqua },
    NavicIconsModule = { fg = c.aqua },
    NavicIconsNamespace = { fg = c.aqua },
    NavicIconsPackage = { fg = c.aqua },
    NavicIconsClass = { fg = c.yellow },
    NavicIconsMethod = { fg = c.blue },
    NavicIconsProperty = { fg = c.aqua },
    NavicIconsField = { fg = c.aqua },
    NavicIconsConstructor = { fg = c.aqua },
    NavicIconsEnum = { fg = c.yellow },
    NavicIconsInterface = { fg = c.yellow },
    NavicIconsFunction = { fg = c.blue },
    NavicIconsVariable = { fg = c.purple },
    NavicIconsConstant = { fg = c.yellow },
    NavicIconsString = { fg = c.green },
    NavicIconsNumber = { fg = c.orange },
    NavicIconsBoolean = { fg = c.orange },
    NavicIconsArray = { fg = c.orange },
    NavicIconsObject = { fg = c.orange },
    NavicIconsKey = { fg = c.aqua },
    NavicIconsNull = { fg = c.orange },
    NavicIconsEnumMember = { fg = c.yellow },
    NavicIconsStruct = { fg = c.yellow },
    NavicIconsEvent = { fg = c.yellow },
    NavicIconsOperator = { fg = c.red },
    NavicIconsTypeParameter = { fg = c.red },
    NavicText = { fg = c.fg },
    NavicSeparator = { fg = c.fg },

    -- Dashboard
    DashboardShortCut = { fg = c.purple },
    DashboardHeader = { fg = c.red },
    DashboardCenter = { fg = c.blue },
    DashboardFooter = { fg = c.yellow, italic = true },

    -- Noice
    NoiceCursor = { link = "TermCursor" },
    NoiceFormatProgressTodo = { link = "Normal" },

    -- WhichKey
    WhichKey = { fg = c.yellow },
    WhichKeyGroup = { fg = c.blue },
    WhichKeyDesc = { fg = c.red },
    WhichKeySeperator = { fg = c.fg },
    WhichKeySeparator = { fg = c.fg },
    WhichKeyFloat = { bg = c.bg2 },
    WhichKeyValue = { fg = c.fg_dark },

    -- LspSaga
    LspSagaHoverBorder = { fg = c.border },
    LspSagaSignatureHelpBorder = { fg = c.border },
    LspSagaCodeActionBorder = { fg = c.border },
    LspSagaAutoPreview = { fg = c.border },
    LspSagaDefPreviewBorder = { fg = c.border },
    LspLinesDiagBorder = { fg = c.border },

    -- lsp-inlayhints.nvim
    LspInlayHint = { link = "Comment" },

    -- BufferLine
    BufferLineIndicatorSelected = { fg = c.git.change },
    BufferLineFill = { bg = c.bg0 },

    -- Hop
    HopNextKey = { fg = c.red, bold = true },
    HopNextKey1 = { fg = c.blue, bold = true },
    HopNextKey2 = { fg = util.darken(c.blue, 0.80, c.bg) },
    HopUnmatched = { fg = c.dark_gray },

    -- ts-rainbow2 (maintained fork)
    TSRainbowRed = { fg = c.red },
    TSRainbowOrange = { fg = c.orange },
    TSRainbowYellow = { fg = c.yellow },
    TSRainbowGreen = { fg = c.green },
    TSRainbowBlue = { fg = c.blue },
    TSRainbowViolet = { fg = c.purple },
    TSRainbowCyan = { fg = c.aqua },

    -- languages

    helpCommand = { link = "Identifier" },

    qfLineNr = { fg = c.fg_dark },
    qfFileName = { fg = c.blue },

    -- html
    htmlTag = { fg = c.purple, bold = true },

    -- mkdHeading = { fg = c.orange, bold = true },
    -- mkdCode = { bg = c.bg2, fg = c.fg },
    mkdCodeDelimiter = { bg = c.bg2, fg = c.fg },
    mkdCodeStart = { fg = c.yellow, bold = true },
    mkdCodeEnd = { fg = c.yellow, bold = true },
    -- mkdLink = { fg = c.blue, underline = true },

    markdownHeadingDelimiter = { fg = c.orange, bold = true },
    markdownCode = { fg = c.yellow },
    markdownCodeBlock = { fg = c.yellow },
    markdownH1 = { fg = c.red, bold = true },
    markdownH2 = { fg = c.blue, bold = true },
    markdownLinkText = { fg = c.blue, underline = true },

    debugPC = { bg = c.bg1 }, -- used for highlighting the current line in terminal-debug
    debugBreakpoint = { fg = c.red }, -- used for breakpoint colors in terminal-debug
  }

  if config.hide_inactive_statusline then
    local inactive = { underline = true, bg = c.bg, fg = c.bg, sp = c.border }

    -- StatusLineNC
    theme.StatusLineNC = inactive

    -- LuaLine
    for _, section in ipairs({ "a", "b", "c" }) do
      theme["lualine_" .. section .. "_inactive"] = inactive
    end
  end

  local fallbacks = {
    ["annotation"] = "TSAnnotation",
    ["attribute"] = "TSAttribute",
    ["boolean"] = "TSBoolean",
    ["character"] = "TSCharacter",
    ["character.special"] = "TSCharacterSpecial",
    ["comment"] = "TSComment",
    ["conditional"] = "TSConditional",
    ["constant"] = "TSConstant",
    ["constant.builtin"] = "TSConstBuiltin",
    ["constant.macro"] = "TSConstMacro",
    ["constructor"] = "TSConstructor",
    ["debug"] = "TSDebug",
    ["define"] = "TSDefine",
    ["error"] = "TSError",
    ["exception"] = "TSException",
    ["field"] = "TSField",
    ["float"] = "TSFloat",
    ["function"] = "TSFunction",
    ["function.call"] = "TSFunctionCall",
    ["function.builtin"] = "TSFuncBuiltin",
    ["function.macro"] = "TSFuncMacro",
    ["include"] = "TSInclude",
    ["keyword"] = "TSKeyword",
    ["keyword.function"] = "TSKeywordFunction",
    ["keyword.operator"] = "TSKeywordOperator",
    ["keyword.return"] = "TSKeywordReturn",
    ["label"] = "TSLabel",
    ["method"] = "TSMethod",
    ["method.call"] = "TSMethodCall",
    ["namespace"] = "TSNamespace",
    ["none"] = "TSNone",
    ["number"] = "TSNumber",
    ["operator"] = "TSOperator",
    ["parameter"] = "TSParameter",
    ["parameter.reference"] = "TSParameterReference",
    ["preproc"] = "TSPreProc",
    ["property"] = "TSProperty",
    ["punctuation.delimiter"] = "TSPunctDelimiter",
    ["punctuation.bracket"] = "TSPunctBracket",
    ["punctuation.special"] = "TSPunctSpecial",
    ["repeat"] = "TSRepeat",
    ["storageclass"] = "TSStorageClass",
    ["string"] = "TSString",
    ["string.regex"] = "TSStringRegex",
    ["string.escape"] = "TSStringEscape",
    ["string.special"] = "TSStringSpecial",
    ["symbol"] = "TSSymbol",
    ["tag"] = "TSTag",
    ["tag.attribute"] = "TSTagAttribute",
    ["tag.delimiter"] = "TSTagDelimiter",
    ["text"] = "TSText",
    ["text.strong"] = "TSStrong",
    ["text.emphasis"] = "TSEmphasis",
    ["text.underline"] = "TSUnderline",
    ["text.strike"] = "TSStrike",
    ["text.title"] = "TSTitle",
    ["text.literal"] = "TSLiteral",
    ["text.uri"] = "TSURI",
    ["text.math"] = "TSMath",
    ["text.reference"] = "TSTextReference",
    ["text.environment"] = "TSEnvironment",
    ["text.environment.name"] = "TSEnvironmentName",
    ["text.note"] = "TSNote",
    ["text.warning"] = "TSWarning",
    ["text.danger"] = "TSDanger",
    ["todo"] = "TSTodo",
    ["type"] = "TSType",
    ["type.builtin"] = "TSTypeBuiltin",
    ["type.qualifier"] = "TSTypeQualifier",
    ["type.definition"] = "TSTypeDefinition",
    ["variable"] = "TSVariable",
    ["variable.builtin"] = "TSVariableBuiltin",
  }
  for fallback, ts in pairs(fallbacks) do
    theme[ts] = { link = fallback }
  end

  for group, hl in pairs(config.theme) do
    if theme[group] then
      theme[group].link = nil
    end
    if hl.fg and c[hl.fg] then
      hl.fg = c[hl.fg]
    end
    if hl.bg and c[hl.bg] then
      hl.bg = c[hl.bg]
    end

    theme[group] = vim.tbl_extend("force", theme[group] or {}, hl)
  end

  return theme
end

return M
