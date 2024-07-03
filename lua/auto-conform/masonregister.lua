local mason_reg = require("mason-registry")
local keymap = require("auto-conform.utils").keymaps
local name_map = require("auto-conform.utils").name_maps
local addnew = require("auto-conform.utils").add_new
local ignore = require("auto-conform.utils").ignore
local M = {}

M.register = function(opts)
  opts.formatters = opts.formatters or {}
  opts.formatters_by_ft = opts.formatters_by_ft or {}
  opts.ensure_installed = opts.ensure_installed or {}
  vim.list_extend(keymap, opts.lang_maps or {})
  vim.list_extend(name_map, opts.name_maps or {})
  vim.list_extend(addnew, opts.add_new or {})
  vim.list_extend(ignore, opts.ignore or {})
  -- install mason ensure installed
  for _, value in pairs(opts.ensure_installed) do
    require("auto-conform.masoncfg").try_install(value)
  end
  -- register mason to conform
  for _, pkg in pairs(mason_reg.get_installed_packages()) do
    for _, type in pairs(pkg.spec.categories) do
      -- only act upon a formatter
      if type == "Formatter" then
        -- if formatter doesn't have a builtin config, create our own from a generic template
        if not require("conform").get_formatter_config(pkg.spec.name) then
          -- the key of the entry to this table
          -- is the name of the bare executable
          -- the actual value may not be the absolute path
          -- in some cases
          local bin = next(pkg.spec.bin)
          -- this should be replaced by a function
          -- that quieries the configured mason install path
          local prefix = vim.fn.stdpath("data") .. "/mason/bin/"

          opts.formatters[pkg.spec.name] = {
            command = prefix .. bin,
            args = { "$FILENAME" },
            stdin = true,
            require_cwd = false,
          }
        end

        -- local listtest = {}
        -- finally add the formatter to it's compatible filetype(s)
        for _, ft in pairs(pkg.spec.languages) do
          local ftl = string.lower(ft)
          -- register only ready installed package
          local ready = mason_reg.get_package(pkg.spec.name):is_installed()
          if ready then
            if keymap[ftl] ~= nil then
              ftl = keymap[ftl]
            end
            if name_map[pkg.spec.name] ~= nil then
              pkg.spec.name = name_map[pkg.spec.name]
            end

            -- if substring(pkg.spec.name, "ktfmt") then
            --   table.insert(listtest, ftl)
            -- end

            -- add new mapping language
            for key, value in pairs(addnew) do
              for _, value2 in pairs(value) do
                if value2 == pkg.spec.name then
                  opts.formatters_by_ft[key] = opts.formatters_by_ft[key] or {}
                  table.insert(opts.formatters_by_ft[key], pkg.spec.name)
                end
              end
            end

            local val_ignore = ignore[ftl]
            if val_ignore ~= nil then
              for _, value in pairs(val_ignore) do
                if value ~= pkg.spec.name then
                  opts.formatters_by_ft[ftl] = opts.formatters_by_ft[ftl] or {}
                  table.insert(opts.formatters_by_ft[ftl], pkg.spec.name)
                end
              end
            else
              opts.formatters_by_ft[ftl] = opts.formatters_by_ft[ftl] or {}
              table.insert(opts.formatters_by_ft[ftl], pkg.spec.name)
            end
          end
        end
        -- print(table.concat(listtest, ","))
      end
    end
  end
  return opts
end

M.setup = function(opts)
  local cfg = M.register(opts)
  require("conform").setup(cfg)
end

return M
