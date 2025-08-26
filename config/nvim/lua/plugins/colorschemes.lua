return {
  {
    "sainnhe/gruvbox-material",
    priority = 1000,
    config = function()
      -- Configure before loading
      vim.g.gruvbox_material_background = 'hard'
      vim.g.gruvbox_material_palette = 'material' -- or 'mix', 'original'
      vim.g.gruvbox_material_foreground = 'material'

      vim.cmd([[colorscheme gruvbox-material]])
    end,
  },
}
