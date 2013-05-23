" .gvimrc Author: Philip Thrasher Source:
" https://github.com/pthrasher/thrash/blob/master/home/.vimrc
"
" I wish I didn't need this fucking file, but some settings get overridden if
" they're not in here.
set guifont=Source\ Code\ Pro\ for\ Powerline:h13
set bg=dark
colorscheme toychest

set transparency=0
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

" Last Call {{{
    " Stuff here doesn't work properly unless called last.

    " Some stupid god damn plugin keeps overriding this. I'm going to shit
    " a fucking pile of bricks on that plugin once I find out who it is.
    set relativenumber
" }}}
