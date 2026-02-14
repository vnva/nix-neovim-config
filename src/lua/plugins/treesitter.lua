return {
  {
    'nvim-treesitter/nvim-treesitter',
    lazy = false,
    build = ':TSUpdate',
    config = function()
      local ok, ts = pcall(require, 'nvim-treesitter')
      if not ok then
        return
      end

      ts.setup({})
      ts.install({ 'qmljs' })
      vim.treesitter.language.register('qmljs', 'qml')

      vim.api.nvim_create_autocmd('FileType', {
        callback = function(args)
          pcall(vim.treesitter.start, args.buf)
        end,
      })
    end,
  },
}
