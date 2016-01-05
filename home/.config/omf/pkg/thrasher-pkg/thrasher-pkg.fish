source $OMF_CONFIG/pkg/thrasher-pkg/thrashlib/ulimit.fish
source $OMF_CONFIG/pkg/thrasher-pkg/thrashlib/env.fish
source $OMF_CONFIG/pkg/thrasher-pkg/thrashlib/rbenv.fish
source $OMF_CONFIG/pkg/thrasher-pkg/thrashlib/solarized.fish
source $OMF_CONFIG/pkg/thrasher-pkg/thrashlib/fasd.fish
source $OMF_CONFIG/pkg/thrasher-pkg/thrashlib/git-halp.fish
source $OMF_CONFIG/pkg/thrasher-pkg/thrashlib/django.fish
source $OMF_CONFIG/pkg/thrasher-pkg/thrashlib/angular.fish
source $OMF_CONFIG/pkg/thrasher-pkg/thrashlib/golang.fish
source $OMF_CONFIG/pkg/thrasher-pkg/thrashlib/rails.fish
source $OMF_CONFIG/pkg/thrasher-pkg/thrashlib/virtual.fish
source ~/.priv-env.fish

alias mpy 'python manage.py'
alias mpys 'python manage.py shell'
alias mpydbs 'python manage.py dbshell'
alias mpyrs 'python manage.py runserver'
alias mpym 'python manage.py migrate'
alias mpysm 'python manage.py schemamigration'
alias mpysma 'python manage.py schemamigration --auto'

function reload_config -d "Reload the .config/fish shit."
    source ~/.config/fish/config.fish
end

function confpush -d "add, commit, and push dotfiles, homesick pull, reload_config"
    gcam; and git push origin; and homesick pull thrash; and reload_config
end


function take -d "Creates a named directory and then cd's to it."
    mkdir -p $argv[1]
    cd $argv[1]
end

function path
  set PATH (pwd)/$argv $PATH
end

function redraw
  clear; fish_prompt
end


function fish_menu_history
  fish --command "eval (history | unique | $argv)"
end


alias cdconf 'z sh/ho'
alias vimrc 'z sh/ho; and v .vimrc'
alias fishrc 'z sh/ho; and v .config/fish/config.fish'


# alias serve 'python -m SimpleHTTPServer'
alias serve 'http-server . -p 8000 -a 0.0.0.0 -i'
alias .. 'cd ..'
# alias ls 'gls --color=auto'
alias seq gseq

for i in (seq 1 6)
  alias  l$i "tree --dirsfirst -ChFL     $i" ;; alias  l  l1
  alias ll$i "tree --dirsfirst -ChFupDaL $i" ;; alias ll ll1
end

alias gvim 'mvim'
alias v 'mvim'

alias vssh 'vagrant ssh'

alias getit 'axel -avn 8'
