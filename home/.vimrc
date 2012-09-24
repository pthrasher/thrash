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

        Bundle 'altercation/vim-colors-solarized'
        Bundle 'flazz/vim-colorschemes'

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

    " }}}

    " Programming {{{

        Bundle 'Raimondi/delimitMate'
        Bundle 'tpope/vim-commentary'
        Bundle 'scrooloose/syntastic'
        Bundle 'sjl/strftimedammit.vim'

        Bundle 'Shougo/neocomplcache-snippets-complete'
        Bundle 'Shougo/neocomplcache'

        " On trial: (could be removed at any moment if they do not bring me
        " exquisite pleasure)
        Bundle 'tpope/vim-endwise'
        Bundle 'tpope/vim-eunuch'
        Bundle 'switch.vim'
    " }}}

    " Extra Syntaxes {{{

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
    set wildignore+=.hg,.git,.svn                    " Version control
    set wildignore+=*.aux,*.out,*.toc                " LaTeX intermediate files
    set wildignore+=*.jpg,*.bmp,*.gif,*.png,*.jpeg   " binary images
    set wildignore+=*.o,*.obj,*.exe,*.dll,*.manifest " compiled object files
    set wildignore+=*.spl                            " compiled spelling word lists
    set wildignore+=*.sw?                            " Vim swap files
    set wildignore+=*.DS_Store                       " OSX bullshit
    set wildignore+=migrations                       " Django migrations
    set wildignore+=*.pyc                            " Python byte code

    set shell=/bin/zsh

    " for terminal vim:
    set bg=dark
    colorscheme wombat256

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
    
    "quick buffer switching
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
    noremap j gj
    noremap k gk

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

        nmap <leader>c <Plug>CommentaryLine
        xmap <leader>c <Plug>Commentary

    " }}}

    " Syntastic {{{

        let g:syntastic_enable_signs = 1
        let g:syntastic_disabled_filetypes = ['html', 'py']
        let g:syntastic_stl_format = '[%E{%e Errors}%B{, }%W{%w Warnings}]'
        let g:syntastic_jsl_conf = '$HOME/.vim/jsl.conf'

    " }}}

    " delimitMate {{{


        let delimitMate_expand_cr = 1
        let delimitMate_expand_space = 1
        

    " }}}

    " neocomplecache {{{

        " NOTE: There are a lot of settings for this plugin. This config is
        " very fragile. I don't exactly understand what everything in here
        " does, but if you fuck with it, neocomplcache doesn't do what you
        " want, so here it is. After much work / effort / trial and error, the
        " below config works as closely to intellisense I could get it.

        " Only show if I've stopped typing for a tenth second.
        let g:neocomplcache_enable_cursor_hold_i = 1
        let g:neocomplcache_cursor_hold_i_time = 100

        let g:neocomplcache_enable_at_startup = 1
        let g:neocomplcache_enable_camel_case_completion = 1
        let g:neocomplcache_enable_smart_case = 1
        let g:neocomplcache_enable_underbar_completion = 1
        let g:neocomplcache_min_syntax_length = 3
        let g:neocomplcache_enable_auto_delimiter = 1

        " AutoComplPop like behavior.
        let g:neocomplcache_enable_auto_select = 0

        " Plugin key-mappings.
        imap <C-k>     <Plug>(neocomplcache_snippets_expand)
        smap <C-k>     <Plug>(neocomplcache_snippets_expand)
        inoremap <expr><C-g>     neocomplcache#undo_completion()
        inoremap <expr><C-l>     neocomplcache#complete_common_string()

        " <CR>: close popup 
        " <s-CR>: close popup and save indent.
        " inoremap <expr><CR>  pumvisible() ? neocomplcache#close_popup() : "\<CR>"
        " inoremap <expr><s-CR> pumvisible() ? neocomplcache#close_popup() "\<CR>" : "\<CR>" 
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

        " User defined snippets
        let g:neocomplcache_snippets_dir = '~/.vim/mysnippets/'

        " SuperTab like snippets behavior.
        imap <expr><TAB> neocomplcache#sources#snippets_complete#expandable() ? "\<Plug>(neocomplcache_snippets_expand)" : pumvisible() ? "\<C-n>" : "\<TAB>"

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
        augroup END

    " }}}

    " Plain Text {{{

        function s:setupWrapping()
            set wrap
            set wm=2
            set textwidth=79
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

            " Don't load this shit... Srsly.
            au BufRead,BufNewFile *.{md,markdown,mdown,mkd,mkdn} let b:loaded_delimitMate = 1
            au BufNewFile,BufRead *.{md,markdown,mdown,mkd,mkdn} setlocal filetype=markdown
            au BufRead,BufNewFile *.{md,markdown,mdown,mkd,mkdn} call s:setupMarkup()
        augroup END

    " }}}

    " Python {{{

        augroup ft_python
            au!

            au FileType python setlocal omnifunc=pythoncomplete#Complete
            au FileType python setlocal define=^\s*\\(def\\\\|class\\)
            au FileType python set softtabstop=4 tabstop=4 shiftwidth=4 textwidth=79
            au FileType python let b:delimitMate_nesting_quotes = ['"']
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
        augroup END

    " }}}

    " Ruby {{{
        " Okay you fuckin' hipsters, I give in... 2 spaces for ruby. Happy?
        au FileType ruby set softtabstop=2 tabstop=2 shiftwidth=2 textwidth=79
    " }}}

" }}}
