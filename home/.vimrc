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
"    This is a stripped down version of my original vimrc
"
"    Email:   philipthrasher@gmail.com
"    Twitter: @philipthrasher

" General Config {{{

    set shell=/bin/bash
    set nocompatible
    filetype off
    filetype plugin indent on
    syntax on

" }}}

" Settings {{{

    " Don't show the preview window when doing completions and shit.
    set completeopt-=preview

    set fillchars=
    set fillchars+=vert:┃
    set fillchars+=diff:⣿
    set fillchars+=stlnc:\ ,stl:\ ,fold:━

    " We don't care about acting like vi
    set nocompatible " this is already set above -- only here for reference

    " Default tabstop / spacing
    set tabstop=2
    set shiftwidth=2
    set softtabstop=2

    set expandtab " use spaces instead of tabs.
    set smarttab " let's tab key insert 'tab stops', and bksp deletes tabs.
    set shiftround " tab / shifting moves to closest tabstop.
    set autoindent " Match indents on new lines.

    " This is good to have on for some comments, but bad for everything else...
    " So, I just turn it off altogether. All of my syntax files have good
    " indentation support built-in. This is not *needed*.
    set nosmartindent

    set hidden " keep buffers around when not in view.
    set visualbell " Don't beep, do visual bell -- and I've disabled visual bell in .gvimrc
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

" }}}
" Generic au commands {{{
    function! StripTrailingWS()
        let l:winview = winsaveview()
        silent! %s/\s\+$//
        call winrestview(l:winview)
    endfunction

    " auto-trim trailing white-space on save
    autocmd BufWritePre *.* :call StripTrailingWS()

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
    inoremap <C-u> <esc>mzgUiw`za

    " Less chording
    nnoremap ; :
    vnoremap ; :
    inoremap jf <esc>

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

    noremap <leader>8 :vertical resize 84<cr>

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

    " Put current line to the top of the window
    nnoremap <c-cr> zvzt

    " Space to toggle folds.
    nnoremap <Space> za
    vnoremap <Space> za

    " Make zO recursively open whatever top level fold we're in, no matter where the
    " cursor happens to be.
    nnoremap zO zCzO

    " Close all folds but my current one.
    nnoremap <leader>z zMzvzz

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

            au BufNewFile,BufRead urls.py setlocal nowrap
            au BufNewFile,BufRead tests.py setlocal nowrap
        augroup END

    " }}}

    " HTML and HTMLDjango {{{

        augroup ft_html
            au!

            au FileType html,jinja,htmldjango set textwidth=0 nowrap
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

    " JavaScript {{{

        augroup ft_json

            au BufNewFile,BufRead *.json setlocal filetype=json

        augroup END

        augroup ft_javascript
            au!

            au BufNewFile,BufRead *.es setlocal filetype=javascript
            au BufNewFile,BufRead *.es6 setlocal filetype=javascript

            au FileType javascript set softtabstop=2 tabstop=2 shiftwidth=2
        augroup END

    " }}}

    " Plain Text {{{

        augroup ft_noft
            au!

            au Filetype noft call s:setupText()

        augroup END

        function s:setupWrapping()
            set wrap
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
        augroup END


    " }}}

    " PHP {{{

        augroup ft_php
            au!

            au FileType php set softtabstop=2 tabstop=2 shiftwidth=2 textwidth=79
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

            au FileType coffee set softtabstop=2 tabstop=2 shiftwidth=2 textwidth=79
        augroup END

    " }}}

    " Ruby {{{
        augroup ft_vim
            au!

            " Okay you fuckin' hipsters, I give in... 2 spaces for ruby. Happy?
            au FileType ruby set softtabstop=2 tabstop=2 shiftwidth=2 textwidth=79

            au BufRead,BufNewFile *.arb set filetype=ruby
        augroup END
    " }}}

" }}}
