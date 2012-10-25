alias serve='python -m SimpleHTTPServer'
alias x=extract

# Push and pop directories on directory stack
alias pu='pushd'
alias po='popd'

# Basic directory operations
alias ..='cd ..'
alias ...='cd ../..'
alias -- -='cd -'

# Super user
alias _='sudo'

# Show history
alias history='fc -l 1'

# List direcory contents
alias lsa='ls -lah'
alias l='ls -la'
alias ll='ls -l'
alias sl=ls # often screw this up

alias cdblog='z er.gith'
alias cdconf='z sh/ho'
alias vimrc='z sh/ho && v .vimrc'
alias zshrc='z sh/ho && v .zshrc'

# GIT Aliases
alias g='git'
alias gst='git status'
alias gca='git commit -v -a -m'
alias gco='git checkout'
alias gpo='git push origin'
alias gpu='git push upstream'
alias gfo='git fetch origin'
alias gfu='git fetch upstream'
alias gmum='git merge upstream/master'
alias gmom='git merge origin/master'
alias gmud='git merge upstream/develop'
alias gmod='git merge origin/develop'
alias gl="git log --oneline -n"
alias glog="git log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit --date=relative"
alias gignored="git ls-files -o -i --exclude-standard"

# django aliases
alias mpy='python manage.py'
alias mpys='python manage.py shell'
alias mpydbs='python manage.py dbshell'
alias mpyrs='python manage.py runserver'
alias mpym='python manage.py migrate'
alias mpysm='python manage.py schemamigration'
alias mpysma='python manage.py schemamigration --auto'

alias gvim='mvim'
alias v='vim'

alias pman='man-preview'
