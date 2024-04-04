-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")

require("transparent").setup({
  enable = true,
  extra_groups = { -- table/string: additional groups that should be cleared
    "BufferLineTabClose",
    "BufferlineBufferSelected",
    "BufferLineFill",
    "BufferLineBackground",
    "BufferLineSeparator",
    "BufferLineIndicatorSelected",

    "IndentBlanklineChar",

    -- make floating windows transparent
    "LspFloatWinNormal",
    "Normal",
    "NormalFloat",
    "FloatBorder",
    "TelescopeNormal",
    "TelescopeBorder",
    "TelescopePromptBorder",
    "NvimTreeNormal",
    "SagaBorder",
    "SagaNormal",
  },
  exclude = {}, -- table: groups you don't want to clear
})
