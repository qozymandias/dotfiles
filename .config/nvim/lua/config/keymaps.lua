-- Global keymaps independent of any plugin.

local map = vim.keymap.set

map("i", "<C-u>", "<NOP>")
map("n", "<space>", "<NOP>")
map("n", "Q", "gq<CR>", { noremap = true })

map("n", "<leader>w", ":w!<CR>", { desc = "Save" })
map("n", "<leader>wq", ":wq!<CR>", { desc = "Save and quit" })
map("n", "<leader>q", ":q<CR>", { desc = "Quit" })
map("n", "<leader>nu", ":set nu!<CR>", { desc = "Toggle line numbers" })

map("n", "<leader>j", "gj")
map("n", "<leader>k", "gk")

map("n", "Y", "y$", { noremap = true })

if vim.fn.has("macunix") == 1 then
    map("v", "<C-c>", ":w !pbcopy<CR><CR>")
else
    map("v", "<C-c>", ":w !clip.exe<CR><CR>")
end

map("n", "<C-_>", ":set hlsearch!<CR>", { silent = true })

map("n", "<C-k>", "(line('.') - search('^\\n.\\+$', 'Wenb')) . 'kzv^'", { expr = true, silent = true })
map("n", "<C-j>", "(search('^\\n.', 'Wen') - line('.')) . 'jzv^'", { expr = true, silent = true })

map("c", "<C-A>", "<Home>")
map("c", "<C-E>", "<End>")

map("t", "<Esc>", [[<C-\><C-n>]])

map("x", "<", "<gv")
map("x", ">", ">gv")

map("n", "<Up>", ":resize +3<CR>")
map("n", "<Down>", ":resize -3<CR>")
map("n", "<Left>", ":vertical resize -3<CR>")
map("n", "<Right>", ":vertical resize +3<CR>")

map("n", "<C-Tab>", "<C-w>w")
map("n", "<C-S-Tab>", "<C-w>W")
map("n", "<C-A-Tab>", "<C-w>r")

map("n", "<leader>t", ":tab split<CR>")
map("", "<C-\\>", [[:tab split<CR>:exec("tag ".expand("<cword>"))<CR>]])
map("", "<A-]>", [[:vsp <CR>:exec("tag ".expand("<cword>"))<CR>]])

map("", "<leader>1", ":setlocal spell! spelllang=en_au<CR>")
map("", "<leader>2", ":set rnu!<CR>")

map("n", "ZS", ":w<CR>")
map("n", "ZX", ":qa<CR>")

map("n", "<leader>f}", "zfa}")
map("n", "<leader>fc", "zd")
map("i", "<F9>", "<C-O>za")
map("n", "<F9>", "za")
map("o", "<F9>", "<C-C>za")
map("v", "<F9>", "zf")
map("n", "<C-Z>", "<NOP>")
map("n", "<C-S-Z>", "<NOP>")

map(
    "n",
    "<leader>sb",
    ":if &scrollbind | windo set noscrollbind nocursorbind | else | windo set scrollbind cursorbind | endif<CR>"
)

map("n", "<leader>gm", ":Git mergetool<CR>", { desc = "Git mergetool" })

vim.api.nvim_create_user_command("W", "w !sudo tee % > /dev/null", {})
