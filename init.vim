language en_US

set nu
set termguicolors
set colorcolumn=80
set cursorline
" 使用 foldexpr 指定的方式折叠代码
set foldmethod=expr
" 使用 treesitter 根据语言语法折叠代码
set foldexpr=nvim_treesitter#foldexpr()
" 默认从第一级开始，大家可以去掉看有什么效果
set foldlevel=99
set noswapfile
set ignorecase
set smartcase

color PaperColor
let g:PaperColor_Theme_Options = {
  \   'theme': {
  \     'default': {
  \       'transparent_background': 1
  \     }
  \   }
  \ }

nnoremap <leader>e :NERDTreeToggle<cr>
nnoremap <leader>f :NERDTreeFind<cr>

nnoremap <c-p> :call fzf#Open()<cr>

nnoremap <c-u> :Mru<cr>

runtime vim.lua

" 在 normal 模式下更新文本后自动导包
" 比如 删除某一行，或者填充 struct 等
" autocmd TextChanged *.go :lua require('modules').org_imports()
" 代码补全结束后自动导包
autocmd CompleteDone *.go :lua require('modules').org_imports()
autocmd BufWritePre *.go :lua vim.lsp.buf.formatting()
autocmd BufWritePre *.go :lua require('modules').org_imports()

