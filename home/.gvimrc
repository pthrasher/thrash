" .gvimrc Author: Philip Thrasher Source:
" https://github.com/pthrasher/thrash/blob/master/home/.vimrc
"
" Color scheme config
set guifont=Source\ Code\ Pro\ for\ Powerline:h13
set bg=light
call togglebg#map("<F6>")
let g:solarized_hitrail = 1 " hilight trailing whitespace

colorscheme solarized

set transparency=0 " don't want it. want to get shit done instead.
" Remove all the UI cruft
set go-=T
set go-=l
set go-=L
set go-=r
set go-=R

" hilight row in current buffer only
augroup CursorLine
  au!
  au VimEnter,WinEnter,BufWinEnter * setlocal cursorline cc=80
  au WinLeave * setlocal nocursorline cc=0
augroup END


highlight SpellBad term=underline gui=undercurl

" Full screen means FULL screen
set fuoptions=maxvert,maxhorz

" Window resizing.
nnoremap <D-Left> :set columns-=15<cr>
nnoremap <D-Right> :set columns+=15<cr>

nnoremap <D-Up> :set lines-=10<cr>
nnoremap <D-Down> :set lines+=10<cr>

" Last Call {{{
    " Stuff here doesn't work properly unless called last.

    " Some stupid god damn plugin keeps overriding this. I'm going to shit
    " a fucking pile of bricks on that plugin once I find out who it is.
    set relativenumber
" }}}
