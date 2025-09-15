-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- old keymaps deletion
vim.keymap.del("n", "<leader>l", {})
vim.keymap.del("n", "<leader>qq", {})
vim.keymap.del("n", "<leader>cm", {})

-- old keymaps reset
vim.keymap.set("n", "<leader>ol", "<CMD>Lazy<CR>", { desc = "Open Lazy Menu" })
vim.keymap.set("n", "<leader>om", "<CMD>Mason<CR>", { desc = "Open Mason Menu" })
vim.keymap.set("n", "<leader>q", "<CMD>qall!<CR>", { desc = "Open Lazy Menu" })

vim.keymap.set("n", "<leader>h", ":vsp<CR>", { desc = "Split horizontally" })
vim.keymap.set("n", "<leader>v", ":split<CR>", { desc = "Split vertically" })

local conform = require("conform")
vim.keymap.set({ "n", "v" }, "<leader>l", function()
  conform.format({
    lsp_fallback = true,
    async = false,
    timeout_ms = 1000,
  })
end, { desc = "Format file or range (in visual mode)" })
