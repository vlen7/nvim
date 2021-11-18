language en_US

set nu
set termguicolors
set cursorline
" 使用 foldexpr 指定的方式折叠代码
set foldmethod=expr
" 使用 treesitter 根据语言语法折叠代码
set foldexpr=nvim_treesitter#foldexpr()
" 默认从第一级开始，大家可以去掉看有什么效果
set foldlevel=1
set noswapfile

color PaperColor

nnoremap <leader>e :NERDTreeToggle<cr>
nnoremap <leader>f :NERDTreeFind<cr>

nnoremap <c-p> :call fzf#Open()<cr>

nnoremap <c-u> :Mru<cr>

runtime vim.lua


