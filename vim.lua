
require'gitsigns'.setup()

require'nvim-treesitter.configs'.setup{
    -- 启用高亮
    highlight = {
        enable = true,
	-- 禁用 vim 基于正则达式的语法高亮，太慢
        additional_vim_regex_highlighting = false,
    },
    -- 启用缩进
    indent = {
        enable = true,
    },
}

local on_attach = function(client, bufnr)
    -- 为方便使用，定义了两个工具函数
    local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
    local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

    -- 配置标准补全快捷键
    -- 在插入模式可以按 <c-x><c-o> 触发补全
    buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

    local opts = { noremap=true, silent=true }

    -- 设置 normal 模式下的快捷键
    -- 第一个参数 n 表示 normal 模式
    -- 第二个参数表示按键
    buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>', opts)
    -- 跳转到定义或者声明的地方
    buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>', opts)
    buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>', opts)
    -- 查看接口的所有实现
    buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>', opts)
    -- 查看所有引用当前对象的地方
    buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<cr>', opts)
    -- 跳转到下一个/上一个语法错误
    buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<cr>', opts)
    buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<cr>', opts)
    buf_set_keymap('n', '<c-k>', '<cmd>lua vim.lsp.buf.signature_help()<cr>', opts)
    -- 手工触发格式化
    buf_set_keymap('n', '<space>f', '<cmd>lua vim.lsp.buf.formatting()<cr>', opts)
    buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<cr>', opts)
    buf_set_keymap('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<cr>', opts)
    buf_set_keymap('n', '<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<cr>', opts)
    -- 列出所有语法错误列表
    buf_set_keymap('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<cr>', opts)
    -- 修改当前符号的名字
    buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<cr>', opts)
    buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<cr>', opts)
    buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<cr>', opts)
    buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<cr>', opts)
end


local cmp = require'cmp'
cmp.setup {
    -- 必须指定 snippet 组件
    snippet = {
        expand = function(args) vim.fn['vsnip#anonymous'](args.body) end,
    },
    mapping = {
      ['<CR>'] = cmp.mapping.confirm({ select = true }),
    },
    -- 配置补全内容来源
    sources = cmp.config.sources {
        -- 支持从打开的文件中补全内容
        { name = 'buffer', option = { get_bufnrs = vim.api.nvim_list_bufs } },
	-- 支持从 lsp 服务补全
        { name = 'nvim_lsp' },
	-- 支持补全文件路径，可以输入 / 或者 ~ 体验
        { name = 'path' },
    },
}

-- 将 cmp-lsp 跟 lsp 服务关联起来
-- 需要更新一上之前的 gopls 配置
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require'cmp_nvim_lsp'.default_capabilities(capabilities)
require'lspconfig'.gopls.setup {
    on_attach = on_attach,
    capabilities = capabilities,
    flags = {
        debounce_text_changes = 150,
    },
}

-- 获取 git path
gitRootPath = vim.api.nvim_eval("system('git rev-parse --show-toplevel 2> /dev/null')[:-2]")
local config = require('go.config')
config.options.test_env = {
	CONF_PATH = gitRootPath,
	MYSQL_ROOT_PASSWORD = 'root'
}

-- null-ls
-- require("null-ls").setup({
--     sources = {
--         -- require("null-ls").builtins.formatting.stylua,
--         -- require("null-ls").builtins.diagnostics.eslint,
--         require("null-ls").builtins.completion.spell,
-- 	require("null-ls").builtins.diagnostics.revive.with({
-- 			args = {"-config", vim.fn.expand("~/.config/nvim/revive.toml"),"-formatter", "json", "./..."},
-- 	}),
--     },
-- })
