" 这里用到在 vim 中嵌入 lua 代码的特殊语法
lua <<EOF
function org_imports(wait_ms)
    local params = vim.lsp.util.make_range_params()
    params.context = {only = {"source.organizeImports"}}
    local result = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params, wait_ms)
    for _, res in pairs(result or {}) do
      for _, r in pairs(res.result or {}) do
        if r.edit then
          vim.lsp.util.apply_workspace_edit(r.edit)
        else
          vim.lsp.buf.execute_command(r.command)
        end
      end
    end
end
EOF

" 在 normal 模式下更新文本后自动导包
" 比如 删除某一行，或者填充 struct 等
autocmd TextChanged *.go :lua org_imports()
" 代码补全结束后自动导包
autocmd CompleteDone *.go :lua org_imports()

autocmd BufWritePre *.go :lua vim.lsp.buf.formatting()
