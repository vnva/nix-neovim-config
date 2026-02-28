return {
  {
    'nvim-tree/nvim-web-devicons',
    lazy = true,
  },
  {
    'lewis6991/gitsigns.nvim',
    event = { 'BufReadPre', 'BufNewFile' },
    opts = {
      signs = {
        add = { text = '+' },
        change = { text = '~' },
        delete = { text = '_' },
        topdelete = { text = '^' },
        changedelete = { text = '~' },
      },
      signs_staged = {
        add = { text = '+' },
        change = { text = '~' },
        delete = { text = '_' },
        topdelete = { text = '^' },
        changedelete = { text = '~' },
      },
      signcolumn = true,
      numhl = false,
      linehl = false,
      word_diff = false,
      current_line_blame = false,
    },
  },
  {
    'lukas-reineke/indent-blankline.nvim',
    event = { 'BufReadPre', 'BufNewFile' },
    main = 'ibl',
    opts = {
      indent = {
        char = '│',
      },
      scope = {
        enabled = true,
      },
      exclude = {
        filetypes = {
          'help',
          'dashboard',
          'lazy',
          'mason',
          'NvimTree',
          'terminal',
          'toggleterm',
        },
      },
    },
  },
}
