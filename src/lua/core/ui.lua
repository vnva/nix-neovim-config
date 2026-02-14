local function apply_ui_highlights()
  vim.api.nvim_set_hl(0, 'Normal', { bg = 'none' })
  vim.api.nvim_set_hl(0, 'NormalFloat', { ctermbg = 0, bg = '#1c1c1c' })
  vim.api.nvim_set_hl(0, 'FloatBorder', { ctermbg = 0, bg = '#1c1c1c' })
  vim.api.nvim_set_hl(0, 'Pmenu', { ctermbg = 0, bg = '#1c1c1c' })
  vim.api.nvim_set_hl(0, 'PmenuSel', { ctermbg = 8, bg = '#303030' })
  vim.api.nvim_set_hl(0, 'SignColumn', { bg = 'none' })
  vim.api.nvim_set_hl(0, 'EndOfBuffer', { bg = 'none' })
end

apply_ui_highlights()

vim.api.nvim_create_autocmd('ColorScheme', {
  callback = apply_ui_highlights,
})
