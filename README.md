# auto-conform

- auto-conform.nvim is an automatic configuration for conform.nvim and mason.nvim

# Installation

- Lazy

```lua
return {
  "pojokcodeid/auto-conform.nvim",
  dependencies = {
    "williamboman/mason.nvim",
    "stevearc/conform.nvim",
  },
  event = "VeryLazy",
  config = function()
    require("auto-conform").setup({
      -- formatters config conform
      formatters = {
        -- yamlfix = {
        --   -- Change where to find the command
        --   command = "local/path/yamlfix",
        --   -- Adds environment args to the yamlfix formatter
        --   env = {
        --     YAMLFIX_SEQUENCE_STYLE = "block_style",
        --   },
        -- },
      },
      -- formatters_by_ft conform
      formatters_by_ft = {
        lua = { "stylua" },
      },
      -- install mason formatter
      ensure_installed = {
        "prettier",
      },
      -- mapping masson language vs filetype
      lang_maps = {
        -- ["c++"] = "cpp",
        -- ["c#"] = "cs",
        -- ["jsx"] = "javascriptreact",
      },
      -- mappings conform name vs masonn name if not same
      name_maps = {
        -- ["cmakelang"] = "cmake_format",
        -- ["deno"] = "deno_fmt",
        -- ["elm-format"] = "elm_format",
      },
      -- add new mapping to conform
      add_new = {
        -- ["jsonc"] = "prettier",
        -- ["json"] = "prettier",
        -- ["typescriptreact"] = "prettier",
      },
      -- disable register mason to conform
      ignore = {
        -- ["php"] = "tlint",
        -- ["lua"] = "ast-grep",
        -- ["kotlin"] = "ktlint",
      },
    })
    -- other conform config
    require("conform").setup({
      format_on_save = {
        lsp_fallback = true,
        timeout_ms = 5000,
      },
    })
  end,
}
```

- Minimum config

```lua
 require("auto-conform").setup({})
```

- Get Default and Overide

```lua
local opts = {}
local cfg = require("auto-conform.masonregister").register(opts)
cfg.formatters_by_ft.lua = { "stylua" }
cfg.formatters = {
-- config here
}
require("conform").setup(cfg)
```
