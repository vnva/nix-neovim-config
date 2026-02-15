return {
  {
    'supermaven-inc/supermaven-nvim',
    event = 'InsertEnter',
    config = function()
      require('supermaven-nvim').setup({
        keymaps = {
          accept_suggestion = '<C-l>',
          clear_suggestion = '<C-]>',
          accept_word = '<C-j>',
        },
        disable_inline_completion = false,
        disable_keymaps = false,
        log_level = 'off',
      })
    end,
  },
}
