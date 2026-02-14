return {
  {
    'neovim/nvim-lspconfig',
    event = { 'BufReadPre', 'BufNewFile' },
    config = function()
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      local ok_cmp, cmp_nvim_lsp = pcall(require, 'cmp_nvim_lsp')
      if ok_cmp then
        capabilities = cmp_nvim_lsp.default_capabilities(capabilities)
      end

      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('my-neovim-lsp', { clear = true }),
        callback = function(args)
          local keymap = vim.keymap.set
          local opts = { buffer = args.buf, silent = true }

          vim.bo[args.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

          keymap('n', 'gd', vim.lsp.buf.definition, opts)
          keymap('n', 'gr', vim.lsp.buf.references, opts)
          keymap('n', 'K', vim.lsp.buf.hover, opts)
          keymap('n', '<leader>rn', vim.lsp.buf.rename, opts)
          keymap('n', '<leader>ca', vim.lsp.buf.code_action, opts)
        end,
      })

      local function setup_lua_ls()
        if vim.fn.executable('lua-language-server') ~= 1 then
          vim.schedule(function()
            vim.notify(
              'lua-language-server is not in PATH. Install it via Nix module and rebuild.',
              vim.log.levels.WARN
            )
          end)
          return
        end

        vim.api.nvim_create_autocmd('FileType', {
          pattern = 'lua',
          callback = function(args)
            if #vim.lsp.get_clients({ bufnr = args.buf, name = 'lua_ls' }) > 0 then
              return
            end
            vim.lsp.start({
              name = 'lua_ls',
              cmd = { 'lua-language-server' },
              capabilities = capabilities,
              root_dir = vim.fs.root(args.buf, { '.luarc.json', '.luarc.jsonc', '.git' }) or vim.loop.cwd(),
              settings = {
                Lua = {
                  diagnostics = {
                    globals = { 'vim' },
                  },
                },
              },
            })
          end,
        })
      end

      local function setup_nixd()
        if vim.fn.executable('nixd') ~= 1 then
          vim.schedule(function()
            vim.notify('nixd is not in PATH. Add it to Neovim extraPackages and rebuild.', vim.log.levels.WARN)
          end)
          return
        end

        vim.api.nvim_create_autocmd('FileType', {
          pattern = 'nix',
          callback = function(args)
            if #vim.lsp.get_clients({ bufnr = args.buf, name = 'nixd' }) > 0 then
              return
            end
            vim.lsp.start({
              name = 'nixd',
              cmd = { 'nixd' },
              capabilities = capabilities,
              root_dir = vim.fs.root(args.buf, { 'flake.nix', 'default.nix', '.git' }) or vim.loop.cwd(),
            })
          end,
        })
      end

      setup_lua_ls()
      setup_nixd()
    end,
  },
}
