local M = {}
M.keymaps = {
  ["c++"] = "cpp",
  ["c#"] = "cs",
  ["jsx"] = "javascriptreact",
}

M.name_maps = {
  ["cmakelang"] = "cmake_format",
  ["deno"] = "deno_fmt",
  ["elm-format"] = "elm_format",
  ["gdtoolkit"] = "gdformat",
  ["nixpkgs-fmt"] = "nixpkgs_fmt",
  ["opa"] = "opa_fmt",
  ["php-cs-fixer"] = "php_cs_fixer",
  ["ruff"] = "ruff_format",
  ["sql-formatter"] = "sql_formatter",
  ["xmlformatter"] = "xmlformat",
}

M.add_new = {
  ["jsonc"] = { "prettier" },
  ["json"] = { "prettier" },
  ["typescriptreact"] = { "prettier" },
}

M.ignore = {
  ["php"] = { "tlint" },
  ["lua"] = { "ast-grep" },
  ["kotlin"] = { "ktlint" },
  ["go"] = { "ast-grep" },
  ["rust"] = { "ast-grep" },
  ["rs"] = { "ast-grep" },
}

return M
