return {
  'folke/which-key.nvim',
  event = "VeryLazy",
  opts = {
    preset = "helix",
    delay = 1000,
    icons = {
      mappings = vim.g.have_nerd_font,
      keys = {},
    },
    spec = {
      { '<leader>s', group = '[S]earch' },
      { '<leader>t', group = '[T]oggle' },
      { '<leader>j', group = '[J]ournal' },
      { '<leader>u', group = 'Color Schemes' },
      { '<leader>g', group = '[G]it' },
      { '<leader>h', group = 'Git [H]unk', mode = { 'n', 'v' } },
    },
  },
}
