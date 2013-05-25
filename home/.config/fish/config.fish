set -x GPGKEY A859BFB8
set -x FDK_EXE ~/bin/FDK/Tools/osx
set -x PATH ~/bin /usr/local/bin $PATH $FDK_EXE
set -x COFFEELINT_CONFIG ~/.coffeelintrc
set -x EDITOR 'mvim -f'
set -x GOPATH ~/Dropbox/code/Go /usr/local/go
set -x NODE_PATH /usr/local/lib/node_modules $NODE_PATH
set -x VCPROMPT_FORMAT '%n:%b%m%u'
set -x VIRTUALFISH_COMPAT_ALIASES 'on'
set -x GREP_OPTIONS '--color=auto'


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


function reload_config -d "Reload the .config/fish shit."
    . ~/.config/fish/config.fish
end


function fish_title
    if [ $_ = "fish" ]
        echo 'idle'
    else
        echo $_
    end
end


set -e fish_greeting
if status --is-interactive
    function fish_greeting
        fortune
    end
end


function wtc -d "Get random 'What the Commit' message."
    echo (curl http://whatthecommit.com/index.txt)
end


function gcam -d "Git add .; and git commit -avm <what the commit msg>"
    set msg (wtc)
    git add .; and git commit -avm "$msg"
end


function confpush -d "add, commit, and push dotfiles, homesick pull, reload_config"
    z "thrash/home"
    cd ..
    gcam; and git push origin; and homesick pull thrash; and reload_config
end


function --on-variable PWD update_fasd
    fasd -A "'"(pwd)"'"
end


function z
    cd (fasd -d -l -1 $argv)
end


function groot -d "cd's to the root of the current git repo."
    cd (git rev-parse --show-cdup)
end


function take -d "Creates a named directory and then cd's to it."
    mkdir -p $argv[1]
    cd $argv[1]
end


alias gst "git status"
alias gpo "git push origin"
alias gpull "git pull"
alias gco "git checkout"
alias gca "git commit -avm"
alias gc "git commit -v"
alias gignored "git ls-files -o -i --exclude-standard"

### git checkout aliases completion
complete -f -c gco -a '(__fish_git_branches)' --description 'Branch'
complete -f -c gco -a '(__fish_git_tags)' --description 'Tag'
complete -f -c gco -s b -d 'Create a new branch'
complete -f -c gco -s t -l track -d 'Track a new branch'

### git pull aliases completion
complete -f -c gpull -s q -l quiet -d 'Be quiet'
complete -f -c gpull -s v -l verbose -d 'Be verbose'
complete -f -c gpull -l all -d 'Fetch all remotes'
complete -f -c gpull -s a -l append -d 'Append ref names and object names'
complete -f -c gpull -s f -l force -d 'Force update of local branches'
complete -f -c gpull -s k -l keep -d 'Keep downloaded pack'
complete -f -c gpull -l no-tags -d 'Disable automatic tag following'
complete -f -c gpull -l progress -d 'Force progress status'
complete -f -c gpull -a '(git remote)' -d 'Remote alias'
complete -f -c gpull -a '(__fish_git_branches)' -d 'Branch'

alias cdconf 'z sh/ho'
alias vimrc 'z sh/ho; and v .vimrc'
alias fishrc 'z sh/ho; and v .config/fish/config.fish'

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

# Other imports
. ~/.config/fish/virtual.fish # VirtualEnvWrapper for fish.
