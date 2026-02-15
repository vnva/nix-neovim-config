local function apply_ui_highlights()
  vim.api.nvim_set_hl(0, 'Normal', { bg = 'none' })
  vim.api.nvim_set_hl(0, 'NormalFloat', { ctermbg = 0, bg = '#1c1c1c' })
  vim.api.nvim_set_hl(0, 'FloatBorder', { ctermbg = 0, bg = '#1c1c1c' })
  vim.api.nvim_set_hl(0, 'Pmenu', { ctermbg = 0, bg = '#1c1c1c' })
  vim.api.nvim_set_hl(0, 'PmenuSel', { ctermbg = 8, bg = '#303030' })
  vim.api.nvim_set_hl(0, 'SignColumn', { bg = 'none' })
  vim.api.nvim_set_hl(0, 'EndOfBuffer', { bg = 'none' })
  vim.api.nvim_set_hl(0, 'StatusLine', { fg = '#e5e5e5', bg = 'none', bold = true })
  vim.api.nvim_set_hl(0, 'StatusLineNC', { fg = '#8a8a8a', bg = 'none' })
  vim.api.nvim_set_hl(0, 'StatusLineAccent', { fg = '#ffffff', bg = 'none', bold = true })
end

local mode_names = {
  n = 'N',
  no = 'N?',
  i = 'I',
  ic = 'I',
  v = 'V',
  V = 'VL',
  ["\22"] = 'VB',
  c = 'C',
  s = 'S',
  S = 'SL',
  R = 'R',
  rv = 'R',
  t = 'T',
}

function _G.statusline_mode()
  return mode_names[vim.api.nvim_get_mode().mode] or '?'
end

function _G.statusline_git()
  local head = vim.b.gitsigns_head
  if not head or head == '' then
    return ''
  end
  return head
end

function _G.statusline_git_changes()
  local status = vim.b.gitsigns_status_dict
  if not status then
    return ''
  end

  local parts = {}
  if status.added and status.added > 0 then
    table.insert(parts, '+' .. status.added)
  end
  if status.changed and status.changed > 0 then
    table.insert(parts, '~' .. status.changed)
  end
  if status.removed and status.removed > 0 then
    table.insert(parts, '-' .. status.removed)
  end

  return table.concat(parts, ' ')
end

vim.opt.laststatus = 3
vim.opt.statusline = table.concat({
  ' %{%v:lua.statusline_mode()%}',
  " %{v:lua.statusline_git() != '' ? '│ git:' . v:lua.statusline_git() . ' ' : ''}",
  " %{v:lua.statusline_git_changes() != '' ? v:lua.statusline_git_changes() . ' ' : ''}",
  '│ %<%f %h%m%r',
  " %= %{&filetype != '' ? &filetype : 'text'}",
  ' │ %l:%c │ %p%% ',
})

apply_ui_highlights()

vim.api.nvim_create_autocmd('ColorScheme', {
  callback = apply_ui_highlights,
})
