source ~/.config/nvim/base.vim
source ~/.config/nvim/interface.vim

lua require 'plugins'
lua require 'actions'
lua require 'keymapping'

let g:loadfts = {}
func! AutoFileType() abort
  let l:ft = &filetype
  if !has_key(g:loadfts, l:ft)
    if !empty(glob($HOME."/.config/nvim/lua/filetypes/".l:ft.".lua"))
      let l:cmd = "require 'filetypes.".l:ft."'"
      call luaeval(l:cmd)
    endif
    let g:loadfts[l:ft] = 1
  endif
endfun

autocmd BufEnter * call AutoFileType()
