return {
  {
  'stevearc/oil.nvim',
  dependencies = { { "echasnovski/mini.icons", opts = {} } },
  config = function()
      local detail = false
      require("oil").setup({
        default_file_explorer = true,
        view_options = {
          show_hidden = true,
        }
      })
}
}

