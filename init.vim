language en_US.UTF-8

echo ">^.^<"


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

nnoremap <silent> <leader>e :NERDTreeToggle<cr>
nnoremap <silent> <leader>f :NERDTreeFind<cr>

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

" 自动加载tag
command! -nargs=* -range GoAddTags call lv#gomodifytags(<line1>, <line2>, <count>, '-add-tags', <f-args>)
command! -nargs=* -range GoAddJsonTags call lv#gomodifytags(<line1>, <line2>, <count>, '-add-tags', 'json', <f-args>)
command! -nargs=* -range GoAddOptionTags call lv#gomodifytags(<line1>, <line2>, <count>, '-add-tags', 'json', '-add-options json=omitempty', <f-args>)
command! -nargs=* -range GoClearTags call lv#gomodifytags(<line1>, <line2>, <count>, '-clear-tags', <f-args>)
command! -nargs=* -range GoRemoveTags call lv#gomodifytags(<line1>, <line2>, <count>, '-remove-tags', <f-args>)
command! -nargs=* -range GoRemoveJsonTags call lv#gomodifytags(<line1>, <line2>, <count>, '-remove-tags', 'json', <f-args>)



" snippet
" NOTE: You can use other key to expand snippet.

" Expand
imap <expr> <C-j>   vsnip#expandable()  ? '<Plug>(vsnip-expand)'         : '<C-j>'
smap <expr> <C-j>   vsnip#expandable()  ? '<Plug>(vsnip-expand)'         : '<C-j>'

" Expand or jump
imap <expr> <C-l>   vsnip#available(1)  ? '<Plug>(vsnip-expand-or-jump)' : '<C-l>'
smap <expr> <C-l>   vsnip#available(1)  ? '<Plug>(vsnip-expand-or-jump)' : '<C-l>'

" Jump forward or backward
imap <expr> <Tab>   vsnip#jumpable(1)   ? '<Plug>(vsnip-jump-next)'      : '<Tab>'
smap <expr> <Tab>   vsnip#jumpable(1)   ? '<Plug>(vsnip-jump-next)'      : '<Tab>'
imap <expr> <S-Tab> vsnip#jumpable(-1)  ? '<Plug>(vsnip-jump-prev)'      : '<S-Tab>'
smap <expr> <S-Tab> vsnip#jumpable(-1)  ? '<Plug>(vsnip-jump-prev)'      : '<S-Tab>'

" Select or cut text to use as $TM_SELECTED_TEXT in the next snippet.
" See https://github.com/hrsh7th/vim-vsnip/pull/50
nmap        s   <Plug>(vsnip-select-text)
xmap        s   <Plug>(vsnip-select-text)
nmap        S   <Plug>(vsnip-cut-text)
xmap        S   <Plug>(vsnip-cut-text)

" If you want to use snippet for multiple filetypes, you can `g:vsnip_filetypes` for it.
let g:vsnip_filetypes = {}
let g:vsnip_filetypes.javascriptreact = ['javascript']
let g:vsnip_filetypes.typescriptreact = ['typescript']

" air-line
let g:airline#extensions#tabline#enabled = 1

" colorscheme Terafox
"

" GO TEST
command! GoTest lua require('go.test').test()
command! GoTestAll lua require('go.test').test_all()
command! GoTestFunc lua require('go.test').test_func()
command! GoTestFile lua require('go.test').test_file()
command! -nargs=? -complete=command GoToTest lua require('go.test').test_open(<f-args>)

" popup exit with only q
" function! OmniPopup(action)
"     echo a:action
"     echo pumvisible()
"     if pumvisible()
"         echo a:action
"         if a:action == 'q'
"             return ":q"
"         elseif a:action == 'k'
"             return "\<C-P>"
"         endif
"     endif
"     return a:action
" endfunction
" 
" nnoremap q :call OmniPopup('q')<cr>
"


