return function(capabilities)
    vim.api.nvim_create_autocmd('FileType', {
        pattern = 'python',
        callback = function()
            vim.lsp.start({
                name = 'pyright',
                -- 'pyright-langserver' is usually the executable exposed for LSP. 
                -- If you get an error, check if your terminal uses 'pyright' instead.
                cmd = { 'pyright-langserver', '--stdio' }, 

                -- Look for standard Python project markers
                root_dir = vim.fs.dirname(vim.fs.find({
                    'pyproject.toml', 
                    'setup.py', 
                    'setup.cfg', 
                    'requirements.txt', 
                    'Pipfile', 
                    '.git'
                }, { upward = true })[1]),

                capabilities = capabilities,

                -- Optional settings to fine-tune analysis
                settings = {
                    python = {
                        analysis = {
                            autoSearchPaths = true,
                            useLibraryCodeForTypes = true,
                            -- 'workspace' analyzes the whole project (slower but more accurate)
                            -- 'openFilesOnly' is lighter on resources
                            diagnosticMode = 'workspace', 
                        },
                    },
                },
            })
        end,
    })
end
