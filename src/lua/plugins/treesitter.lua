return {
  {
    'nvim-treesitter/nvim-treesitter',
    lazy = false,
    config = function()
      local ok, ts = pcall(require, 'nvim-treesitter')
      if not ok then
        return
      end

      local install_dir = vim.fn.expand('~/.local/share/nvim/site')
      ts.setup({ install_dir = install_dir })
      local required = { 'lua', 'vim', 'vimdoc', 'query', 'bash', 'nix' }
      local installed = ts.get_installed()
      local installed_set = {}
      for _, lang in ipairs(installed) do
        installed_set[lang] = true
      end

      local missing = {}
      for _, lang in ipairs(required) do
        if not installed_set[lang] then
          table.insert(missing, lang)
        end
      end

      if #missing > 0 then
        vim.schedule(function()
          ts.install(missing)
        end)
      end

      vim.api.nvim_create_autocmd('FileType', {
        callback = function(args)
          pcall(vim.treesitter.start, args.buf)
        end,
      })
    end,
  },
}
