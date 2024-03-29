<!-- panvimdoc-ignore-start -->

<h1 align="center">
  WRun
</h1>

![WRun](assets/wrun.png)

# Overview

<b>WRun</b> is a nvim plugin designed to run a script inside a project directory.

If your project is in the `/home/user/dir1/dir2` path, the plugin will look for special script associated with `/home/user/dir1/dir2`, then if not found for `/home/user/dir1`, and so on.

To create a new script file associated with path `path`, just open neovim at the path `path`, and `:WRrun` or `:WRedit` it. Once the script is saved, just run `:WRrun` to execute it or `:WRedit` to edit it. You can also visualize the list of existing scripts with the `:WRlist` command.

The script file associated with the `/home/user/dir1/dir2` project path is named `<cache_dir>/@home@user@dir1@dir2`, where `cache_dir` is by default `$HOME/.local/share/nvim/wrun`.


# Installation

This plugin requires [toggleterm.nvim](https://github.com/akinsho/toggleterm.nvim). Using [packer](https://github.com/wbthomason/packer.nvim) :

```
use {'wombozo/wrun', requires = {{'akinsho/toggleterm.nvim'}}}
```

# Configuration

## Setup

The plugin <b>needs</b> a setup call to work.

```
require'wrun'.setup()
```

You can override any of these default values :

```
require'wrun'.setup({
  cache_dir = os.getenv( "HOME" ) .. '/.local/share/nvim/wrun',
  interpreter = '/usr/bin/bash', -- first part of the command
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
    exec_float_opts = { -- only for 'float' exec_direction
      width = 100,
      height = 40,
      winblend = 3,
      highlights = {
        border = "Normal",
        background = "Normal",
      }
    }
  }
})
```

## Mapping

Here is how we can map the commands :
  
``` 
vim.api.nvim_set_keymap('n', '<leader>te', '<cmd>WRedit <CR>', {})
vim.api.nvim_set_keymap('n', '<leader>tr', '<cmd>WRrun <CR>', {})
vim.api.nvim_set_keymap('n', '<leader>tl', '<cmd>WRlist <CR>', {})
```

## Tips

If your script is a bash script, please add a `read` command at the end of the script file to have a visual of the output.
