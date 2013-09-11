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
"    Blog:    http://pthra.sh/



" Bundles (Plugins) {{{

    " Setup {{{

        set nocompatible
        filetype off

        set rtp+=~/.vim/bundle/vundle/
        call vundle#rc()

        " Let Vundle manage Vundle.
        Bundle 'gmarik/vundle'

    " }}}

    " Shared libs {{{

        Bundle 'L9'
        Bundle 'rizzatti/funcoo.vim'

    " }}}

    " Colorschemes {{{

        Bundle 'pthrasher/vim-colors-solarized'
        " Bundle 'pthrasher/Toy-Chest-Theme'

    " }}}

    " General {{{

        Bundle 'rizzatti/dash.vim'
        Bundle 'wakatime/vim-wakatime'
        Bundle 'MarcWeber/vim-addon-local-vimrc'
        Bundle 'tpope/vim-repeat'
        Bundle 'tpope/vim-surround'
        Bundle 'tpope/vim-git'
        Bundle 'tpope/vim-fugitive'

        Bundle 'Lokaltog/powerline', {'rtp': 'powerline/bindings/vim/'}
        Bundle 'godlygeek/tabular'
        Bundle 'mileszs/ack.vim'

        Bundle 'scratch.vim'
        Bundle 'kien/ctrlp.vim'
        Bundle 'sjl/gundo.vim'
        Bundle 'YankRing.vim'
        Bundle 'terryma/vim-multiple-cursors'


    " }}}

    " Programming {{{

        Bundle 'michaeljsmith/vim-indent-object'
        Bundle 'davidhalter/jedi-vim'
        Bundle 'django.vim'
        Bundle 'undx/vim-gocode'
        Bundle 'Raimondi/delimitMate'
        Bundle 'Valloric/YouCompleteMe'
        Bundle 'scrooloose/syntastic'
        Bundle 'sjl/strftimedammit.vim'
        Bundle 'tpope/vim-commentary'
        Bundle 'guileen/vim-node'
        Bundle 'tpope/vim-endwise'
        Bundle 'tpope/vim-eunuch'
        Bundle 'switch.vim'
        Bundle 'closetag.vim'


    " }}}

    " Extra Syntaxes {{{

        Bundle 'aliva/vim-fish'
        Bundle 'digitaltoad/vim-jade'
        Bundle 'wavded/vim-stylus'

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

    " Add extra TODO style syntax
    syn match myBasicTodo contained "\<\(TODO\|FIXME\|XXX\|NOTE\):"
    syn match myExtraTodo contained "\<\(PERF\|DOCTHIS\|ONSCOPE\):"
    hi def link myBasicTodo Todo
    hi def link myExtraTodo Todo

" }}}
" Settings {{{

    " Don't show the preview window when doing completions and shit.
    set completeopt-=preview

    set fillchars=
    set fillchars+=vert:┃
    set fillchars+=diff:⣿
    set fillchars+=fold:━
    set fillchars+=stlnc:\ 
    set fillchars+=stl:\ 

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

    " This is good to have on for some comments, but bad for everything else...
    " So, I just turn it off altogether. All of my syntax files have good
    " indentation support built-in. This is not *needed*.
    set nosmartindent

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
    set undodir=~/.vim/tmp/undo/
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
    set wildignore=*/node_modules/*
    set wildignore+=*/npm_cache/*
    set wildignore+=*/.ropeproject/*
    set wildignore+=.hg,.git,.svn                    " Version control
    set wildignore+=*.aux,*.out,*.toc                " LaTeX intermediate files
    set wildignore+=*.jpg,*.bmp,*.gif,*.png,*.jpeg   " binary images
    set wildignore+=*.o,*.obj,*.exe,*.dll,*.manifest " compiled object files
    set wildignore+=*.spl                            " compiled spelling word lists
    set wildignore+=*.sw?                            " Vim swap files
    set wildignore+=*.DS_Store                       " OSX bullshit
    set wildignore+=*/migrations/*                   " Django migrations
    set wildignore+=*.pyc                            " Python byte code

    " v2 project specific settings

    set shell=/bin/bash

    if has("gui_running")
        " I might put something in here at some point
    else
        set background="light"
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

    " Dash.vim mappings
    nmap <silent> <leader>d <Plug>DashSearch
    vmap <silent> <leader>d <Plug>DashSearch

    " Paste in insert mode.
    inoremap <C-r> <C-r>"

    " NO FUCKING SHIFT-K DOCS!
    nnoremap K <NOP>
    vnoremap K <NOP>

    " 'Uppercase word' mapping.
    "
    " This mapping allows you to press <c-u> in insert mode to convert the current
    " word to uppercase.  It's handy when you're writing names of constants and
    " don't want to use Capslock.
    "
    " To use it you type the name of the constant in lowercase.  While your
    " cursor is at the end of the word, press <c-u> to uppercase it, and then
    " continue happily on your way:
    "
    "                            cursor
    "                            v
    "     max_connections_allowed|
    "     <c-u>
    "     MAX_CONNECTIONS_ALLOWED|
    "                            ^
    "                            cursor
    "
    " It works by exiting out of insert mode, recording the current cursor location
    " in the z mark, using gUiw to uppercase inside the current word, moving back to
    " the z mark, and entering insert mode again.
    "
    " Note that this will overwrite the contents of the z mark.  I never use it, but
    " if you do you'll probably want to use another mark.
    inoremap <D-u> <esc>mzgUiw`za

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

    " dash.vim {{{

        let g:dash_map = {
        \ 'python'       : 'py',
        \ 'pythondjango' : 'py',
        \ 'javascript'   : 'js',
        \ 'coffeescript' : 'js'
        \ } 



    " }}}
    " vim-addon-local-vimrc {{{

        let g:local_vimrc = {'names':['.local-vimrc'],'hash_fun':'LVRHashOfFile'}

    " }}}

    " YouCompleteMe {{{

        let g:ycm_add_preview_to_completeopt = 0

    " }}}

    " Jedi {{{

        " yim already does this for me.
        let g:jedi#popup_on_dot = 0

        " don't add preview to completeopt
        let g:jedi#auto_vim_configuration = 0

        " who uses tabs? they're silly.
        let g:jedi#use_tabs_not_buffers = 0

    " }}}

    " Highlight Word {{{

        " This mini-plugin provides a few mappings for highlighting words temporarily.
        "
        " Sometimes you're looking at a hairy piece of code and would like a certain
        " word or two to stand out temporarily.  You can search for it, but that only
        " gives you one color of highlighting.  Now you can use <leader>N where N is
        " a number from 1-6 to highlight the current word in a specific color.

        function! HiInterestingWord(n)
            " Save our location.
            normal! mz

            " Yank the current word into the z register.
            normal! "zyiw

            " Calculate an arbitrary match ID.  Hopefully nothing else is using it.
            let mid = 86750 + a:n

            " Clear existing matches, but don't worry if they don't exist.
            silent! call matchdelete(mid)

            " Construct a literal pattern that has to match at boundaries.
            let pat = '\V\<' . escape(@z, '\') . '\>'

            " Actually match the words.
            call matchadd("InterestingWord" . a:n, pat, 1, mid)

            " Move back to our original location.
            normal! `z
        endfunction

        " Mappings {{{

            nnoremap <silent> <leader>1 :call HiInterestingWord(1)<cr>
            nnoremap <silent> <leader>2 :call HiInterestingWord(2)<cr>
            nnoremap <silent> <leader>3 :call HiInterestingWord(3)<cr>
            nnoremap <silent> <leader>4 :call HiInterestingWord(4)<cr>
            nnoremap <silent> <leader>5 :call HiInterestingWord(5)<cr>
            nnoremap <silent> <leader>6 :call HiInterestingWord(6)<cr>

        " }}}

        " Default Highlights {{{

            hi def InterestingWord1 guifg=#000000 ctermfg=16 guibg=#ffa724 ctermbg=214
            hi def InterestingWord2 guifg=#000000 ctermfg=16 guibg=#aeee00 ctermbg=154
            hi def InterestingWord3 guifg=#000000 ctermfg=16 guibg=#8cffba ctermbg=121
            hi def InterestingWord4 guifg=#000000 ctermfg=16 guibg=#b88853 ctermbg=137
            hi def InterestingWord5 guifg=#000000 ctermfg=16 guibg=#ff9eb8 ctermbg=211
            hi def InterestingWord6 guifg=#000000 ctermfg=16 guibg=#ff2c4b ctermbg=195

        " }}}

    " }}}

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

    " DelimitMate {{{

        

    " }}}

    " Syntastic {{{

        let g:syntastic_enable_signs = 1
        let g:syntastic_mode_map = { 'mode': 'active',
                                   \ 'active_filetypes': [],
                                   \ 'passive_filetypes': ['python', 'python.django', 'html' ] }
        let g:syntastic_stl_format = '[%E{%e Errors}%B{, }%W{%w Warnings}]'
        let g:syntastic_jsl_conf = '$HOME/.vim/jsl.conf'

        " We don't want to use coffee -c -- it yells about things I don't care
        " about.
        let g:syntastic_coffee_coffee_exe = 'coffeehint'
        let g:syntastic_coffee_coffee_args = ''
        let g:syntastic_coffee_checkers = [ 'coffee' ]


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

            au FileType coffee set softtabstop=4 tabstop=4 shiftwidth=4 textwidth=79
            au FileType coffee set dictionary+=$HOME/.vim/dict/node.dict
            au Filetype coffee let b:delimitMate_nesting_quotes = ["\"", "'", '`']
        augroup END

    " }}}

    " Ruby {{{
        " Okay you fuckin' hipsters, I give in... 2 spaces for ruby. Happy?
        au FileType ruby set softtabstop=2 tabstop=2 shiftwidth=2 textwidth=79
    " }}}

" }}}
