return {
  {
    'nvim-telescope/telescope.nvim',
    cmd = 'Telescope',
    dependencies = {
      'nvim-lua/plenary.nvim',
    },
    opts = {
      defaults = {
        sorting_strategy = 'ascending',
        file_ignore_patterns = {
          '^.git/',
        },
        vimgrep_arguments = {
          'rg',
          '--color=never',
          '--no-heading',
          '--with-filename',
          '--line-number',
          '--column',
          '--smart-case',
          '--hidden',
          '--glob',
          '!.git/*',
        },
        layout_config = {
          prompt_position = 'top',
        },
      },
      pickers = {
        find_files = {
          hidden = true,
          find_command = {
            'fd',
            '--type',
            'f',
            '--hidden',
            '--exclude',
            '.git',
          },
        },
      },
    },
    config = function(_, opts)
      require('telescope').setup(opts)
    end,
  },
}
