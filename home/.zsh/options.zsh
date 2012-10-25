# color related stuff
typeset -Ag FX FG BG

# Options
setopt append_history
setopt extended_history
setopt hist_expire_dups_first
setopt hist_ignore_dups # ignore duplication command history list
setopt hist_ignore_space
setopt hist_verify
setopt inc_append_history
setopt share_history # share command history data

setopt auto_name_dirs
setopt auto_pushd
setopt pushd_ignore_dups

## smart urls
autoload -U url-quote-magic
zle -N self-insert url-quote-magic

## jobs
setopt long_list_jobs

# Dircolors
eval `dircolors ~/.zsh/dircolors.ansi-dark`
