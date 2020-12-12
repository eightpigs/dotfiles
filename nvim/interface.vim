" 外观
"--------------------------------------------------------------------------

" 配色方案
if has("termguicolors")
 set termguicolors
endif

if has('gui_running')
  set guifont=JetBrains_Mono:10.5
  " 禁止显示滚动条
  set guioptions-=l
  set guioptions-=L
  set guioptions-=r
  set guioptions-=R
  " 禁止显示菜单和工具条
  set guioptions-=m
  set guioptions-=T
endif

" 禁止光标闪k烁
set gcr=a:block-blinkon0

fun! GetHighlightTerm(group, term)
  let output = execute('hi ' . a:group)
  return matchstr(output, a:term.'=\zs\S*')
endfun

fun! ReHighlight() abort
  hi clear VertSplit
  hi clear SignColumn
  hi clear FoldColumn
  hi clear nonText
  hi clear EndOfBuffer

  let l:normal_guibg = GetHighlightTerm("Normal", "guibg")
  let l:visual_guibg = GetHighlightTerm("Visual", "guibg")

  execute 'hi LspReferenceText cterm=bold gui=bold,undercurl ctermfg=1 guibg='l:visual_guibg
  execute 'hi LspReferenceRead cterm=bold gui=bold,undercurl ctermfg=1 guibg='l:visual_guibg
  execute 'hi LspReferenceWrite cterm=bold gui=bold,undercurl ctermfg=1 guibg='l:visual_guibg
  
  execute 'hi LineNr guibg='.l:normal_guibg
  execute 'hi SignColumn guibg='.l:normal_guibg
  execute 'hi nonText guibg='.l:normal_guibg
  execute 'hi EndOfBuffer guibg='.l:normal_guibg
  execute 'hi VertSplit guibg='.l:normal_guibg

  if hlexists('GitGutterAdd')
    execute 'hi gitGutterAdd guibg='.l:normal_guibg
    execute 'hi gitGutterAddIntraLine guibg='.l:normal_guibg
    execute 'hi gitGutterAddInvisible guibg='.l:normal_guibg
    execute 'hi gitGutterChange guibg='.l:normal_guibg
    execute 'hi gitGutterChangeDelete guibg='.l:normal_guibg
    execute 'hi gitGutterChangeInvisible guibg='.l:normal_guibg 
    execute 'hi gitGutterDelete guibg='.l:normal_guibg 
    execute 'hi gitGutterDeleteIntraLine guibg='.l:normal_guibg 
    execute 'hi gitGutterDeleteInvisible guibg='.l:normal_guibg 
  endif

  if hlexists('ALEErrorSign')
    execute 'hi ALEErrorSign guibg='.l:normal_guibg
    execute 'hi ALEWarningSign guibg='.l:normal_guibg
  endif

  if hlexists('Conceal') && exists('g:base16_gui01')
    execute 'hi Conceal guifg=#'.g:base16_gui03
  endif

endfun

fun! ToggleTerminalTheme(next) abort
  :silent call system('change-global-theme '.a:next)
endfun

fun! LightTheme() abort
  let base16colorspace=256
  set background=light
  colorscheme base16-mexico-light
endfun

fun! DarkTheme() abort
  let base16colorspace=256
  set background=dark
  colorscheme base16-default-dark
endfun

fun! SyncTheme(cur) abort
  let s:cur_theme=a:cur
  if len(s:cur_theme) == 0
    let s:cur_theme = readfile($HOME.'/.config/.terminal-theme', '', 1)[0]
  endif

  if s:cur_theme == "dark"
    call DarkTheme()
  else
    call LightTheme()
  endif
  call ReHighlight()
endfun

call SyncTheme('')

command Light call ToggleTerminalTheme('light') | call SyncTheme('light')
command Dark call ToggleTerminalTheme('dark') | call SyncTheme('dark')
command ToggleTheme call ToggleTerminalTheme('') | call SyncTheme('')
