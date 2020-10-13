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
  if (a > 0 || m > 0 || r > 0)
    return printf('[+%d ~%d -%d]', a, m, r)
  endif
  return ''
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


" nerdcommenter
"---------------------------------------------------------------
let g:NERDSpaceDelims=1
let g:NERDDefaultAlign = 'left'
let g:NERDCompactSexyComs = 1
let g:NERDCreateDefaultMappings = 1
"---------------------------------------------------------------

" fzf
"---------------------------------------------------------------
let $FZF_DEFAULT_OPTS = '--exact --layout=reverse --border=rounded --ansi --color=16'
let g:fzf_layout = { 'window': 'call OpenFloatingWin()'}
let g:fzf_preview_window = 'right:0%'
let g:fzf_commits_log_options = '--graph --color=always --format="$FZF_COMMITS_LOG_FORMAT"'

let g:fzf_colors =
\ { 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'border':  ['fg', 'PreProc'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'] } 

autocmd! filetype fzf
autocmd  filetype fzf set laststatus=2 noshowmode noruler nonumber norelativenumber
  \| autocmd bufleave <buffer> set laststatus=2 showmode ruler number relativenumber

function! OpenFloatingWin()
  let lineCount = &lines 
  let width = float2nr(&columns * 0.7)
  let height = float2nr(lineCount / 2)
  let col = float2nr((&columns - width) / 2)
  let row = (lineCount - height) / 2

  let opts = {
        \ 'relative': 'editor',
        \ 'row': row,
        \ 'col': col,
        \ 'width': width,
        \ 'height': height,
        \ }

  let buf = nvim_create_buf(v:false, v:true)
  let win = nvim_open_win(buf, v:true, opts)

  call setwinvar(win, '&winhl', 'Normal:Pmenu')
endfunction

"---------------------------------------------------------------

" vim-ack
"---------------------------------------------------------------
if executable('ag')
  let g:ackprg = 'ag --nogroup --nocolor --column'
  set grepprg =ag\ --nogroup\ --nocolor\ --column
endif
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
let g:rooter_patterns = ['.git', '.svn/', '.idea/', 'package.json', '_darcs/', '.hg/', '.bzr/']
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


" editorconfig-vim
"---------------------------------------------------------------
let g:EditorConfig_exclude_patterns = ['fugitive://.*', 'scp://.*']


" emment-vim
"---------------------------------------------------------------
let g:user_emmet_mode='i'
let g:user_emmet_install_global = 0
autocmd FileType html,css,vue EmmetInstall
let g:user_emmet_leader_key='<leader>t'
