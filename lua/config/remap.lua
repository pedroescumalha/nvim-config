vim.keymap.set("n", "<leader>ex", vim.cmd.Ex)

-- Tabs
vim.keymap.set("n", "<leader>to", ":tabnew<Enter>")
vim.keymap.set("n", "<leader>tc", ":tabclose<Enter>")
vim.keymap.set("n", "<leader>tn", ":tabn<Enter>")
vim.keymap.set("n", "<leader>tp", ":tabp<Enter>")
-- Movement
vim.keymap.set("v", "<C-j>", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "<C-k>", ":m '<-2<CR>gv=gv")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "<C-d>", "<C-d>zz")

-- Highlight on yank
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = '*',
})

