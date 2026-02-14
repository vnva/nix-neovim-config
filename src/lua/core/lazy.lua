local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.loop.fs_stat(lazypath) then
  local clone_cmd = {
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  }

  local result = vim.fn.system(clone_cmd)
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { result, "WarningMsg" },
    }, true, {})
    return
  end
end

vim.opt.runtimepath:prepend(lazypath)

require('lazy').setup(require('core.plugins'), {
  checker = { enabled = false },
  change_detection = { notify = false },
})
