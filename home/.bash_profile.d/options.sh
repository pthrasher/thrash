#!/bin/bash

# Misc {{{
export PATH=#{HOME}/.bin:${PATH}

export EDITOR="/usr/bin/vim"
export GIT_EDITOR='/usr/bin/vim'

# colored grep
export GREP_OPTIONS='--color=auto'
export GREP_COLOR='1;33'

# colored ls
export LSCOLORS='Gxfxcxdxdxegedabagacad'
    
export GITHUB_TOKEN=`security 2>&1 >/dev/null find-generic-password -gs github.token | sed -E 's/password: "([a-zA-Z0-9]+)"/\1/'`

# append to bash_history if Terminal.app quits
shopt -s histappend
#}}}

# History {{{

# Erase duplicates
# Bash History
export HISTCONTROL="ignoredups"
export HISTCONTROL=erasedups

# resize history size
export HISTSIZE=5000

export AUTOFEATURE=true autotest

function rh {
  history | awk '{a[$2]++}END{for(i in a){print a[i] " " i}}' | sort -rn | head
}
#}}}
