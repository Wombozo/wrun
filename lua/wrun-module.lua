local M = { }

local U = require'utils'

local edit_file = function(file)
  vim.cmd(M.config.edit_method .. ' ' .. file)
end

M.run = function()
  local cache_file = U.get_current_wrun_file(M.config)
  if U.file_exists(cache_file) then
    U.create_term(M.config, cache_file):toggle()
    return
  end
  local index = cache_file:find'@'
  local token = cache_file:sub(index)
  while token ~= '' do
    local file = M.config.cache_dir .. '/' .. token
    if U.file_exists(file) then
      U.create_term(M.config, file):toggle()
      return
    end
    local rev = token:reverse()
    index = rev:find'@'
    rev = rev:sub(index + 1)
    token = rev:reverse()
  end
  U.create_cache_dir(M.config.cache_dir)
  U.display('No existing wrun file, creating a new one : ' .. cache_file)
  edit_file(cache_file)
end

M.edit = function()
  U.create_cache_dir(M.config.cache_dir)
  local cache_file = U.get_current_wrun_file(M.config)
  edit_file(cache_file)
end

M.list = function()
  local files = U.get_cache_files(M.config)
  if files == nil then U.display'No wrun file yet' return end
  print(table.concat(files,' '))
end

vim.api.nvim_command("command! WRrun lua require'wrun'.run()")
vim.api.nvim_command("command! WRedit lua require'wrun'.edit()")

M.config = {
  cache_dir = os.getenv( "HOME" ) .. '/.local/share/nvim/wrun',
  interpreter = '/usr/bin/bash',
  edit_method = '8split', -- 'edit' | 'tabedit' | '8split'| '5vsplit' | ...
  term_settings = {
    exec_direction = 'float', -- 'verical' | 'horizontal' | 'float'
    size = function(term)
        if term.direction == "horizontal" then
          return 15
        elseif term.direction == "vertical" then
          return vim.o.columns * 0.4
        end
      end, -- or hardcoded value
    exec_float_opts = {
      width = 100,
      height = 40,
      winblend = 3,
      highlights = {
        border = "Normal",
        background = "Normal",
      }
    }
  }
}

return M
