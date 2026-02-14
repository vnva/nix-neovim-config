local opt = vim.opt

opt.number = true
opt.relativenumber = true
opt.mouse = ""
opt.ignorecase = true
opt.smartcase = true
opt.termguicolors = true
opt.cmdheight = 0
opt.completeopt = { 'menu', 'menuone', 'noselect' }
opt.updatetime = 250
opt.signcolumn = "yes"
opt.clipboard = "unnamedplus"
opt.splitright = true
opt.splitbelow = true
opt.expandtab = true
opt.shiftwidth = 2
opt.tabstop = 2

local function transparent_background()
  vim.api.nvim_set_hl(0, 'Normal', { bg = 'none' })
  vim.api.nvim_set_hl(0, 'NormalFloat', { ctermbg = 0, bg = '#1c1c1c' })
  vim.api.nvim_set_hl(0, 'FloatBorder', { ctermbg = 0, bg = '#1c1c1c' })
  vim.api.nvim_set_hl(0, 'Pmenu', { ctermbg = 0, bg = '#1c1c1c' })
  vim.api.nvim_set_hl(0, 'PmenuSel', { ctermbg = 8, bg = '#303030' })
  vim.api.nvim_set_hl(0, 'SignColumn', { bg = 'none' })
  vim.api.nvim_set_hl(0, 'EndOfBuffer', { bg = 'none' })
end

transparent_background()

vim.api.nvim_create_autocmd('ColorScheme', {
  callback = transparent_background,
})
