local argc = vim.fn.argc()

if argc == 1 then
  local arg0 = vim.fn.argv(0)
  if vim.fn.isdirectory(arg0) == 1 then
    local project_dir = vim.fn.fnamemodify(arg0, ':p')

    vim.api.nvim_create_autocmd('VimEnter', {
      once = true,
      callback = function()
        vim.cmd.cd(vim.fn.fnameescape(project_dir))
      end,
    })
  end
end
