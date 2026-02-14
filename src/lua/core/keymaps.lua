local keymap = vim.keymap.set

keymap('n', '<leader>w', '<cmd>w<cr>', { desc = 'Save file' })
keymap('n', '<leader>q', '<cmd>q<cr>', { desc = 'Quit' })
keymap('n', '<leader>ff', function()
  require('telescope.builtin').find_files()
end, { desc = 'Find files' })
keymap('n', '<leader>fg', function()
  require('telescope.builtin').live_grep()
end, { desc = 'Live grep' })
keymap('n', '<leader>fe', function()
  require('telescope').extensions.file_browser.file_browser({
    path = vim.fn.expand('%:p:h'),
    select_buffer = true,
  })
end, { desc = 'File explorer' })
keymap('n', '<leader>fr', function()
  require('telescope').extensions.frecency.frecency()
end, { desc = 'Recent files (frecency)' })
keymap('n', '<leader>fd', function()
  require('telescope.builtin').diagnostics()
end, { desc = 'Diagnostics' })
keymap('n', '<leader>h', '<C-w>h', { desc = 'Go to left window' })
keymap('n', '<leader>j', '<C-w>j', { desc = 'Go to lower window' })
keymap('n', '<leader>k', '<C-w>k', { desc = 'Go to upper window' })
keymap('n', '<leader>l', '<C-w>l', { desc = 'Go to right window' })
