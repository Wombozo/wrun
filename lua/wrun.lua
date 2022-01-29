local w = require'wrun-module'

local setup = function(user_opts)
  w.config = vim.tbl_extend('force', w.config, user_opts or {})
  vim.api.nvim_command("command! WRrun lua require'wrun'.run()")
  vim.api.nvim_command("command! WRedit lua require'wrun'.edit()")
end

return {
  setup = setup,
  run = w.run,
  edit = w.edit,
  list = w.list
}
