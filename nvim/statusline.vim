" highlights
hi clear StatusLine
hi clear StatusLineNC
hi StatusLine     ctermfg=0     guifg=#666666
hi StatusLineNC   ctermfg=1     guifg=#666666 
hi User1          ctermfg=white guifg=#666666
hi User2          ctermfg=white guifg=#666666 gui=bold cterm=bold term=bold

fun! HumanSize(bytes) abort
  let l:bytes = a:bytes
  let l:sizes = ['B', 'KB', 'MB', 'GB']
  let l:i = 0
  while l:bytes >= 1024
     let l:bytes = l:bytes / 1024.0
    let l:i += 1
  endwhile
  return printf('%.1f%s', l:bytes, l:sizes[l:i])
endfun

func! FullStatusline() abort
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

fun! ResizeStatusline() abort
  let l:width = winwidth("%")
  if l:width < 38
    set statusline=%2*\ %t 
  elseif l:width < 70
    set statusline=
    set statusline+=%2*
    set statusline+=\ %t
    set statusline+=%=
    set statusline+=%1*
    set statusline+=%l:%c
  else
    call FullStatusline()
  endif
endfun

call FullStatusline()
