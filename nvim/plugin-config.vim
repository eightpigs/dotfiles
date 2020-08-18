" ------------------------------------------------------------



" 代码缩进 ： indent-guides
" --------------------------------------------------------------
let g:indentLine_color_term = 239
let g:indentLine_color_gui = '#333333'
let g:indentLine_char = '│'
let g:indentLine_color_tty_light = 7 " (default: 4)
let g:indentLine_color_dark = 1 " (default: 2)
" --------------------------------------------------------------


"  TagBar
" --------------------------------------------------------------
let g:tagbar_left = 1
let g:tagbar_width = 45
let g:tagbar_indent = 2
let g:tagbar_show_balloon = 0



" --------------------------------------------------------------

"  nerdtree 和 nerdtree-git-plugin 侧边栏文档 
" --------------------------------------------------------------
" 显示侧边栏，并定位到当前编辑文件
function! NERDTreeToggleInCurDir()                     
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
endfunction

let NERDTreeIgnore = ['\.pyc$', '__pycache__', 'node_modules']

" 设置NERDTree子窗口宽度
let NERDTreeWinSize=35

" 设置NERDTree子窗口位置
let NERDTreeWinPos="right"

" 显示隐藏文件
let NERDTreeShowHidden=1

" NERDTree 子窗口中不显示冗余帮助信息
let NERDTreeMinimalUI=1

" 删除文件时自动删除文件对应 buffer
let NERDTreeAutoDeleteBuffer=1

let g:NERDTreeStatusline = '%#NonText#'

let NERDTreeCascadeOpenSingleChildDir=1

" 使用不同符号标识文件状态
let g:NERDTreeGitStatusIndicatorMapCustom = {
    \ "Modified"  : "✹",
    \ "Staged"    : "✚",
    \ "Untracked" : "✭",
    \ "Renamed"   : "➜",
    \ "Unmerged"  : "═",
    \ "Deleted"   : "✖",
    \ "Dirty"     : "✗",
    \ "Clean"     : "✔︎",
    \ "Unknown"   : "?"
    \ }

" 关闭 vim 的时候如果只剩下 NERDTree, 那么自动关闭 NERDTree
" autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
" --------------------------------------------------------------

" vim-gitgutter 文件显示git更改状态
" --------------------------------------------------------------
set updatetime=250
let g:gitgutter_max_signs = 500
let g:gitgutter_map_keys = 0

" for interface.vim: statusline
function! GitStatus()
  let [a,m,r] = GitGutterGetHunkSummary()
  return printf('+%d ~%d -%d', a, m, r)
endfunction
" --------------------------------------------------------------


" 异步语法检测 
" --------------------------------------------------------------
"始终开启标志列
let g:ale_sign_column_always = 1
let g:ale_set_highlights = 0

"自定义error和warning图标
let g:ale_sign_error = 'x'
let g:ale_sign_warning = '!'


let g:ale_linters = {
\ 'go': ['gopls'],
\ }

" 修复语法
let g:ale_fixers = {
\   'javascript': ['eslint'],
\   'typescript': ['tslint'],
\   'vue': ['eslint'],
\   'html': ['eslint'],
\}

let g:ale_typescript_tslint_use_global = 1
let g:ale_typescript_tslint_executable = 'tslint'
let g:ale_typescript_tslint_config_path = 'tslint.json'

" Write this in your vimrc file
let g:ale_lint_on_text_changed = 'never'
let g:ale_lint_on_insert_leave = 0
let g:ale_lint_on_enter = 0

" 保存时修复
let g:ale_fix_on_save = 1
" --------------------------------------------------------------

" Emmet 
" --------------------------------------------------------------
"  just enable in Normal mode
let g:user_emmet_mode='in'

" Enable just for html/css
let g:user_emmet_install_global = 0
autocmd FileType html,css,vue,htm,eruby EmmetInstall
" --------------------------------------------------------------

" nerdcommenter
"---------------------------------------------------------------
let g:NERDSpaceDelims=1
let g:NERDDefaultAlign = 'left'
let g:NERDCompactSexyComs = 1
let g:NERDCreateDefaultMappings = 1
"---------------------------------------------------------------

" fzf
"---------------------------------------------------------------
let $FZF_DEFAULT_OPTS = '--layout=reverse'
let g:fzf_layout = { 'window': 'call OpenFloatingWin()'}
let g:fzf_preview_window = 'right:50%'
let g:fzf_commits_log_options = '--graph --color=always --format="$FZF_COMMITS_LOG_FORMAT"'

autocmd! filetype fzf
autocmd  filetype fzf set laststatus=2 noshowmode noruler nonumber norelativenumber
  \| autocmd bufleave <buffer> set laststatus=2 showmode ruler number relativenumber

function! OpenFloatingWin()
  let height = &lines - 3
  let width = float2nr(&columns - (&columns * 2 / 10))
  let col = float2nr((&columns - width) / 2)
  " 设置浮动窗口打开的位置，大小等。
  " 这里的大小配置可能不是那么的 flexible 有继续改进的空间
  let opts = {
        \ 'relative': 'editor',
        \ 'row': height * 0.3,
        \ 'col': col,
        \ 'width': width * 2 / 2,
        \ 'height': height / 2 + 5,
        \ }

  let buf = nvim_create_buf(v:false, v:true)
  let win = nvim_open_win(buf, v:true, opts)

  " 设置浮动窗口高亮
  call setwinvar(win, '&winhl', 'Normal:Pmenu')

  setlocal
        \ buftype=nofile
        \ nobuflisted
        \ bufhidden=hide
        \ nonumber
        \ norelativenumber
        \ signcolumn=no
        \ laststatus=2
endfunction

"---------------------------------------------------------------

" vim-ack
"---------------------------------------------------------------
if executable('ag')
  let g:ackprg = 'ag --nogroup --nocolor --column'
  set grepprg =ag\ --nogroup\ --nocolor\ --column
endif
"---------------------------------------------------------------

" vue-vim
"---------------------------------------------------------------
let g:vue_disable_pre_processors=1
autocmd FileType vue syntax sync fromstart
"---------------------------------------------------------------

" typescript-vim
"---------------------------------------------------------------
autocmd FileType typescript :set makeprg=tsc
"---------------------------------------------------------------

" javascript-libraries-syntax.vim
"---------------------------------------------------------------
let g:used_javascript_libs = 'jquery,requirejs,underscore,angularjs,react,flux'
"---------------------------------------------------------------

" UltiSnips
"---------------------------------------------------------------
let g:UltiSnipsExpandTrigger = '<f2>'
let g:UltiSnipsSnippetDirectories = ['UltiSnips']
let g:UltiSnipsEnableSnipMate = 1
let g:UltiSnipsSnippetsDir = '~/.vim/UltiSnips'
"---------------------------------------------------------------

" vim-rooter
"---------------------------------------------------------------
let g:rooter_patterns = ['package.json', '.git', '.git/', '_darcs/', '.hg/', '.bzr/', '.svn/', '.idea/']
let g:rooter_change_directory_for_non_project_files = ''
let g:rooter_silent_chdir = 1
"---------------------------------------------------------------

" easymotion
"---------------------------------------------------------------
" Disable default mappings
let g:EasyMotion_do_mapping = 0
let g:EasyMotion_smartcase = 1
let g:EasyMotion_startofline = 0
"---------------------------------------------------------------

" markdown-preview
"---------------------------------------------------------------
let g:mkdp_auto_start = 0
let g:mkdp_path_to_chrome = 'open -a "Google Chrome"'
let g:mkdp_refresh_slow = 1
"---------------------------------------------------------------

" deoplete
"---------------------------------------------------------------
let g:deoplete#enable_at_startup = 1
call deoplete#custom#option({
    \ 'auto_complete_delay': 200,
    \ 'smart_case': v:true,
    \ 'refresh_always': v:true,
    \ 'min_pattern_length': 2,
    \ })
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
imap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<S-TAB>"
imap <expr><CR> pumvisible() ? deoplete#close_popup() : "\<CR>"
"---------------------------------------------------------------

" vim-go
"---------------------------------------------------------------
let g:go_highlight_build_constraints = 0
let g:go_highlight_extra_types = 0
let g:go_highlight_fields = 0
let g:go_highlight_functions = 0
let g:go_highlight_function_calls = 0
let g:go_highlight_methods = 0
let g:go_highlight_operators = 0
let g:go_highlight_structs = 0
let g:go_highlight_types = 0
" let g:go_auto_sameids = 1
let g:go_updatetime = 300
let g:go_doc_max_height = 20
" let g:go_fmt_command = "goimports"
let g:go_fmt_command = "gofmt"
let g:go_auto_type_info = 1
let g:go_def_mode = 'gopls'
let g:go_info_mode = 'gopls'
let g:go_fmt_fail_silently = 1
" let g:go_gocode_propose_source = 1
"---------------------------------------------------------------


" dart / flutter
"---------------------------------------------------------------
let g:flutter_hot_reload_on_save = 1
let g:flutter_hot_restart_on_save = 0
autocmd BufWritePre *.dart DartFmt
"---------------------------------------------------------------


" Goyo
"---------------------------------------------------------------

let g:goyo_width=120

function! s:goyo_leave()
  source ~/.config/nvim/interface.vim
endfunction

function! s:goyo_enter()
  NERDTreeClose
  TagbarClose
endfunction

autocmd! User GoyoLeave nested call <SID>goyo_leave()
