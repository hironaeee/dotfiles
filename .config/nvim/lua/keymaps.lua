local keymap = vim.keymap

-- split window
keymap.set("n", "sv", ":vsplit<Return><C-w>w")
keymap.set("n", "ss", ":split<Return><C-w>w")
-- switch window
keymap.set("n", "sh", "<C-w>h")
keymap.set("n", "sj", "<C-w>j")
keymap.set("n", "sk", "<C-w>k")
keymap.set("n", "sl", "<C-w>l")

-- tab
keymap.set("n", "te", ":tabedit<Return>")
keymap.set("n", "<S-Tab>", ":tabprev<Return>")
keymap.set("n", "<Tab>", ":tabnext<Return>")
