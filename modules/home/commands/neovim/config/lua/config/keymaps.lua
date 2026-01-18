-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local map = LazyVim.safe_keymap_set

map("n", "<leader>fy", function()
	require("util.yazi")(LazyVim.root())
end, { desc = "Yazi (Root Dir)" })

map("n", "<leader>fY", function()
	require("util.yazi")(vim.fn.getcwd())
end, { desc = "Yazi (cwd)" })
