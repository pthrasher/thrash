set -x GPGKEY A859BFB8
set -x PATH ~/bin /usr/local/bin $PATH
set -x COFFEELINT_CONFIG ~/.coffeelintrc
set -x EDITOR 'mvim -f'
set -x GOPATH ~/Dropbox/code/Go /usr/local/go
set -x NODE_PATH /usr/local/lib/node_modules $NODE_PATH
set -x VIRTUAL_ENV_DISABLE_PROMPT 'yeah'
set -x VCPROMPT_FORMAT '%n:%b%m%u'

function fish_prompt
    set_color $fish_color_cwd
    echo ''
    echo -n '    ¬ '
    echo -n (basename (prompt_pwd))
    set_color normal
    echo -n ': '
end

function fish_right_prompt -d "Write out the right prompt"
    set_color $fish_color_comment
    echo -n (vcprompt)
    if [ ! -z "$VIRTUAL_ENV" ]
        set venv (basename "$VIRTUAL_ENV")
        echo -n " venv:$venv"
    end
    set_color normal
end

set fish_greeting (fortune)

function --on-variable PWD update_fasd
    fasd -A (pwd)
end

function z
    cd (fasd -d -l -r -1 $argv)
end

function groot -d "cd's to the root of the current git repo."
    cd (git rev-parse --show-cdup)
end

function take -d "Creates a named directory and then cd's to it."
    mkdir -p $argv[1]
    cd $argv[1]
end


alias gst "git status"
alias gpo "git pull origin"
alias gpu "git pull upstream"
alias gco "git checkout"
alias gca "git commit -avm"
alias gc "git commit -v"
alias gignored "git ls-files -o -i --exclude-standard"

alias cdconf 'z sh/ho'
alias vimrc 'z sh/ho; & v .vimrc'
alias zshrc 'z sh/ho; & v .zshrc'

alias serve 'python -m SimpleHTTPServer'
alias .. 'cd ..'
alias ll 'ls -lah'
alias mpy 'python manage.py'
alias mpys 'python manage.py shell'
alias mpydbs 'python manage.py dbshell'
alias mpyrs 'python manage.py runserver'
alias mpym 'python manage.py migrate'
alias mpysm 'python manage.py schemamigration'
alias mpysma 'python manage.py schemamigration --auto'

alias gvim 'mvim'
alias v 'mvim'

