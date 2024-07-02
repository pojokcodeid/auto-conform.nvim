local M = {}

M.setup = function(opts)
  if opts then
	  opts.formatters = opts.formatters or {}
	  opts.formatters_by_ft = opts.formatters_by_ft or {}
	  opts.ensure_installed = opts.ensure_installed or {}
	  opts.lang_maps = opts.lang_maps or {}
	  opts.name_maps = opts.name_maps or {}
	  opts.add_new = opts.name_maps or {}
	  opts.ignore = opts.ignore or {}
	else
	  opts = {}
  end
	require("auto-conform.masonregister").setup(opts)
end

return M
