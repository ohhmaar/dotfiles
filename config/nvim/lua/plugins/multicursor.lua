-- Multi-Cursor: Edit multiple locations simultaneously
-- Usage: Ctrl+d = select next occurrence, Ctrl+j/k = add cursor up/down
-- Ctrl+L = select all occurrences, mouse click with Ctrl for multiple cursors
-- Once active, type normally to edit all positions at once
return {
  "mg979/vim-visual-multi",
  event = "VeryLazy",
  init = function()
    vim.g.VM_maps = {
      ["Find Under"] = "<C-d>",
      ["Find Subword Under"] = "<C-d>",
      ["Select All"] = "<C-L>",
      ["Add Cursor Down"] = "<C-j>",
      ["Add Cursor Up"] = "<C-k>",
    }
    vim.g.VM_mouse_mappings = 1
    vim.g.VM_theme = "iceblue"
    vim.g.VM_highlight_matches = "underline"
  end,
}