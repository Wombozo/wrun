local M = { }

local U = require'utils'

M.run = function()
    local cache_file = U.lookup_cache_file(M.config)
    if cache_file == nil then
        U.display('No existing wrun file')
        return
    end
    if U.file_exists(cache_file) then
        U.create_term(M.config, cache_file):toggle()
        return
    end
end

M.edit = function()
    U.create_cache_dir(M.config.cache_dir)
    local cache_file = U.lookup_cache_file(M.config)
    U.display('Editing cache file ' .. cache_file)
    U.edit_file(M.config, cache_file)
end


M.list = function()
  vim.cmd('vimgrep /\\%1l/j ' .. M.config.cache_dir ..'/*')
  vim.cmd('copen')
end

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
