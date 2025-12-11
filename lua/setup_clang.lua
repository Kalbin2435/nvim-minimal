return function(capabilities)
    vim.api.nvim_create_autocmd('FileType', {
        pattern = { 'c', 'cpp', 'objc', 'objcpp' },
        callback = function()
            vim.lsp.start({
                name = 'clangd',
                cmd = { 'clangd' },
                root_dir = vim.fs.dirname(vim.fs.find({'.git', 'compile_commands.json'}, { upward = true })[1]),
                capabilities = capabilities,
            })
        end,
    })
end
