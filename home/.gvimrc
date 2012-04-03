" .gvimrc Author: Philip Thrasher Source:
" https://github.com/pthrasher/thrash/blob/master/home/.vimrc
"
" I wish I didn't need this fucking file, but some settings get overridden if
" they're not in here.

" Not sure if this one has all the right glyphs
set guifont=Menlo\ for\ Powerline:h12

set transparency=3
" Remove all the UI cruft
set go-=T
set go-=l
set go-=L
set go-=r
set go-=R

highlight SpellBad term=underline gui=undercurl

" Full screen means FULL screen
set fuoptions=maxvert,maxhorz

" Window resizing.
nnoremap <D-Left> :set columns-=15<cr>
nnoremap <D-Right> :set columns+=15<cr>

nnoremap <D-Up> :set lines-=10<cr>
nnoremap <D-Down> :set lines+=10<cr>
