return function(capabilities)
    vim.api.nvim_create_autocmd('FileType', {
        pattern = 'lua',
        callback = function()
            vim.lsp.start({
                name = 'lua_ls',
                -- If 'lua-language-server.exe' is in your PATH, you can just use the command name:
                cmd = { 'lua-language-server' },
                -- Find root directory based on git or specific lua config files
                root_dir = vim.fs.dirname(vim.fs.find({'.git', '.luarc.json'}, { upward = true })[1]),
                capabilities = capabilities,
                -- Specific settings to make it work better with Neovim
                settings = {
                    Lua = {
                        runtime = {
                            -- Tell the language server which version of Lua you're using
                            version = 'LuaJIT',
                        },
                        diagnostics = {
                            -- Get the language server to recognize the `vim` global
                            globals = { 'vim' },
                        },
                        workspace = {
                            -- Make the server aware of Neovim runtime files
                            library = vim.api.nvim_get_runtime_file("", true),
                            checkThirdParty = false, -- Disable asking to configure environment
                        },
                        telemetry = { enable = false },
                    },
                },
            })
        end,
    })
end
