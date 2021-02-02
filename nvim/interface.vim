" 外观
"--------------------------------------------------------------------------

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

func! Statusline() abort
  hi clear StatusLine
  hi clear StatusLineNC
  hi StatusLine     ctermfg=0     guifg=#666666
  hi StatusLineNC   ctermfg=1     guifg=#666666 
  hi User1          ctermfg=white guifg=#666666
  hi User2          ctermfg=white guifg=#666666 gui=bold cterm=bold term=bold

  set statusline=
  set statusline+=%2*
  set statusline+=\ %t
  set statusline+=%1*
  set statusline+=%{&readonly?'\ [R]':''}
  set statusline+=%{&modified?'\ [+]':''}
  set statusline+=%=
  set statusline+=%1*
  set statusline+=%l:%c
  set statusline+=\ 
  set statusline+=%p%%
  set statusline+=\ 
  set statusline+=\%y
  set statusline+=\ 
  set statusline+=%{&fileformat}
  set statusline+=\ 
  set statusline+=%{&fileencoding?&fileencoding:&encoding}
endfun

fun! ReHighlight() abort
  hi clear VertSplit
  hi clear SignColumn
  hi clear FoldColumn
  hi clear nonText
  hi clear EndOfBuffer

  let l:normal_guibg = GetHighlightTerm("Normal", "guibg")
  let l:visual_guibg = GetHighlightTerm("Visual", "guibg")
  let l:foled_guifg = GetHighlightTerm("Folded", "guifg")

  " execute 'hi LspReferenceText cterm=bold gui=bold,undercurl ctermfg=1 guibg='l:visual_guibg
  " execute 'hi LspReferenceRead cterm=bold gui=bold,undercurl ctermfg=1 guibg='l:visual_guibg
  " execute 'hi LspReferenceWrite cterm=bold gui=bold,undercurl ctermfg=1 guibg='l:visual_guibg

  execute 'hi LineNr guibg='.l:normal_guibg
  execute 'hi SignColumn guibg='.l:normal_guibg
  execute 'hi nonText guibg='.l:normal_guibg
  execute 'hi EndOfBuffer guibg='.l:normal_guibg
  execute 'hi VertSplit guibg='.l:normal_guibg
  execute 'hi FoldColumn guifg='.foled_guifg
  execute 'hi Conceal guifg='.foled_guifg

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

  call Statusline()
endfun

fun! ToggleTerminalTheme(next) abort
  :silent call system('change-global-theme '.a:next)
endfun

fun! LightTheme() abort
  set background=light
  let base16colorspace=256
  colorscheme base16-mexico-light
endfun

fun! DarkTheme() abort
  let base16colorspace=256
  colorscheme base16-gruvbox-dark-medium
  set background=dark
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

autocmd ColorScheme * call ReHighlight()
