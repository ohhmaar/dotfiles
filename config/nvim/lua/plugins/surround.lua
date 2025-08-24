-- Surround: Add/change/delete surrounding characters
-- Usage: ys{motion}{char} = add surround, cs{old}{new} = change, ds{char} = delete
-- Examples: ysiw" (wrap word in quotes), cs"' (change " to '), ds" (remove quotes)
-- Visual mode: S{char} = surround selection
return {
  "kylechui/nvim-surround",
  version = "*",
  event = "VeryLazy",
  config = function()
    require("nvim-surround").setup({
      keymaps = {
        insert = "<C-g>s",
        insert_line = "<C-g>S",
        normal = "ys",
        normal_cur = "yss",
        normal_line = "yS",
        normal_cur_line = "ySS",
        visual = "S",
        visual_line = "gS",
        delete = "ds",
        change = "cs",
        change_line = "cS",
      },
    })
  end,
}