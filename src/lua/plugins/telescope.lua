return {
  {
    'nvim-telescope/telescope.nvim',
    cmd = 'Telescope',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-telescope/telescope-file-browser.nvim',
      'nvim-telescope/telescope-frecency.nvim',
      'nvim-telescope/telescope-media-files.nvim',
    },
    opts = {
      defaults = {
        sorting_strategy = 'ascending',
        wrap_results = true,
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
        diagnostics = {
          layout_strategy = 'vertical',
          layout_config = {
            width = 0.95,
            height = 0.95,
            preview_cutoff = 1,
          },
        },
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
      extensions = {
        file_browser = {
          hidden = true,
          grouped = true,
          hijack_netrw = true,
          respect_gitignore = false,
        },
        frecency = {
          show_scores = true,
          show_unindexed = true,
          ignore_patterns = { '*.git/*', '*/tmp/*' },
        },
        media_files = {
          filetypes = { 'png', 'webp', 'jpg', 'jpeg', 'mp4', 'webm', 'pdf' },
          find_cmd = 'rg',
        },
      },
    },
    config = function(_, opts)
      local telescope = require('telescope')
      telescope.setup(opts)
      telescope.load_extension('file_browser')
      telescope.load_extension('frecency')
      telescope.load_extension('media_files')
    end,
  },
}
