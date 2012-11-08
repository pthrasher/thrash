alias sl=ls
alias ls='ls -G'        # Compact view, show colors
alias la='ls -AF'       # Compact view, show hidden
alias ll='ls -al'
alias l='ls -a'
alias l1='ls -1'

alias ..='cd ..'         # Go up one directory
alias mpy='python manage.py';
alias mpysm='python manage.py schemamigration';
alias mpym='python manage.py migrate';
alias mpyrs='python manage.py runserver';
alias mpys='python manage.py shell';

alias gca='git commit -avm';
alias gco='git checkout';
alias gst='git status';
alias gpu='git push upstream';
alias gpo='git push origin';
alias gfu='git fetch upstream';
alias gfo='git fetch origin';
alias gmom='git merge origin/master';
alias gmum='git merge upstream/master';
alias gmod='git merge origin/develop';
alias gmud='git merge upstream/develop';

export HISTCONTROL="ignoredups"
export HISTCONTROL=erasedups

# resize history size
export HISTSIZE=5000
export LSCOLORS='Gxfxcxdxdxegedabagacad'
PS1='\W)';
