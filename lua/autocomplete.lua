-- 1. Setup nvim-cmp
local cmp = require('cmp')

cmp.setup({
  -- Use Neovim's native snippet expansion (no extra plugins needed)
  snippet = {
    expand = function(args)
      vim.snippet.expand(args.body)
    end,
  },
  -- Basic mapping (modify as you like)
  mapping = cmp.mapping.preset.insert({
    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.abort(),
    ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item
  }),
  -- The source for LSP data
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
  })
})

local capabilities = require('cmp_nvim_lsp').default_capabilities()
-- 3. Create an Autocommand to start the LSP for C/C++ files
vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'c', 'cpp', 'objc', 'objcpp' },
  callback = function()
    -- Start the client natively
    vim.lsp.start({
      name = 'clangd',
      cmd = { 'clangd' },
      root_dir = vim.fs.dirname(vim.fs.find({'.git', 'compile_commands.json'}, { upward = true })[1]),
      capabilities = capabilities,
    })
  end,
})

-- 4. Lua Setup (lua-language-server)
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



-- 5. Python Setup (Pyright)
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
