return {
  {
    'potamides/pantran.nvim',
    cmd = { 'Pantran' },
    keys = {
      { '<leader>tt', '<cmd>Pantran<cr>', desc = 'Translate text' },
      {
        '<leader>tr',
        function()
          return require('pantran').motion_translate()
        end,
        mode = { 'n', 'x' },
        expr = true,
        desc = 'Translate motion/selection',
      },
      {
        '<leader>trr',
        function()
          return require('pantran').motion_translate() .. '_'
        end,
        mode = 'n',
        expr = true,
        desc = 'Translate and replace',
      },
    },
    opts = {
      default_engine = 'google',
    },
  },
}
