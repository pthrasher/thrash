" .vimrc
" vim: set foldlevel=0 foldmethod=marker spell expandtab ts=2 sw=2:
" Author: Philip Thrasher
" Source: http://github.com/pthrasher/thrash/??
" 
" Email or tweet with any questions. Glad to answer.

" Vundle Bootloader {{{
  set nocompatible               " be iMproved
  filetype off                   " required!

  set rtp+=~/.vim/bundle/vundle/
  call vundle#rc()

  " let Vundle manage Vundle
  " required! 
  Bundle 'gmarik/vundle'
"}}}

" Vundles {{{

  " Dependencies
  " Bundle 'kairichard/l9_vim_mirror'
  " Bundle 'MarcWeber/vim-addon-mw-utils'
  " Bundle 'tomtom/tlib_vim'
  Bundle 'mileszs/ack.vim'

  " Colors
  Bundle 'flazz/vim-colorschemes'

  " Generic editing
  Bundle 'tpope/vim-repeat'
  Bundle 'tpope/vim-fugitive'
  Bundle 'tpope/vim-abolish'
  Bundle 'tpope/vim-commentary'
  Bundle 'tpope/vim-endwise'
  Bundle 'tpope/vim-surround'

  Bundle 'scrooloose/syntastic'
  Bundle 'scrooloose/snipmate-snippets'

  Bundle 'kien/ctrlp.vim'
  Bundle 'shougo/neocomplcache'
  Bundle 'Lokaltog/vim-powerline'
  Bundle 'ervandew/supertab'
  Bundle 'Raimondi/delimitMate'
  Bundle 'AndrewRadev/linediff.vim'

  Bundle 'sjl/strftimedammit.vim'
  Bundle 'sjl/gundo.vim'

  " Cross compiled scripts
  Bundle 'kchmck/vim-coffee-script'
  Bundle 'tpope/vim-liquid'
  Bundle 'tpope/vim-markdown'
  Bundle 'groenewege/vim-less'

  " Javascript
  Bundle 'leshill/vim-json'
  Bundle 'pangloss/vim-javascript'
  " Bundle 'taxilian/vim-web-indent' 

  " Python
  Bundle 'vim-scripts/python.vim'
  Bundle 'klen/python-mode.git'
  Bundle 'michaeljsmith/vim-indent-object'

  " PHP
  Bundle 'spf13/PIV'

  " HTML
  Bundle 'zeekay/vim-autoclose'

  " CSS
  Bundle 'ChrisYip/Better-CSS-Syntax-for-Vim'

  
  filetype plugin indent on
"}}}

" Misc {{{
  set tabstop=2
  set shiftwidth=2
  set softtabstop=2
  set backspace=indent,eol,start
  set expandtab
  set autoindent
  set smartindent
  set smarttab
  set textwidth=80
  set formatoptions=qrn1
  set colorcolumn=+1

  set encoding=utf-8
  set modelines=0
  set ruler
  set backspace=indent,eol,start

  set showmode
  set showcmd
  set hidden
  set visualbell
  set cursorline
  set ttyfast
  set nonumber
  set relativenumber
  set laststatus=2
  set history=1000
  set undofile
  set undoreload=10000
  set list

  set listchars=tab:▸\ 
  augroup trailing
      au!
      au InsertEnter * :set listchars-=trail:⌴
      au InsertLeave * :set listchars+=trail:⌴
  augroup END

  set shell=/bin/bash
  set lazyredraw
  set matchtime=3
  set splitbelow
  set splitright
  set fillchars=diff:⣿,vert:│
  set ttimeout
  set notimeout
  set nottimeout
  set autowrite
  set shiftround
  set autoread
  set title
  set linebreak
  set dictionary=/usr/share/dict/words

  " Make Vim able to edit crontab files again.
  set backupskip=/tmp/*,/private/tmp/*" 

  " Save when losing focus
  au FocusLost * :wa

  " Resize splits when the window is resized
  au VimResized * :wincmd =

  
"}}}

" Wildmenu stuff {{{
  set wildmenu
  set wildmode=list:longest

  set wildignore+=.hg,.git,.svn                    " Version control
  set wildignore+=*.aux,*.out,*.toc                " LaTeX intermediate files
  set wildignore+=*.jpg,*.bmp,*.gif,*.png,*.jpeg   " binary images
  set wildignore+=*.o,*.obj,*.exe,*.dll,*.manifest " compiled object files
  set wildignore+=*.spl                            " compiled spelling word lists
  set wildignore+=*.sw?                            " Vim swap files
  set wildignore+=*.DS_Store                       " OSX bullshit

  set wildignore+=migrations                       " Django migrations
  set wildignore+=*.pyc                            " Python byte code
"}}}

" Line Return {{{

" Make sure Vim returns to the same line when you reopen a file.
" Thanks, Amit
  augroup line_return
    au!
    au BufReadPost *
      \ if line("'\"") > 0 && line("'\"") <= line("$") |
      \     execute 'normal! g`"zvzz' |
      \ endif
  augroup END

" }}}

" Backups {{{

  set undodir=~/.vim/undo//         " undo files
  set backupdir=~/.vim/tmp/backup// " backups
  set directory=~/.vim/tmp/swap//   " swap files
  set nobackup                      " no need for backups -- we have vcs
  set nowb
  set noswapfile                    " It's 2012, Vim.

" }}}

" Leader {{{

  let mapleader = ","
  let maplocalleader = "\\"

" }}}

" Color scheme {{{

  syntax on
  set background=dark
  colorscheme mustang

  " Highlight VCS conflict markers
  match ErrorMsg '^\(<\|=\|>\)\{7\}\([^=].\+\)\?$'

" }}}

" Searching and moving {{{

  " Use sane regexes.
  nnoremap / /\v
  vnoremap / /\v

  set ignorecase
  set smartcase
  set incsearch
  set showmatch
  set hlsearch
  set gdefault

  set scrolloff=3
  set sidescroll=1
  set sidescrolloff=10

  set virtualedit+=block

  noremap <leader><space> :noh<cr>:call clearmatches()<cr>

  runtime macros/matchit.vim
  map <tab> %

  " Made D behave
  nnoremap D d$

  " Keep search matches in the middle of the window and pulse the line when moving
  " to them.
  nnoremap n nzzzv
  nnoremap N Nzzzv

  " Don't move on *
  nnoremap * *<c-o>

  " Same when jumping around
  nnoremap g; g;zz
  nnoremap g, g,zz

  " Window resizing
  nnoremap <c-left> 5<c-w>>
  nnoremap <c-right> 5<c-w><

  " Easier to type, and I never use the default behavior.
  noremap H ^
  noremap L g_

  " Heresy
  inoremap <c-a> <esc>I
  inoremap <c-e> <esc>A

  " Open a Quickfix window for the last search.
  nnoremap <silent> <leader>/ :execute 'vimgrep /'.@/.'/g %'<CR>:copen<CR>

  " Ack for the last search.
  nnoremap <silent> <leader>? :execute "Ack! '" . substitute(substitute(substitute(@/, "\\\\<", "\\\\b", ""), "\\\\>", "\\\\b", ""), "\\\\v", "", "") . "'"<CR>

  " Fix linewise visual selection of various text objects
  nnoremap VV V
  nnoremap Vit vitVkoj
  nnoremap Vat vatV
  nnoremap Vab vabV
  nnoremap VaB vaBV

  " Error navigation {{{
  "
  "             Location List     QuickFix Window
  "            (e.g. Syntastic)     (e.g. Ack)
  "            ----------------------------------
  " Next      |     M-j               M-Down     |
  " Previous  |     M-k                M-Up      |
  "            ----------------------------------
  "
  nnoremap ∆ :lnext<cr>zvzz
  nnoremap ˚ :lprevious<cr>zvzz
  inoremap ∆ <esc>:lnext<cr>zvzz
  inoremap ˚ <esc>:lprevious<cr>zvzz
  nnoremap <m-Down> :cnext<cr>zvzz
  nnoremap <m-Up> :cprevious<cr>zvzz

" }}}

" Directional Keys {{{

  " It's 2011.
  noremap j gj
  noremap k gk

  " Easy buffer navigation
  noremap <C-h>  <C-w>h
  noremap <C-j>  <C-w>j
  noremap <C-k>  <C-w>k
  noremap <C-l>  <C-w>l
  noremap <leader>v <C-w>v

" }}}

" Folding {{{

  set foldlevelstart=0

  " Make the current location sane.
  nnoremap <c-cr> zvzt

  " Space to toggle folds.
  nnoremap <Space> za
  vnoremap <Space> za

  " Make zO recursively open whatever top level fold we're in, no matter where the
  " cursor happens to be.
  nnoremap zO zCzO

  " Use ,z to "focus" the current fold.
  nnoremap <leader>z zMzvzz

  function! MyFoldText() " {{{
      let line = getline(v:foldstart)

      let nucolwidth = &fdc + &number * &numberwidth
      let windowwidth = winwidth(0) - nucolwidth - 3
      let foldedlinecount = v:foldend - v:foldstart

      " expand tabs into spaces
      let onetab = strpart('          ', 0, &tabstop)
      let line = substitute(line, '\t', onetab, 'g')

      let line = strpart(line, 0, windowwidth - 2 -len(foldedlinecount))
      let fillcharcount = windowwidth - len(line) - len(foldedlinecount)
      return line . '…' . repeat(" ",fillcharcount) . foldedlinecount . '…' . ' '
  endfunction " }}}
  set foldtext=MyFoldText()

" }}}

" Powerline {{{

  let g:Powerline_symbols = 'fancy'

" }}}

" GUI {{{
  if has('gui_running')
      " Not sure if this one has all the right glyphs
      " set guifont=Ubuntu\ Regular\ for\ Powerline:h14
      set guifont=Menlo\ for\ Powerline:h12

      set transparency=2
      " Remove all the UI cruft
      set go-=T
      set go-=l
      set go-=L
      set go-=r
      set go-=R

      highlight SpellBad term=underline gui=undercurl guisp=Orange

      " Use a line-drawing char for pretty vertical splits.

      " Different cursors for different modes.
      "highlight iCursor guifg=white guibg=black
      "set guicursor=n-c:block-Cursor-blinkon0
      "set guicursor+=v:block-vCursor-blinkon0
      "set guicursor+=i-ci:ver20-iCursor

      if has("gui_macvim")
          " Full screen means FULL screen
          set fuoptions=maxvert,maxhorz

          " Use the normal HIG movements, except for M-Up/Down
          let macvim_skip_cmd_opt_movement = 1
          no   <D-Left>       <Home>
          no!  <D-Left>       <Home>
          no   <M-Left>       <C-Left>
          no!  <M-Left>       <C-Left>

          no   <D-Right>      <End>
          no!  <D-Right>      <End>
          no   <M-Right>      <C-Right>
          no!  <M-Right>      <C-Right>

          no   <D-Up>         <C-Home>
          ino  <D-Up>         <C-Home>
          imap <M-Up>         <C-o>{

          no   <D-Down>       <C-End>
          ino  <D-Down>       <C-End>
          imap <M-Down>       <C-o>}

          imap <M-BS>         <C-w>
          inoremap <D-BS>     <esc>my0c`y
      else
          " Non-MacVim GUI, like Gvim
      end
  else
      " Console Vim
  endif
"}}}


