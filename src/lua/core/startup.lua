local argc = vim.fn.argc()

if argc == 1 then
  local arg0 = vim.fn.argv(0)
  if vim.fn.isdirectory(arg0) == 1 then
    local project_dir = vim.fn.fnamemodify(arg0, ':p')

    vim.api.nvim_create_autocmd('VimEnter', {
      once = true,
      callback = function()
        vim.cmd.cd(vim.fn.fnameescape(project_dir))

        local ok, telescope = pcall(require, 'telescope.builtin')
        if ok then
          telescope.find_files({ cwd = project_dir })
        else
          vim.cmd.edit('.')
        end
      end,
    })
  end
end
