local lspconfig = require('lspconfig')
local capabilities = require('cmp_nvim_lsp').default_capabilities()
local pipe = '/tmp/godot.pipe'
local on_attach = function(client, bufnr)
  vim.api.nvim_command('echo serverstart("' .. pipe .. '")')
end
lspconfig.gdscript.setup({
  capabilities = capabilities,
  on_attach = on_attach,
})

