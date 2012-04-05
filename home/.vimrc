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
"    This constantly changes. Just take a look at the commit history. I
"    generally put stuff in here to try it out, and then either keep it, or
"    remove it. ViM is so big, that any config is really personal. So... What's
"    perfect for me might not be perfect for you. We all have certain ways we
"    like to work with our code.
"   
"    Additionally, I'm always willing to answer questions regarding how to
"    incorporate ViM into your work flow so that it's useful, and not a
"    hindrance.
"
"    Email or tweet with any questions. Glad to answer.
"
"    Email:   philipthrasher@gmail.com
"    Twitter: @philipthrasher

" Bundles (Plugins) {{{

    " Preamble {{{
        set nocompatible
        filetype off

        set rtp+=~/.vim/bundle/vundle/
        call vundle#rc()
    " }}}

    " Dependencies {{{
        Bundle 'gmarik/vundle'
        Bundle 'L9'
    " }}}

    " Colors {{{
        Bundle 'altercation/vim-colors-solarized'
        " Bundle 'flazz/vim-colorschemes'
    " }}}

    " General {{{
        Bundle 'tpope/vim-repeat'
        Bundle 'tpope/vim-abolish'
        Bundle 'tpope/vim-surround'
        Bundle 'tpope/vim-git'
        Bundle 'tpope/vim-fugitive'

        Bundle 'Lokaltog/vim-powerline'
        Bundle 'godlygeek/tabular'
        Bundle 'mileszs/ack.vim'

        Bundle 'YankRing.vim'
        Bundle 'scratch.vim'
        Bundle 'sjl/gundo.vim'
        Bundle 'kien/ctrlp.vim'
    " }}}

    " Programming {{{
        Bundle 'Raimondi/delimitMate'
        Bundle 'tpope/vim-commentary'
        Bundle 'scrooloose/syntastic'
        Bundle 'AndrewRadev/linediff.vim'
        Bundle 'sjl/strftimedammit.vim'

        Bundle 'Shougo/neocomplcache-snippets-complete'
        Bundle 'Shougo/neocomplcache'
    " }}}

    " Extra Syntaxes {{{
        Bundle 'gridaphobe/go.vim'
        Bundle 'ChrisYip/Better-CSS-Syntax-for-Vim'

        " Markup
        Bundle 'tpope/vim-liquid'
        Bundle 'tpope/vim-markdown'
        Bundle 'mattn/zencoding-vim'

        " Cross-Compiled
        Bundle 'groenewege/vim-less'
        Bundle 'vim-coffee-script'

        " Javascript
        Bundle 'leshill/vim-json'
        Bundle 'taxilian/vim-web-indent'

        " Python
        " Bundle 'klen/python-mode'
        Bundle 'michaeljsmith/vim-indent-object'

        " PHP
        Bundle 'spf13/PIV'
    " }}}

    " possibly use this in the future...
    " Bundle 'sjbach/lusty'

" }}}

" Settings {{{
    " Misc Settings {{{
        filetype plugin indent on

    " Tab stuff
    set tabstop=4
    set shiftwidth=4
    set softtabstop=4
    set expandtab
    set autoindent
    set smartindent
    set smarttab

    set encoding=utf-8
    set backspace=indent,eol,start
    set textwidth=79
    set colorcolumn=+1

    " Text formatting options
    set formatoptions+=qorn1
    set modelines=5
    set ruler

    set showmode
    set showcmd
    set hidden
    set visualbell
    set cursorline
    set ttyfast
    set number
    set laststatus=2
    set history=1000
    set list
    set listchars=tab:▸\ 
    set shell=/bin/bash

    set showmatch
    set matchtime=3

    set splitbelow
    set splitright
    set fillchars=diff:⣿,vert:│

    set notimeout
    set ttimeout
    set ttimeoutlen=10

    set shiftround
    set title


    set autowrite
    set autoread

    " cpoptions :help cpoptions
    set cpoptions=aABceFs

    " Make Vim able to edit crontab files again.
    set backupskip=/tmp/*,/private/tmp/*"

    " save on focus lost
    au FocusLost * :silent! wa

    " Resize splits when the window is resized
    au VimResized * :wincmd =


    " }}}
    " Backups {{{

        if version > 720
            set undofile
            set undoreload=10000
            set undodir=~/.vim/tmp/undo
        endif

        set backupdir=~/.vim/tmp/backup
        set noswapfile

    " }}}
    " Color scheme {{{

        syntax on

        colorscheme solarized
        set background=light

        if !has('gui_running')
            set background=light
            let g:solarized_termtrans=1
        endif
    " }}}
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
    " }}}
" }}}

" Extra Functionality {{{
    " Line Return {{{

    " Make sure Vim returns to the same line when you reopen a file.
    augroup line_return
        au!
        au BufReadPost *
        \ if line("'\"") > 0 && line("'\"") <= line("$") |
        \     execute 'normal! g`"zvzz' |
        \ endif
    augroup END

    " }}}
    " Folding {{{

    set foldopen=block,insert,jump,mark,percent,quickfix,search,tag,undo
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

    " Set a nicer foldtext function
    function! MyFoldText()
        " if someone can explain to me what all this this shit does, I'd appreciate
        " it.
        let line = getline(v:foldstart)
        if match( line, '^[ \t]*\(\/\*\|\/\/\)[*/\\]*[ \t]*$' ) == 0
        let initial = substitute( line, '^\([ \t]\)*\(\/\*\|\/\/\)\(.*\)', '\1\2', '' )
        let linenum = v:foldstart + 1
        while linenum < v:foldend
            let line = getline( linenum )
            let comment_content = substitute( line, '^\([ \t\/\*]*\)\(.*\)$', '\2', 'g' )
            if comment_content != ''
            break
            endif
            let linenum = linenum + 1
        endwhile
        let sub = initial . ' ' . comment_content
        else
        let sub = line
        let startbrace = substitute( line, '^.*{[ \t]*$', '{', 'g')
        if startbrace == '{'
            let line = getline(v:foldend)
            let endbrace = substitute( line, '^[ \t]*}\(.*\)$', '}', 'g')
            if endbrace == '}'
            let sub = sub.substitute( line, '^[ \t]*}\(.*\)$', '...}\1', 'g')
            endif
        endif
        endif
        " I know what this does, I wrote it.
        let n = v:foldend - v:foldstart + 1
        let info =  n . " lines …"
        let real_line_len = strlen( info ) + strlen( sub )
        let fill_text = repeat(" ", &textwidth - real_line_len + 3)
        return sub . fill_text . info
    endfunction
    set foldtext=MyFoldText()

    " }}}
" }}}

" Key Mappings {{{
    " Leader {{{

    let mapleader = ","
    let maplocalleader = "\\"

    " }}}
    " General Mappings {{{

    " Reselect most recently edited/pasted text
    nmap gV `[v`]

    " Source currently selected lines
    vnoremap <leader>y y:@"<cr>

    " yank line without $
    nnoremap ,y ^yg_"_dd

    " Send visual selection to gist.github.com as a private, filetyped Gist
    " Requires the gist command line too (brew install gist)
    nnoremap <leader>G :w !gist -p -t %:e \| pbcopy<cr>

    " Change case
    nnoremap <C-U> gUiw
    inoremap <C-U> <esc>gUiwea
    nnoremap <C-u> guiw
    inoremap <C-u> <esc>guiwea

    " Substitute
    nnoremap <leader>s :%s//<left>

    " Emacs bindings in command line mode
    cnoremap <c-a> <home>
    cnoremap <c-e> <end>

    " Diffoff
    nnoremap <leader>D :diffoff!<cr>

    " Formatting, TextMate-style (using par)
    set formatprg=par\ -w79
    nnoremap Q gqip
    vnoremap Q gq

    " Easier linewise reselection
    nnoremap <leader>V V`]

    " S to split
    " The normal use of S is covered by cc, so don't worry about shadowing it.
    " Basically this splits the current line into two new ones at the cursor
    " position, then joins the second one with whatever comes next.
    "
    " Example:                      Cursor Here
    "                                    |
    "                                    V
    " foo = ('hello', 'world', 'a', 'b', 'c',
    "        'd', 'e')
    "
    " becomes
    "
    " foo = ('hello', 'world', 'a', 'b',
    "        'c', 'd', 'e')
    "
    " Especially useful for adding items in the middle of long lists/tuples in Python
    " while maintaining a sane text width.
    nnoremap S <nop>
    nnoremap S h/[^ ]<cr>"zd$jyyP^v$h"zpJk:s/\v +$//<cr>:noh<cr>j^

    " Acking current word under cursor
    map <Leader>f :execute "Ack " . expand("<cword>") <Bar> cw<CR>

    " Align text
    nnoremap <leader>Al :left<cr>
    nnoremap <leader>Ac :center<cr>
    nnoremap <leader>Ar :right<cr>
    vnoremap <leader>Al :left<cr>
    vnoremap <leader>Ac :center<cr>
    vnoremap <leader>Ar :right<cr>

    " Less chording
    nnoremap ; :
    vnoremap ; :
    inoremap jf <esc>

    " Cmdheight switching
    nnoremap <leader>1 :set cmdheight=1<cr>
    nnoremap <leader>2 :set cmdheight=2<cr>

    " send to preview as pdf
    nnoremap <D-p> "_ddPV`]=

    " Marks and Quotes
    noremap ' `

    " Select (charwise) the contents of the current line, excluding indentation.
    " Great for pasting Python lines into REPLs.
    nnoremap vv ^vg_

    " Calculator
    inoremap <C-B> <C-O>yiW<End>=<C-R>=<C-R>0<CR>

    " create new vert split, and switch to new buff
    nnoremap <leader>W <C-w>v<C-w>l

    " bindings for easy split nav
    nnoremap <C-h> <C-w>h
    nnoremap <C-j> <C-w>j
    nnoremap <C-k> <C-w>k
    nnoremap <C-l> <C-w>l
    "zoomwin mapping
    nnoremap <C-o> <C-w>o

    " Opens an edit command with the path of the currently edited file filled in
    " Normal mode: <Leader>e
    map <Leader>e :e <C-R>=expand("%:p:h") . "/" <CR>

    " Yank from here till end of line.
    nnoremap Y y$

    " Better Completion
    set completeopt=longest,menuone,preview

    " Sudo to write
    cnoremap w!! w !sudo tee % >/dev/null

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

    set scrolloff=8
    set sidescroll=1
    set sidescrolloff=10

    set virtualedit+=block

    noremap <leader><space> :noh<cr>:call clearmatches()<cr>

    " Highlight all occurances of the word under the cursor without changing
    " cursor position.
    nnoremap <leader>h *<C-O>

    "quick buffer switching
    nnoremap <leader><leader> <c-^>

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
    nnoremap <C-left> 5<c-w>>
    nnoremap <C-right> 5<c-w><

    " Easier to type, and I never use the default behavior.
    noremap H ^
    noremap L g_


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

    " }}}
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

    " Visual line nav, not real line nav
    noremap j gj
    noremap k gk

    " Easy buffer navigation
    noremap <C-h>  <C-w>h
    noremap <C-j>  <C-w>j
    noremap <C-k>  <C-w>k
    noremap <C-l>  <C-w>l
    noremap <leader>v <C-w>v

    " }}}
" }}}

" Plugin Settings {{{
    " Powerline {{{

    let g:Powerline_symbols = 'fancy'

    " }}}
    " Sparkup / Zen Coding {{{

        let g:user_zen_leader_key = '<c-e>'
        " let g:sparkupExecuteMapping = '<C-e>'

    " }}}
    " Commentary {{{

    nmap <leader>c <Plug>CommentaryLine
    xmap <leader>c <Plug>Commentary

    " }}}
    " Align {{{

    " vnoremap <leader>a :Align =<cr>
    vnoremap <leader>a= :Tab /=<cr>
    nnoremap <leader>a= :Tab /=<cr>

    vnoremap <leader>a: :Tab /:\zs<cr>
    nnoremap <leader>a: :Tab /:\zs<cr>

    vnoremap <leader>a/ :Tab /\/\/<cr>
    nnoremap <leader>a/ :Tab /\/\/<cr>

    " }}}
    " Linediff {{{

    vnoremap <leader>l :Linediff<cr>
    nnoremap <leader>L :LinediffReset<cr>

    " }}}
    " Syntastic {{{

    let g:syntastic_enable_signs = 1
    let g:syntastic_disabled_filetypes = ['html', 'less']
    let g:syntastic_stl_format = '[%E{%e Errors}%B{, }%W{%w Warnings}]'
    let g:syntastic_jsl_conf = '$HOME/.vim/jsl.conf'

    " }}}
    " Python-Mode Plugin {{{

"         " I prefer the online docs
"         let g:pymode_doc = 0

"         " I run from the terminal. Not crippled vim.
"         let g:pymode_run = 0
        
"         " I don't want pep8 all the time.
"         let g:pymode_lint_checker = "pyflakes"

"         " I have no clue what this does. But it says if you have a fast comp...
"         let g:pymode_syntax_slow_sync = 0

"         " Don't fuck with the whitespaces... I don't like them, but my team
"         " doesn't like noisy git diffs.
"         let g:pymode_utils_whitespaces = 0

"         " http://stackoverflow.com/a/35476
"         let g:pymode_lint_ignore = "W0142,W0403,R0201,W0212,W0613,W0232,R0903,W0614,C0111,R0913,F0401,W0402,R0914"

"         let g:pymode_lint_write = 0

    " }}}
    " neocomplcache {{{

            if version >= 730
                " Only show if I've stopped typing for a half second.
                let g:neocomplcache_enable_cursor_hold_i = 1
                let g:neocomplcache_cursor_hold_i_time = 300
            endif

            let g:neocomplcache_enable_at_startup = 1
            let g:neocomplcache_enable_camel_case_completion = 1
            let g:neocomplcache_enable_smart_case = 1
            let g:neocomplcache_enable_underbar_completion = 1
            let g:neocomplcache_min_syntax_length = 3
            let g:neocomplcache_enable_auto_delimiter = 1

            " AutoComplPop like behavior.
            let g:neocomplcache_enable_auto_select = 0

            " SuperTab like snippets behavior.

            " Plugin key-mappings.
            imap <C-k>     <Plug>(neocomplcache_snippets_expand)
            smap <C-k>     <Plug>(neocomplcache_snippets_expand)
            inoremap <expr><C-g>     neocomplcache#undo_completion()
            inoremap <expr><C-l>     neocomplcache#complete_common_string()

            " <CR>: close popup 
            " <s-CR>: close popup and save indent.
            inoremap <expr><CR>  pumvisible() ? neocomplcache#close_popup() : "\<CR>"
            inoremap <expr><s-CR> pumvisible() ? neocomplcache#close_popup() "\<CR>" : "\<CR>" 
            " <TAB>: completion.
            inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"

            " <C-h>, <BS>: close popup and delete backword char.
            inoremap <expr><C-h> neocomplcache#smart_close_popup()."\<C-h>"
            inoremap <expr><BS> neocomplcache#smart_close_popup()."\<C-h>"
            inoremap <expr><C-y>  neocomplcache#close_popup()
            inoremap <expr><C-e>  neocomplcache#cancel_popup()

            " Enable omni completion.
            autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
            autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
            autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
            autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
            autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

            " Enable heavy omni completion.
            if !exists('g:neocomplcache_omni_patterns')
                let g:neocomplcache_omni_patterns = {}
            endif
            let g:neocomplcache_omni_patterns.ruby = '[^. *\t]\.\h\w*\|\h\w*::'
            "autocmd FileType ruby setlocal omnifunc=rubycomplete#Complete
            let g:neocomplcache_omni_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
            let g:neocomplcache_omni_patterns.c = '\%(\.\|->\)\h\w*'
            let g:neocomplcache_omni_patterns.cpp = '\h\w*\%(\.\|->\)\h\w*\|\h\w*::'

            " For snippet_complete marker.
            if has('conceal')
                set conceallevel=2 concealcursor=i
            endif
    " }}}
    " Abbreviations {{{

    function! EatChar(pat)
        let c = nr2char(getchar(0))
        return (c =~ a:pat) ? '' : c
    endfunction

    function! MakeSpacelessIabbrev(from, to)
        execute "iabbrev <silent> ".a:from." ".a:to."<C-R>=EatChar('\\s')<CR>"
    endfunction

    call MakeSpacelessIabbrev('pt/',  'http://philipthrasher.com/')
    call MakeSpacelessIabbrev('gh/',  'http://github.com/')
    call MakeSpacelessIabbrev('ghp/', 'http://github.com/pthrasher/')

    iabbrev ldis ಠ_ಠ

    iabbrev pt@ philipthrasher@gmail.com

    " for the vim-abolish abbrv's look in .vim/after/plugin/abolish.vim

    " }}}
    " CtrlP {{{

        let g:ctrlp_map = '<c-t>'

    " }}}
" }}}

" Syntax Settings {{{
    " C {{{

    augroup ft_c
        au!
        au FileType c setlocal foldmethod=syntax
    augroup END

    " }}}
    " CPP {{{

    augroup ft_cpp
        au!
        au FileType cpp setlocal foldmethod=syntax
        au FileType cpp set softtabstop=2 tabstop=2 shiftwidth=2 textwidth=79
    augroup END

    " }}}
    " CSS and LessCSS {{{

    augroup ft_css
        au!

        " au BufNewFile,BufRead *.less setlocal filetype=less

        au Filetype less,css setlocal foldmethod=marker
        au Filetype less,css setlocal foldmarker={,}
        au Filetype css setlocal omnifunc=csscomplete#CompleteCSS
        " au Filetype less,css setlocal iskeyword+=-

        " Use <leader>S to sort properties.  Turns this:
        "
        "     p {
        "         width: 200px;
        "         height: 100px;
        "         background: red;
        "
        "         ...
        "     }
        "
        " into this:

        "     p {
        "         background: red;
        "         height: 100px;
        "         width: 200px;
        "
        "         ...
        "     }
        au BufNewFile,BufRead *.less,*.css nnoremap <buffer> <localleader>S ?{<CR>jV/\v^\s*\}?$<CR>k:sort<CR>:noh<CR>

        " Make {<cr> insert a pair of brackets in such a way that the cursor is correctly
        " positioned inside of them AND the following code doesn't get unfolded.
        au BufNewFile,BufRead *.less,*.css inoremap <buffer> {<cr> {}<left><cr><space><space><space><space>.<cr><esc>kA<bs>
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

        au BufNewFile,BufRead *.html setlocal filetype=htmldjango
        au FileType html,jinja,htmldjango setlocal foldmethod=manual

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

        " Smarter pasting
        au FileType html,jinja,htmldjango nnoremap <buffer> p :<C-U>YRPaste 'p'<CR>v`]=`]
        au FileType html,jinja,htmldjango nnoremap <buffer> P :<C-U>YRPaste 'P'<CR>v`]=`]
        au FileType html,jinja,htmldjango nnoremap <buffer> π :<C-U>YRPaste 'p'<CR>
        au FileType html,jinja,htmldjango nnoremap <buffer> ∏ :<C-U>YRPaste 'P'<CR>

        " Indent tag
        au FileType html,jinja,htmldjango nnoremap <buffer> <localleader>= Vat=

        " Django tags
        au FileType jinja,htmldjango inoremap <buffer> <leader><c-t> {%<space><space>%}<left><left><left>

        " Django variables
        au FileType jinja,htmldjango inoremap <buffer> <c-f> {{<space><space>}}<left><left><left>
    augroup END

    " }}}
    " Javascript {{{

    augroup ft_javascript
        au!

        au FileType javascript setlocal foldmethod=marker
        au FileType javascript setlocal foldmarker={,}

        " Make {<cr> insert a pair of brackets in such a way that the cursor is correctly
        " positioned inside of them AND the following code doesn't get unfolded.
        au Filetype javascript inoremap <buffer> {<cr> {}<left><cr><space><space><space><space>.<cr><esc>kA<bs>
    augroup END

    " }}}
    " Plain Text {{{

    function s:setupWrapping()
        set wrap
        set wm=2
        set textwidth=79
        "ios style periods
        " imap <Space><Space> .
    endfunction

    function s:setupText()
        setlocal spell
        " setlocal dictionary=/usr/share/dict/words
        let b:delimitMate_autoclose = 0 
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

        " au FileType python setlocal omnifunc=pythoncomplete#Complete
        au FileType python setlocal define=^\s*\\(def\\\\|class\\)


        au FileType python set softtabstop=4 tabstop=4 shiftwidth=4 textwidth=79

        au FileType python if exists("python_space_error_highlight") | unlet python_space_error_highlight | endif


    augroup END


    " }}}
    " PHP {{{

    augroup ft_php
        au!

        au FileType php set softtabstop=4 tabstop=4 shiftwidth=4 textwidth=79
        au Filetype php setlocal foldmethod=syntax
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
    " Ruby {{{

    augroup ft_ruby
        au!
        au Filetype ruby setlocal foldmethod=syntax
    augroup END

    " }}}
    " Vim {{{

    augroup ft_vim
        au!

        au FileType vim setlocal foldmethod=marker
        au FileType help setlocal textwidth=78
        au BufWinEnter *.txt if &ft == 'help' | wincmd L | endif
    augroup END

    " }}}
" }}}

" Last Call {{{
    
    " Stuff here doesn't work properly unless called last.

    if version > 720
        set relativenumber
    endif

" }}}
