"--------------------------------------------------------------------------
" 外观
"--------------------------------------------------------------------------

" 配色方案
if (has("termguicolors"))
 set termguicolors
endif

if has('gui_running')
  " set guifont=Monaco:h18
  set guifont=JetBrains_Mono:10.5
  " 禁止显示滚动条
  set guioptions-=l
  set guioptions-=L
  set guioptions-=r
  set guioptions-=R
  " 禁止显示菜单和工具条
  set guioptions-=m
  set guioptions-=T
  " 支持 256 色
  set t_Co=256
endif

" 禁止光标闪k烁
set gcr=a:block-blinkon0

" let base16colorspace=256
" colorscheme base16-default-dark
" colorscheme base16-tomorrow-night
colorscheme gruvbox
let g:gruvbox_contrast_dark="hard"

" 自定义配色
hi clear vertsplit
hi clear SignColumn
hi clear TabLine
hi clear TabLineSel
hi clear TabLineFill
hi clear FoldColumn

hi  Normal        ctermbg=NONE    guibg=#2d2d2d
hi  nonText       ctermbg=NONE    guibg=#2d2d2d
hi  LineNr        ctermfg=237     guibg=#2d2d2d
hi  Default       ctermfg=1
hi  SignColumn    ctermbg=235
hi  EndOfBuffer   ctermfg=237     ctermbg=235
hi  TabLine       ctermbg=235     ctermfg=245       guifg=#666666
hi  TabLineSel    ctermbg=235     ctermfg=245
hi  TabLineFill   ctermfg=0       ctermbg=235
hi  Pmenu         ctermfg=223     ctermbg=237       guifg=#ebdbb2   guibg=#414344
hi  PmenuSel      cterm=bold      ctermfg=235       ctermbg=109     gui=bold    guifg=#504945     guibg=#f1f1f1
hi  PmenuSbar     ctermbg=235     guibg=#212121
hi  PmenuThumb    ctermbg=2       guibg=#2a2a2a
hi  FoldColumn    ctermfg=245     ctermbg=237       guifg=#928374   guibg=#3c3836
hi  Folded        ctermfg=245     ctermbg=237       guifg=#928374   guibg=#3c3836
hi  vertsplit     ctermfg=245     ctermbg=NONE      guifg=#292929   guibg=NONE
hi  ColorColumn   ctermbg=237     guibg=#2c2c2c

hi GitGutterAdd ctermbg=235 ctermfg=245
hi GitGutterChange ctermbg=235 ctermfg=245
hi GitGutterDelete ctermbg=235 ctermfg=245
hi GitGutterChangeDelete ctermbg=235 ctermfg=245

" ALE custom color
hi  clear ALEErrorSign
hi  clear ALEWarningSign
hi  ALEErrorSign    ctermbg=235 
hi  ALEWarningSign  ctermbg=235
