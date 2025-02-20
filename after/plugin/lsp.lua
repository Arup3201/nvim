local lsp = require('lsp-zero').preset("recommended")

lsp.ensure_installed({
	"ast_grep", 
	"biome", 
	"grammarly", 
	"bashls", 
})

local lsp_config = require'lspconfig'
lsp_config.ast_grep.setup{}
lsp_config.biome.setup{}
lsp_config.pyright.setup{}
lsp_config.grammarly.setup{}
lsp_config.bashls.setup{}

local cmp = require('cmp')
local cmp_select = { behaviour = cmp.SelectBehavior.Select }

cmp_mappings = cmp.mapping.preset.insert({
	['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
	['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
	['<C-y>'] = cmp.mapping.confirm({ select = true }),
	['<C-space>'] = cmp.mapping.complete(),
})

lsp.set_preferences({
	sign_icons = false	
})

lsp.setup_nvim_cmp({
	mappings = cmp_mappings 

})

lsp.on_attach(function(event)
	local opts = {buffer = event.buf}

	vim.keymap.set('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>', opts)
	vim.keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>', opts)
	vim.keymap.set('n', '<leader>vd', '<cmd>lua vim.diagnostic.open_float()<cr>', opts)
	vim.keymap.set('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>', opts)
	vim.keymap.set('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>', opts)
	vim.keymap.set('n', 'go', '<cmd>lua vim.lsp.buf.type_definition()<cr>', opts)
	vim.keymap.set('n', 'gr', '<cmd>lua vim.lsp.buf.references()<cr>', opts)
	vim.keymap.set('n', 'gs', '<cmd>lua vim.lsp.buf.signature_help()<cr>', opts)
	vim.keymap.set('n', '<F2>', '<cmd>lua vim.lsp.buf.rename()<cr>', opts)
	vim.keymap.set({'n', 'x'}, '<F3>', '<cmd>lua vim.lsp.buf.format({async = true})<cr>', opts)
	vim.keymap.set('n', '<F4>', '<cmd>lua vim.lsp.buf.code_action()<cr>', opts)
end)

lsp.setup()
