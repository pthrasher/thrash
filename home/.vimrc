" vim: set foldmarker={{{,}}} foldlevel=0 foldmethod=marker spell:
"            __  .__                        .__     
"    _______/  |_|  |______________    _____|  |__  
"    \____ \   __\  |  \_  __ \__  \  /  ___/  |  \ 
"    |  |_> >  | |   Y  \  | \// __ \_\___ \|   Y  \
"    |   __/|__| |___|  /__|  (____  /____  >___|  /
"    |__|             \/           \/     \/     \/ 
"
"    https://github.com/pthrasher/thrash/blob/master/home/.vimrc
"
"    I'm more than happy to answer questions about this config. I just recently
"    removed a ton of stuff, trying to make it smaller / more readable. Take
"    whatever you want, and hit me up if you need to know anything / just want
"    to say thanks. :-)
"
"    Email:   philipthrasher@gmail.com
"    Twitter: @philipthrasher
"    Blog:    http://philipthrasher.com/

" Bundles (Plugins) {{{

    " Setup {{{

        set nocompatible
        filetype off

        set rtp+=~/.vim/bundle/vundle/
        call vundle#rc()

    " }}}

    " Shared libs {{{

        Bundle 'gmarik/vundle'
        Bundle 'L9'

    " }}}

    " Colorschemes {{{

        Bundle 'pthrasher/daylerees-vim-colours'
        Bundle 'altercation/vim-colors-solarized'
        " Bundle 'flazz/vim-colorschemes'
        " Bundle 'pthrasher/brackets2-vim'

    " }}}

    " General {{{

        Bundle 'tpope/vim-repeat'
        Bundle 'tpope/vim-surround'
        Bundle 'tpope/vim-git'
        Bundle 'tpope/vim-fugitive'

        Bundle 'Lokaltog/vim-powerline'
        Bundle 'godlygeek/tabular'
        Bundle 'mileszs/ack.vim'

        Bundle 'scratch.vim'
        Bundle 'kien/ctrlp.vim'
        Bundle 'sjl/gundo.vim'
        Bundle 'YankRing.vim'


    " }}}

    " Programming {{{

        " Bundle 'basilgor/vim-autotags'
        Bundle 'davidhalter/jedi-vim'
        Bundle 'undx/vim-gocode'
        Bundle 'Valloric/YouCompleteMe'
        Bundle 'Raimondi/delimitMate'
        Bundle 'scrooloose/syntastic'
        Bundle 'sjl/strftimedammit.vim'
        Bundle 'tpope/vim-commentary'
        " Bundle 'klen/python-mode'

        Bundle 'guileen/vim-node'

        " On trial: (could be removed at any moment if they do not bring me
        " exquisite pleasure)
        Bundle 'tpope/vim-endwise'
        Bundle 'tpope/vim-eunuch'
        Bundle 'switch.vim'


    " }}}

    " Extra Syntaxes {{{
        Bundle 'digitaltoad/vim-jade'

        Bundle 'leshill/vim-json'
        Bundle 'pangloss/vim-javascript'
        Bundle 'indenthtml.vim'

        Bundle 'tpope/vim-markdown'
        Bundle 'mattn/zencoding-vim'

        Bundle 'fsouza/go.vim'

        Bundle 'kchmck/vim-coffee-script'

        Bundle 'skammer/vim-css-color'
        Bundle 'hail2u/vim-css3-syntax'
        Bundle 'groenewege/vim-less'

        Bundle 'spf13/PIV'

    " }}}

" }}}
" General Config {{{

    filetype plugin indent on
    syntax on

" }}}
" Settings {{{

    " We don't care about acting like vi
    set nocompatible " this is already set above -- only here for reference

    " Default tabstop / spacing
    set tabstop=4
    set shiftwidth=4
    set softtabstop=4

    set expandtab " use spaces instead of tabs.
    set smarttab " let's tab key insert 'tab stops', and bksp deletes tabs.
    set shiftround " tab / shifting moves to closest tabstop.
    set autoindent " Match indents on new lines.
    set smartindent " Intellegently dedent / indent new lines based on rules.

    set hidden " keep buffers around when not in view.
    set visualbell " Don't beep, do visual bell, which is disabled in my gvimrc
    set laststatus=2 " always show a status line.
    set history=1000 " cmd-mode history, and search history
    set nobackup " We have vcs, we don't need backups.
    set nowritebackup " We have vcs, we don't need backups.
    set noswapfile " They're just annoying. Who likes them?

    " vim 7.3+ settings
    set relativenumber
    set undofile " keep a persistent undo file so we can undo even after a reboot
    set undodir=~/.vimundo//
    set undoreload=10000

    set list
    set listchars=tab:▸\ ,eol:¬ " show fancy characters for tabstops, and \n's

    set showmatch " show us maching brackets, etc.
    set matchtime=3 "how long to show the match

    " Prefer vsplits to hsplits
    set splitbelow
    set splitright

    set autowrite
    set autoread " when a file has changed on disk, just load it. Don't ask.

    " Make search more sane
    set ignorecase " case insensitive search
    set smartcase " If there are uppercase letters, become case-sensitive.
    set incsearch " live incremental searching
    set showmatch " live match highlighting
    set hlsearch " highlight matches
    set gdefault " use the `g` flag by default.

    " allow the cursor to go anywhere in visual block mode.
    set virtualedit+=block

    set wildmenu " cmd line completion a-la zsh
    set wildmode=list:longest " matches mimic that of bash or zsh
    set wildignore=node_modules                      " node_modules dir
    set wildignore+=.ropeproject                     " py rope cache dir
    set wildignore+=.hg,.git,.svn                    " Version control
    set wildignore+=*.aux,*.out,*.toc                " LaTeX intermediate files
    set wildignore+=*.jpg,*.bmp,*.gif,*.png,*.jpeg   " binary images
    set wildignore+=*.o,*.obj,*.exe,*.dll,*.manifest " compiled object files
    set wildignore+=*.spl                            " compiled spelling word lists
    set wildignore+=*.sw?                            " Vim swap files
    set wildignore+=*.DS_Store                       " OSX bullshit
    set wildignore+=migrations                       " Django migrations
    set wildignore+=*.pyc                            " Python byte code

    set shell=/bin/bash

    if has("gui_running")
        " I might put something in here at some point
    else
        set background="dark"
        set t_Co=256
        colorscheme solarized
    endif

" }}}
" Generic au commands {{{

    " save on focus lost
    au FocusLost * :silent! wa

    " Resize splits when the window is resized
    au VimResized * :wincmd =

    " always go to top of commit messages
    autocmd BufReadPost COMMIT_EDITMSG exec "normal! gg"

    " Make sure Vim returns to the same line when you reopen a file.
    augroup line_return
        au!
        au BufReadPost *
        \ if line("'\"") > 0 && line("'\"") <= line("$") |
        \     execute 'normal! g`"zvzz' |
        \ endif
    augroup END
    
" }}}
" Keybindings {{{


    let mapleader = ","
    let maplocalleader = "\\"

    " Paste in insert mode.
    inoremap <C-r> <C-r>"

    " for python, auto-pep8
    nnoremap <leader>8 :PyLintAuto<cr>

    " Less chording
    nnoremap ; :
    vnoremap ; :
    inoremap jf <esc>

    " Mapping for the switch plugin.
    nnoremap - :Switch<cr>

    " Key bindings for the align plugin
    vnoremap <leader>a= :Tab /=<cr>
    nnoremap <leader>a= :Tab /=<cr>
    vnoremap <leader>a: :Tab /:\zs<cr>
    nnoremap <leader>a: :Tab /:\zs<cr>
    vnoremap <leader>a/ :Tab /\/\/<cr>
    nnoremap <leader>a/ :Tab /\/\/<cr>

    " Substitute shortcut
    nnoremap <leader>s :%s//<left>

    " Emacs bindings in command line mode
    cnoremap <c-a> <home>
    cnoremap <c-e> <end>

    " Formatting, TextMate-style (using par)
    set formatprg=par\ -w79
    nnoremap Q gqip
    vnoremap Q gq

    " Easier linewise reselection
    nnoremap <leader>V V`]
    
    " Acking current word under cursor
    map <Leader>f :execute "Ack " . expand("<cword>") <Bar> cw<CR>

    " create new vsplit, and switch to it.
    noremap <leader>v <C-w>v
    
    " bindings for easy split nav
    nnoremap <C-h> <C-w>h
    nnoremap <C-j> <C-w>j
    nnoremap <C-k> <C-w>k
    nnoremap <C-l> <C-w>l

    " Opens an edit command with the path of the currently edited file filled in
    " Normal mode: <Leader>e
    map <Leader>e :e <C-R>=expand("%:p:h") . "/" <CR>

    " Sudo to write
    cnoremap w!! w !sudo tee % >/dev/null
    
    " Use sane regex's when searching
    nnoremap / /\v
    vnoremap / /\v

    " Clear match highlighting
    noremap <leader><space> :noh<cr>:call clearmatches()<cr>

    " Quick buffer switching - like cmd-tab'ing
    nnoremap <leader><leader> <c-^>

    " Keep search matches in the middle of the window and pulse the line when moving
    " to them.
    nnoremap n nzzzv
    nnoremap N Nzzzv

    " Same when jumping around
    nnoremap g; g;zz
    nnoremap g, g,zz

    " Don't move on *
    nnoremap * *<c-o>

    " Easier to type, and I never use the default behavior.
    noremap H ^
    noremap L g_

    " Ack for the last search.
    nnoremap <silent> <leader>? :execute "Ack! '" . substitute(substitute(substitute(@/, "\\\\<", "\\\\b", ""), "\\\\>", "\\\\b", ""), "\\\\v", "", "") . "'"<CR>

    " Visual line nav, not real line nav
    nnoremap j gj
    nnoremap k gk

    " conqueterm
    nnoremap <silent><leader>S :ConqueTermVSplit bash<cr>

    " Ripped from unimpaired.vim -- didn't want the whole plugin, just these
    " bindings:

    function! s:BlankUp(count) abort
        put!=repeat(nr2char(10), a:count)
        ']+1
        silent! call repeat#set("\<Plug>unimpairedBlankUp", a:count)
    endfunction

    function! s:BlankDown(count) abort
        put =repeat(nr2char(10), a:count)
        '[-1
        silent! call repeat#set("\<Plug>unimpairedBlankDown", a:count)
    endfunction

    nnoremap <silent> <Plug>unimpairedBlankUp   :<C-U>call <SID>BlankUp(v:count1)<CR>
    nnoremap <silent> <Plug>unimpairedBlankDown :<C-U>call <SID>BlankDown(v:count1)<CR>

    nmap [<Space> <Plug>unimpairedBlankUp
    nmap ]<Space> <Plug>unimpairedBlankDown

    function! s:Move(cmd, count, map) abort
        normal! m`
        exe 'move'.a:cmd.a:count
        norm! ``
        silent! call repeat#set("\<Plug>unimpairedMove".a:map, a:count)
    endfunction

    nnoremap <silent> <Plug>unimpairedMoveUp   :<C-U>call <SID>Move('--',v:count1,'Up')<CR>
    nnoremap <silent> <Plug>unimpairedMoveDown :<C-U>call <SID>Move('+',v:count1,'Down')<CR>
    xnoremap <silent> <Plug>unimpairedMoveUp   :<C-U>exe 'normal! m`'<Bar>exe '''<,''>move--'.v:count1<CR>``
    xnoremap <silent> <Plug>unimpairedMoveDown :<C-U>exe 'normal! m`'<Bar>exe '''<,''>move''>+'.v:count1<CR>``

    nmap [e <Plug>unimpairedMoveUp
    nmap ]e <Plug>unimpairedMoveDown
    xmap [e <Plug>unimpairedMoveUp
    xmap ]e <Plug>unimpairedMoveDown


    " I don't really use folding except in this file, but I like these
    " bindings.

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

" }}}
" Plugin Settings {{{

    " ConqueTerm {{{
        let g:ConqueTerm_StartMessages = 0
    " }}}

    " YankRing.vim {{{

        function! YRRunAfterMaps()                                                                                                      
            " From Steve Losh, Preserve the yank post selection/put.    
            vnoremap p :<c-u>YRPaste 'p', 'v'<cr>gv:YRYankRange 'v'<cr> 
        endfunction 

    " }}}

    " ack.vim {{{

        " the_silver_surfer, no more ack!
        let g:ackprg = 'ag --nogroup --nocolor --column'

    " }}}

    " indent-html {{{

        let g:html_indent_inctags = "html,body,head,tbody"
        let g:html_indent_script1 = "inc"
        let g:html_indent_style1 = "inc"

    " }}}

    " Powerline {{{

        let g:Powerline_symbols = 'fancy'

    " }}}

    " Zen Coding {{{

        let g:user_zen_leader_key = '<c-e>'

        " 4 space soft tabs
        let g:user_zen_settings = {'indentation' : '    '}
        let g:use_zen_complete_tag = 1

    " }}}

    " Commentary {{{

        nnoremap <leader>c :CommentaryLine<cr>
        vnoremap <leader>c :Commentary<cr>

    " }}}

    " Syntastic {{{

        let g:syntastic_enable_signs = 1
        let g:syntastic_mode_map = { 'mode': 'active',
                                   \ 'active_filetypes': [],
                                   \ 'passive_filetypes': ['python', 'python.django', 'html' ] }
        let g:syntastic_stl_format = '[%E{%e Errors}%B{, }%W{%w Warnings}]'
        let g:syntastic_jsl_conf = '$HOME/.vim/jsl.conf'

    " }}}

    " CtrlP {{{

        let g:ctrlp_map = '<c-t>'
        let g:ctrlp_max_height = 30

    " }}}

" }}}
" Syntax Settings {{{

    " C++ {{{
        augroup ft_cpp
            au!
            " Fucking hipsters 4 spaces is hella more readable, but whatev.
            au FileType cpp set softtabstop=2 tabstop=2 shiftwidth=2 textwidth=79
        augroup END
    " }}}

    " Django {{{

        augroup ft_django
            au!

            au BufNewFile,BufRead urls.py           setlocal nowrap
            au BufNewFile,BufRead urls.py           normal! zR
            au BufNewFile,BufRead dashboard.py      normal! zR
            au BufNewFile,BufRead local_settings.py normal! zR

            au BufNewFile,BufRead admin.py     setlocal filetype=python.django
            au BufNewFile,BufRead urls.py      setlocal filetype=python.django
            au BufNewFile,BufRead models.py    setlocal filetype=python.django
            au BufNewFile,BufRead views.py     setlocal filetype=python.django
            au BufNewFile,BufRead settings.py  setlocal filetype=python.django
            au BufNewFile,BufRead settings.py  setlocal foldmethod=marker
            au BufNewFile,BufRead forms.py     setlocal filetype=python.django
            au BufNewFile,BufRead common_settings.py  setlocal filetype=python.django
            au BufNewFile,BufRead common_settings.py  setlocal foldmethod=marker
        augroup END

    " }}}

    " HTML and HTMLDjango {{{

        augroup ft_html
            au!

            " au FileType html,jinja,htmldjango set softtabstop=2 tabstop=2 shiftwidth=2 textwidth=79
            au BufNewFile,BufRead *.html setlocal filetype=htmldjango

            " Use <localleader>f to fold the current tag.
            au FileType html,jinja,htmldjango nnoremap <buffer> <localleader>f Vatzf

            " Use <localleader>t to fold the current templatetag.
            au FileType html,jinja,htmldjango nmap <buffer> <localleader>t viikojozf

            " Use Shift-Return to turn this:
            "     <tag>|</tag>
            "
            " into this:
            "     <tag>
            "         |
            "     </tag>
            au FileType html,jinja,htmldjango nnoremap <buffer> <s-cr> vit<esc>a<cr><esc>vito<esc>i<cr><esc>

            " Django tags
            au FileType jinja,htmldjango inoremap <buffer> <c-t> {%<space><space>%}<left><left><left>

            " Django variables
            au FileType jinja,htmldjango inoremap <buffer> <c-f> {{<space><space>}}<left><left><left>
        augroup END

    " }}}
    
    " Javascript {{{

        augroup ft_json

            au BufNewFile,BufRead *.json setlocal filetype=json

        augroup END

        augroup ft_javascript
            au!

            au FileType javascript setlocal foldmarker={,}

            " Make {<cr> insert a pair of brackets in such a way that the cursor is correctly
            " positioned inside of them AND the following code doesn't get unfolded.
            " au Filetype javascript inoremap <buffer> {<cr> {}<left><cr><space><space><space><space>.<cr><esc>kA<bs>
            au FileType javascript set softtabstop=4 tabstop=4 shiftwidth=4
            au FileType javascript set dictionary+=$HOME/.vim/dict/node.dict
        augroup END

    " }}}

    " Plain Text {{{

        augroup ft_noft
            au!

            au Filetype noft call s:setupText()

        augroup END

        function s:setupWrapping()
            set wrap
            set wm=2
            set textwidth=79
        endfunction

        function s:setupText()
            setlocal spell
            " setlocal dictionary=/usr/share/dict/words
            let b:loaded_delimitMate = 1 
            call s:setupWrapping()
        endfunction

        au BufRead,BufNewFile *.txt call s:setupText()

    " }}}

    " Markdown {{{

        function s:setupMarkup()
            call s:setupText()
            nnoremap <buffer> <Leader>p :Mm <CR>

            " Use <localleader>1/2/3 to add headings.
            nnoremap <buffer> <localleader>1 yypVr=
            nnoremap <buffer> <localleader>2 yypVr-
            nnoremap <buffer> <localleader>3 I### <ESC>
        endfunction

        augroup ft_markdown
            au!

            au BufNewFile,BufRead *.{md,markdown,mdown,mkd,mkdn} setlocal filetype=markdown
            au BufRead,BufNewFile *.{md,markdown,mdown,mkd,mkdn} call s:setupMarkup()
        augroup END

    " }}}

    " Python {{{

        augroup ft_python
            au!

            au FileType python set softtabstop=4 tabstop=4 shiftwidth=4 textwidth=79
            au FileType python let b:delimitMate_nesting_quotes = ['"', "'"]
        augroup END


    " }}}

    " PHP {{{

        augroup ft_php
            au!

            au FileType php set softtabstop=4 tabstop=4 shiftwidth=4 textwidth=79
        augroup END

    " }}}

    " ReStructuredText {{{

        augroup ft_rest
            au!

            au Filetype rst nnoremap <buffer> <localleader>1 yypVr=
            au Filetype rst nnoremap <buffer> <localleader>2 yypVr-
            au Filetype rst nnoremap <buffer> <localleader>3 yypVr~
            au Filetype rst nnoremap <buffer> <localleader>4 yypVr`
        augroup END

    " }}}

    " Vim {{{

        augroup ft_vim
            au!

            au FileType help setlocal textwidth=78
            let b:delimitMate_autoclose = 0 
            au BufWinEnter *.txt if &ft == 'help' | wincmd L | endif
        augroup END

    " }}}

    " CoffeeScript {{{

        augroup ft_coffee
            au!

            au Filetype coffee let b:delimitMate_nesting_quotes = ['"', "'", '`']
            au FileType coffee set softtabstop=4 tabstop=4 shiftwidth=4 textwidth=79
            au FileType coffee set dictionary+=$HOME/.vim/dict/node.dict
        augroup END

    " }}}

    " Ruby {{{
        " Okay you fuckin' hipsters, I give in... 2 spaces for ruby. Happy?
        au FileType ruby set softtabstop=2 tabstop=2 shiftwidth=2 textwidth=79
    " }}}

" }}}
