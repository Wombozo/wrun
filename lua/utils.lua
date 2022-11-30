local U = { }

U.get_current_wrun_file = function(config)
  local project_path = vim.fn.expand('%:p')
  local cache_file = config.cache_dir .. '/' .. project_path:gsub('/','@')
  cache_file = cache_file:gsub("(.*)@.*$","%1")
  return cache_file
end


U.create_term = function(config, exec)
  require'toggleterm'.setup {
    size = config.term_settings.size,
    persist_size = false
  }

  return require'toggleterm.terminal'.Terminal:new({
    direction = config.term_settings.exec_direction,
    cmd = config.interpreter .. ' ' .. exec,
    close_on_exit = true,
    float_opts = config.term_settings.exec_float_opts,
})
end

U.file_exists = function(file)
  local f = io.open(file, "rb")
  if f then f:close() end
  return f ~= nil
end

U.is_one_of = function(element, array)
  for _, value in pairs(array) do
    if value == element then return true end end
  return false
end

U.get_cache_files = function(config)
  local f = io.popen("ls " .. config.cache_dir)
  if f == nil then
      return { }
  end
  local lines = f:read'*a'
  if lines == "" then return end
  local files = { }
  for line in string.gmatch(lines, "([^'%s']+)") do
    table.insert(files, line)
  end
  return files
end

U.create_cache_dir = function(cache_dir)
  os.execute('mkdir -p ' .. cache_dir)
end

U.display = function(text)
  print(text)
end

return U
