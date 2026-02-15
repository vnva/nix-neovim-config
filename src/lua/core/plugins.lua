local specs = {}

vim.list_extend(specs, require('plugins.lsp'))
vim.list_extend(specs, require('plugins.format'))
vim.list_extend(specs, require('plugins.telescope'))
vim.list_extend(specs, require('plugins.treesitter'))
vim.list_extend(specs, require('plugins.ui'))
vim.list_extend(specs, require('plugins.cmp'))
vim.list_extend(specs, require('plugins.supermaven'))

return specs
