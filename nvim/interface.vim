"--------------------------------------------------------------------------
" 外观
"--------------------------------------------------------------------------

" 配色方案
if (has("termguicolors"))
 set termguicolors
endif

if has('gui_running')
  set guifont=Monaco:h18
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

" colorscheme 
" colorscheme duoduo
" colorscheme one
" colorscheme dracula
colorscheme gruvbox
let g:gruvbox_contrast_dark="hard"
" 禁止光标闪k烁
set gcr=a:block-blinkon0


" 自定义配色
highlight Normal ctermbg=NONE guibg=#2d2d2d
highlight nonText ctermbg=NONE guibg=#2d2d2d
hi LineNr ctermfg=237
hi Default ctermfg=1
hi clear vertsplit
hi clear StatusLine
hi clear StatusLineNC
hi clear SignColumn
hi clear TabLine
hi clear TabLineSel
hi clear TabLineFill
hi StatusLine ctermfg=0 guifg=#666666
hi StatusLineNC ctermfg=1 guifg=#666666
hi SignColumn ctermbg=235
hi GitGutterAdd ctermbg=235 ctermfg=245
hi GitGutterChange ctermbg=235 ctermfg=245
hi GitGutterDelete ctermbg=235 ctermfg=245
hi GitGutterChangeDelete ctermbg=235 ctermfg=245
hi EndOfBuffer ctermfg=237 ctermbg=235
hi TabLine ctermbg=235  ctermfg=245 guifg=#666666
hi TabLineSel ctermbg=235 ctermfg=245
hi TabLineFill ctermfg=0 ctermbg=235
set fillchars=vert:\ ,stl:\ ,stlnc:\ 

hi Pmenu      ctermfg=223 ctermbg=235 guifg=#ebdbb2 guibg=#3d4448
hi PmenuSel   cterm=bold ctermfg=235 ctermbg=109 gui=bold guifg=#504945 guibg=#f1f1f1
hi PmenuSbar  ctermbg=235 guibg=#2a2a2a
hi PmenuThumb ctermbg=2 guibg=#2a2a2a

" 自定义颜色 User1 使用时：%1*
hi User1 ctermfg=white guifg=#666666

" 自定义statusline，使用时设置 laststatus=2
set statusline=
set statusline+=%1*
set statusline+=\ %f
set statusline+=\ %m
set statusline+=\ %r
set statusline+=\ %h
set statusline+=\ %w
set statusline+=\ %q
set statusline+=%=
set statusline+=%1*
set statusline+=\ %y
set statusline+=\ 
set statusline+=\ %{&fileformat}
set statusline+=\ 
set statusline+=\ %{&fileencoding?&fileencoding:&encoding}
set statusline+=\ 
set statusline+=\ %p%%
set statusline+=\ 
set statusline+=\ %l:%c
set statusline+=\ 



set laststatus=2
set noshowcmd




" ALE custom color
highlight clear ALEErrorSign
highlight clear ALEWarningSign
highlight ALEErrorSign ctermbg=235
highlight ALEWarningSign ctermbg=235
