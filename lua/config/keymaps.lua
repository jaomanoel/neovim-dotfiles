local Util = require("lazyvim.util")

local keymap = vim.keymap
local opts = { noremap = true, silent = true }

-- Save and Quit
keymap.set({ "n", "i", "x" }, "<C-q>", "<cmd>qa<cr>")
keymap.set({ "n", "x" }, "<S-s>", "<cmd>w<cr>")

-- Create line cursor
keymap.set("n", "ou", ":normal! O<CR>:normal! j<CR>", opts)
keymap.set("n", "od", ":normal! o<CR>:normal! k<CR>", opts)
keymap.set("n", "o<leader>", ":normal! o<CR>i", opts)

-- Move to window using the <ctrl> wasd keys
keymap.set("n", "<C-a>", "<C-w>h", opts)
keymap.set("n", "<C-s>", "<C-w>j", opts)
keymap.set("n", "<C-w>", "<C-w>k", opts)
keymap.set("n", "<C-d>", "<C-w>l", opts)

-- Move Lines
keymap.set("n", "<A-s>", "<cmd>m .+1<cr>==", opts)
keymap.set("n", "<A-w>", "<cmd>m .-2<cr>==", opts)
keymap.set("i", "<A-s>", "<esc><cmd>m .+1<cr>==gi", opts)
keymap.set("i", "<A-w>", "<esc><cmd>m .-2<cr>==gi", opts)
keymap.set("v", "<A-s>", ":m '>+1<cr>gv=gv", opts)
keymap.set("v", "<A-w>", ":m '<-2<cr>gv=gv", opts)

-- buffers
keymap.set("n", "<S-a>", "<cmd>bprevious<cr>", opts)
keymap.set("n", "<S-d>", "<cmd>bnext<cr>", opts)

-- floating terminal
local lazyterm = function()
  Util.terminal(nil, { cwd = Util.root() })
end
keymap.set("n", "<F7>", lazyterm)

-- Terminal Mappings
keymap.set("t", "<esc><esc>", "<c-\\><c-n>", opts)
keymap.set("t", "<C-a>", "<cmd>wincmd h<cr>", opts)
keymap.set("t", "<C-s>", "<cmd>wincmd j<cr>", opts)
keymap.set("t", "<C-w>", "<cmd>wincmd k<cr>", opts)
keymap.set("t", "<C-d>", "<cmd>wincmd l<cr>", opts)
keymap.set("t", "<F7>", "<cmd>close<cr>", opts)
