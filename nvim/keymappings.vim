" ------------------------------------------------------------
"  Prefix keys
" ------------------------------------------------------------

" 定义快捷键的前缀，即<leader>
let mapleader="\<Space>"

" search prefix key: s
" buffer prefix key: b
" window prefix key: w
" debug / run prefix key: d
" content prefix key: f

" ------------------------------------------------------------
" Misc
" ------------------------------------------------------------

" 显示侧边栏，并定位到当前编辑文件
func! NERDTreeToggleInCurDir()                     
" If NERDTree is open in the current buffer
    if (exists("t:NERDTreeBufName") && bufwinnr(t:NERDTreeBufName) != -1)
        exe ":NERDTreeClose"
    else
        if (expand("%:t") != '')
            " exe ":NERDTreeToggle"
            exe ":NERDTreeFind"
        else
            exe ":NERDTreeToggle"
        endif
    endif
endfunc

" show file explorer
nnoremap <silent> <leader>' :call NERDTreeToggleInCurDir()<cr>

" show tag list
nnoremap <silent> <leader>[ :TagbarToggle<cr>

" search all files(fzf)
nnoremap <silent> <leader>; :call fzf#run({'right': '45%', 'sink': ' e' })<cr>

" clean all highlight(:nohlsearch)
nnoremap <silent> <leader>\ :nohlsearch<cr>

noremap <silent> U <C-r>
noremap <silent> H ^
noremap <silent> L $

nmap / <Plug>(easymotion-sn)
omap / <Plug>(easymotion-tn)
nmap n <Plug>(easymotion-next)
nmap N <Plug>(easymotion-prev)

" w!! to write a file as sudo
" stolen from skwp/dotfiles
cmap w!! w !sudo tee % >/dev/null

vmap v <Plug>(expand_region_expand)
vmap V <Plug>(expand_region_shrink)


" ------------------------------------------------------------
" Jump
" ------------------------------------------------------------

" to left in line
nmap <silent> <leader>jh <Plug>(easymotion-linebackward)
" to right in line
nmap <silent> <leader>jl <Plug>(easymotion-lineforward)
" to top 
nmap <silent> <leader>jk <Plug>(easymotion-k)
" to bottom
nmap <silent> <leader>jj <Plug>(easymotion-j)

" 跳转到前一次修改或后一次修改时，居中
nnoremap <silent> <leader>, g;zz
nnoremap <silent> <leader>. g,zz

" search all line & jump to(fzf :Lines)
nnoremap <silent> <leader>jf :Lines<cr>


" ------------------------------------------------------------
" Buffer / Windows
" ------------------------------------------------------------

" close current buffer
nnoremap <silent> <leader>q :q!<cr>
" close all buffer
nnoremap <silent> <leader>Q :qa!<cr>
" save buffer
nnoremap <silent> <leader>i :w<cr>
" save all buffer
nnoremap <silent> <leader>I :wa<cr>
" open new buffer (:vnew)
nnoremap <silent> <leader>bn :vnew<cr>
" close other buffers
nnoremap <silent> <leader>bo :only<cr>
" search all buffers(fzf :Buffers)
nnoremap <silent> <leader>bb :Buffers<cr>

" switch to next buffer(:bn)
nnoremap <silent> <tab> :bn<cr>
" switch to prev buffer(:bp)
nnoremap <silent> <s-tab> :bp<cr>

" jump to right buffer
nnoremap <silent> <leader>wl <C-W>l
" jump to left buffer
nnoremap <silent> <leader>wh <C-W>h
" jump to top buffer
nnoremap <silent> <leader>wk <C-W>k
" jump to bottom buffer
nnoremap <silent> <leader>wj <C-W>j

" split buffer(vertical)
nnoremap <silent> <leader>w' <C-W>s
" split buffer(horizontal)
nnoremap <silent> <leader>w; <C-W>v

" resize window size
nmap <leader>w= :resize +5<cr>
nmap <leader>w- :resize -5<cr>
nmap <leader>w] :vertical resize -5<cr>
nmap <leader>w[ :vertical resize +5<cr>

" ------------------------------------------------------------
" Content
" ------------------------------------------------------------

" switch params to left (sideways.vim)
nnoremap <silent> <leader>fh :SidewaysLeft<cr>
" switch params to right (sideways.vim)
nnoremap <silent> <leader>fl :SidewaysRight<cr>
" switch current line to buttom
nnoremap <silent> <leader>fj ddp
" switch current line to top
nnoremap <silent> <leader>fk ddkP
" format code
nnoremap <leader>ff :echo "请根据语言自己配置: 代码格式化"<cr>
" go to the definition
nnoremap <leader>f[ :echo "请根据语言自己配置: 前往定义处"<cr>
" displays the docs of the current under mouse variable / obj
nnoremap <leader>f' :echo "请根据语言自己配置: 显示文档"<cr>
" go to parent / implements
nnoremap <leader>fs :echo "请根据语言自己配置: 前往父级/接口"<cr>
" build
nnoremap <leader>fb :echo "请根据语言自己配置: 编译"<cr>
" show all declares
nnoremap <leader>f; :echo "请根据语言自己配置: 显示所有的定义"<cr>
" rename
nnoremap <leader>fr :echo "请根据语言自己配置: 重命名"<cr>

" next error / warning
nnoremap <leader>f, :ALENextWrap<cr>zz
" prev error / warning
nnoremap <leader>f. :ALEPreviousWrap<cr>zz 
" current error / warning details
nnoremap <leader>f/ :ALEDetail<cr>
" preview current documents(eg: MarkdownPreview)
nnoremap <leader>fp :echo "请根据语言自己配置: 预览"<cr>

" Git
" ---------
nnoremap <leader>gp <Plug>(GitGutterPreviewHunk)<cr>



" ------------------------------------------------------------
" Search
" ------------------------------------------------------------

func! SearchCursor()
  let keyword = expand("<cword>")
  exec ":Ag " . keyword
endfunc

" search keyword in all files
nnoremap <leader>s; :Ag<space>

" search cursor word in all files
nnoremap <leader>s' :call SearchCursor()<cr>
nnoremap <leader>] :Files<cr>




" ------------------------------------------------------------
" Comments
" ------------------------------------------------------------

" toggle comments
nmap <silent> <leader>/ <Plug>NERDCommenterToggle
" toggle comments
vmap <silent> <leader>/ <Plug>NERDCommenterToggle




" ------------------------------------------------------------
" Debug / Run
" ------------------------------------------------------------

" debug run
nnoremap <leader>dr :echo "请根据语言自己配置: 调试"<cr>

" debug restart
nnoremap <leader>dR :echo "请根据语言自己配置: 重启"<cr>

" toggle debug breakpoint
nnoremap <leader>db :echo "请根据语言自己配置: 添加/删除断点"<cr>

" debug hot load
nnoremap <leader>du :echo "请根据语言自己配置: 热加载"<cr>
