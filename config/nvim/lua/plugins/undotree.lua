-- Undo Tree: Visual undo history browser
-- Usage: <leader>u to open. Navigate your edit history like a tree structure.
-- Shows branches of your undo history, not just linear undo/redo.
return {
  "mbbill/undotree",
  keys = {
    { "<leader>u", "<cmd>UndotreeToggle<cr>", desc = "Undo Tree" },
  },
  config = function()
    vim.g.undotree_WindowLayout = 2
    vim.g.undotree_SetFocusWhenToggle = 1
    vim.g.undotree_ShortIndicators = 1
  end,
}