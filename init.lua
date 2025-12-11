require("autocomplete")
vim.cmd [[colorscheme onedark]]
vim.o.completeopt = 'menu,menuone,noselect'
vim.opt.guicursor = ""
vim.opt.ignorecase = true
vim.opt.nu = true
vim.opt.rnu = true
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.wrap = false
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.hlsearch = false
vim.opt.incsearch = true
vim.opt.termguicolors = true
vim.opt.scrolloff = 8
vim.keymap.set("n", "Q", "<nop>")
vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.api.nvim_set_keymap('n', '<C-o>', '<C-o>zz', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-d>', '<C-d>zz', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-u>', '<C-u>zz', { noremap = true, silent = true })
vim.cmd [[autocmd FileType netrw set relativenumber]]
vim.cmd [[autocmd FileType netrw set number]]
vim.opt.wildmenu = true
vim.opt.splitbelow = true

vim.api.nvim_create_autocmd("TermOpen", {
  callback = function()
    vim.wo.relativenumber = true
    vim.wo.number = true -- Optional: for hybrid line numbers
  end,
})

-- Setup mini.pick (Fuzzy Finder)
require('mini.pick').setup()

vim.keymap.set('n', '<C-p>', function()
  MiniPick.builtin.files({ tool = 'git' }) 
end, { desc = 'Find Files' })

vim.keymap.set('n', '<leader>ff', function()
  MiniPick.builtin.files({ tool = 'rg' }) 
end, { desc = 'Find Files' })

vim.keymap.set('n', '<leader>fg', function()
  MiniPick.builtin.grep_live()
end, { desc = 'Find Grep (Content)' })
