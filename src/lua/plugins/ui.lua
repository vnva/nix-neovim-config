return {
  {
    'nvim-tree/nvim-web-devicons',
    lazy = true,
  },
  {
    'nvim-lualine/lualine.nvim',
    event = 'VeryLazy',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    opts = {
      options = {
        theme = 'auto',
        globalstatus = true,
        component_separators = { left = '│', right = '│' },
        section_separators = { left = '', right = '' },
      },
    },
    config = function(_, opts)
      require('lualine').setup(opts)

      local function transparent_statusline()
        vim.api.nvim_set_hl(0, 'StatusLine', { bg = 'none' })
        vim.api.nvim_set_hl(0, 'StatusLineNC', { bg = 'none' })

        local modes = { 'normal', 'insert', 'visual', 'replace', 'command', 'inactive' }
        local sections = { 'a', 'b', 'c', 'x', 'y', 'z' }
        for _, mode in ipairs(modes) do
          for _, section in ipairs(sections) do
            vim.api.nvim_set_hl(0, 'lualine_' .. section .. '_' .. mode, { bg = 'none' })
          end
        end
      end

      transparent_statusline()
      vim.api.nvim_create_autocmd('ColorScheme', {
        callback = transparent_statusline,
      })
    end,
  },
  {
    'rcarriga/nvim-notify',
    event = 'VeryLazy',
    opts = {
      background_colour = '#000000',
      render = 'minimal',
      stages = 'fade_in_slide_out',
      timeout = 2500,
    },
    config = function(_, opts)
      local notify = require('notify')
      notify.setup(opts)
      vim.notify = notify
    end,
  },
  {
    'folke/noice.nvim',
    event = 'VeryLazy',
    dependencies = {
      'MunifTanjim/nui.nvim',
      'rcarriga/nvim-notify',
    },
    opts = {
      lsp = {
        progress = { enabled = false },
      },
      presets = {
        bottom_search = false,
        command_palette = true,
        long_message_to_split = true,
      },
    },
    config = function(_, opts)
      require('noice').setup(opts)
    end,
  },
}
