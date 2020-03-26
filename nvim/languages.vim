" ------------------------------------------------------------
" Golang
" ------------------------------------------------------------

func! BuildAndInstall()                     
  exe ":GoBuild"
  exe ":GoInstall"
endfunc

" debug run
au FileType go nnoremap <leader>dr :GoDebug<cr>
" toggle debug breakpoint
au FileType go nnoremap <leader>db :DlvToggleBreakpoint<cr>
" format code
au FileType go nnoremap <leader>ff :GoImports<cr>
" go to the definition
au FileType go nnoremap <leader>f[ :GoDef<cr>
" displays the docs of the current under mouse variable / obj
au FileType go nnoremap <leader>f' :GoDoc<cr>
" go to parent / implements
au FileType go nnoremap <leader>fs <Plug>(go-implements)
" build
au FileType go nnoremap <leader>fb :call BuildAndInstall()<cr>
" show all declares
au FileType go nnoremap <leader>f; :GoDeclsDir<cr>
" rename
au FileType go nnoremap <leader>fr :GoRename<cr>
" preview current documents(eg: MarkdownPreview)
au FileType go nnoremap <leader>fp :echo "无法预览"<cr>
au FileType go nnoremap <leader>fi :GoImports<cr>



" ------------------------------------------------------------
" Markdown
" ------------------------------------------------------------

" preview current documents(eg: MarkdownPreview)
au FileType markdown nnoremap <leader>fp :MarkdownPreview<cr>




" ------------------------------------------------------------
" Vue
" ------------------------------------------------------------
autocmd BufRead,BufNewFile *.vue setlocal filetype=html


" ------------------------------------------------------------
" Dart
" ------------------------------------------------------------
au FileType dart nnoremap <leader>dr :FlutterVisualDebug<cr>
au FileType dart nnoremap <leader>du :FlutterHotReload<cr>
au FileType dart nnoremap <leader>dR :FlutterHotRestart<cr>
" format code
au FileType dart nnoremap <leader>ff :DartFmt -l 120<cr>
