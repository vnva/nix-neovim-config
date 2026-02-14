vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

local init_path = debug.getinfo(1, 'S').source:sub(2)
local config_dir = vim.fs.dirname(init_path)

vim.opt.runtimepath:prepend(config_dir)
package.path = config_dir .. '/lua/?.lua;' .. config_dir .. '/lua/?/init.lua;' .. package.path

require('core.options')
require('core.ui')
require('core.keymaps')
require('core.lazy')
