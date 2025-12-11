
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
return capabilities
