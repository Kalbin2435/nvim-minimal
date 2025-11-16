vim.cmd [[colorscheme habamax]]

-- nicer completion menu (optional but recommended)
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
vim.api.nvim_set_keymap('n', '<C-o>', '<C-o>zz', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-d>', '<C-d>zz', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-u>', '<C-u>zz', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-p>', ':e **/', { noremap = true, silent = false })
vim.cmd [[autocmd FileType netrw set relativenumber]]
vim.cmd [[autocmd FileType netrw set number]]
vim.opt.path:append { '**' }
vim.opt.wildmenu = true
vim.opt.splitbelow = true

vim.lsp.config('clangd', {
    cmd = { 'clangd' },
    filetypes = { 'c', 'cpp', 'objc', 'objcpp', 'cuda' },
    root_markers = {
        '.clangd', '.clang-tidy', '.clang-format',
        'compile_commands.json', 'compile_flags.txt',
        'configure.ac', '.git',
    },
})

vim.lsp.enable('clangd')
-- make LSP provide omni-completion
vim.api.nvim_create_autocmd('LspAttach', {
    callback = function(args)
        vim.bo[args.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'
        vim.lsp.completion.enable(true, args.data.client_id, args.buf, {autotrigger=true}) 
    end,
})
