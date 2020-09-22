" ------------------------------------------------------------
" Markdown
" ------------------------------------------------------------

" preview current documents(eg: MarkdownPreview)
au FileType markdown nnoremap <leader>fp :MarkdownPreview<cr>



" ------------------------------------------------------------
" VIM Script
" ------------------------------------------------------------
" execute current line
au FileType vim nnoremap <silent> <f5> :execute getline(".")<cr>

