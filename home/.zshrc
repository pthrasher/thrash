export GPGKEY=A859BFB8
#
# important things that need to be loaded first:
# source /opt/Developer/cinderella.profile
which virtualenvwrapper.sh > /dev/null && source `which virtualenvwrapper.sh`
if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi
export NODE_PATH=/usr/local/lib/node_modules:$NODE_PATH

PATH=~/bin:/usr/local/n/current/bin:$PATH

# I use `n` -- this makes npm always work for the current version of node I'm
# running.
function npm() {
    active=$(node --version);
    active=${active#v};
    n npm $active $@
}

alias serve='python -m SimpleHTTPServer'

function extract() {
  local remove_archive
  local success
  local file_name
  local extract_dir

  if (( $# == 0 )); then
    echo "Usage: extract [-option] [file ...]"
    echo
    echo Options:
    echo "    -r, --remove    Remove archive."
    echo
    echo "Report bugs to <sorin.ionescu@gmail.com>."
  fi

  remove_archive=1
  if [[ "$1" == "-r" ]] || [[ "$1" == "--remove" ]]; then
    remove_archive=0 
    shift
  fi

  while (( $# > 0 )); do
    if [[ ! -f "$1" ]]; then
      echo "extract: '$1' is not a valid file" 1>&2
      shift
      continue
    fi

    success=0
    file_name="$( basename "$1" )"
    extract_dir="$( echo "$file_name" | sed "s/\.${1##*.}//g" )"
    case "$1" in
      (*.tar.gz|*.tgz) tar xvzf "$1" ;;
      (*.tar.bz2|*.tbz|*.tbz2) tar xvjf "$1" ;;
      (*.tar.xz|*.txz) tar --xz --help &> /dev/null \
        && tar --xz -xvf "$1" \
        || xzcat "$1" | tar xvf - ;;
      (*.tar.zma|*.tlz) tar --lzma --help &> /dev/null \
        && tar --lzma -xvf "$1" \
        || lzcat "$1" | tar xvf - ;;
      (*.tar) tar xvf "$1" ;;
      (*.gz) gunzip "$1" ;;
      (*.bz2) bunzip2 "$1" ;;
      (*.xz) unxz "$1" ;;
      (*.lzma) unlzma "$1" ;;
      (*.Z) uncompress "$1" ;;
      (*.zip) unzip "$1" -d $extract_dir ;;
      (*.rar) unrar e -ad "$1" ;;
      (*.7z) 7za x "$1" ;;
      (*.deb)
        mkdir -p "$extract_dir/control"
        mkdir -p "$extract_dir/data"
        cd "$extract_dir"; ar vx "../${1}" > /dev/null
        cd control; tar xzvf ../control.tar.gz
        cd ../data; tar xzvf ../data.tar.gz
        cd ..; rm *.tar.gz debian-binary
        cd ..
      ;;
      (*) 
        echo "extract: '$1' cannot be extracted" 1>&2
        success=1 
      ;; 
    esac

    (( success = $success > 0 ? $success : $? ))
    (( $success == 0 )) && (( $remove_archive == 0 )) && rm "$1"
    shift
  done
}

alias x=extract

function take() {
  mkdir -p $1
  cd $1
}

fortune

# color related stuff
typeset -Ag FX FG BG

FX=(
    reset     "%{[00m%}"
    bold      "%{[01m%}" no-bold      "%{[22m%}"
    italic    "%{[03m%}" no-italic    "%{[23m%}"
    underline "%{[04m%}" no-underline "%{[24m%}"
    blink     "%{[05m%}" no-blink     "%{[25m%}"
    reverse   "%{[07m%}" no-reverse   "%{[27m%}"
)

for color in {000..255}; do
    FG[$color]="%{[38;5;${color}m%}"
    BG[$color]="%{[48;5;${color}m%}"
done


alias ls="ls --colors"

# Enable ls colors
if [ "$DISABLE_LS_COLORS" != "true" ]
then
  # Find the option for using colors in ls, depending on the version: Linux or BSD
  ls --color -d . &>/dev/null 2>&1 && alias ls='ls --color=tty' || alias ls='ls -G'
fi

# Show all 256 colors with color number
function spectrum_ls() {
  for code in {000..255}; do
    print -P -- "$code: %F{$code}Test%f"
  done
}

# Prompt:
#


venv_prompt=''
fill=""
paths=""
export VCPROMPT_FORMAT="[%n:%b%m%u]"
export VIRTUAL_ENV_DISABLE_PROMPT='yeah'
setopt PROMPT_SUBST

# PROMPT='${FX[reset]}${FG[240]}[%n@%m]$(vcprompt)${venv_prompt} ${FX[reset]}${FG[102]}$paths $fill ${FX[reset]}${FG[245]}[%*]${FX[reset]}'
PROMPT='${FX[reset]}${FG[093]}➤ ${FX[reset]}'

precmd() {
    fill=""
    paths=""
    if [[ -z $VIRTUAL_ENV ]]; then
        venv_prompt=""
    else
        venv_prompt="[$(basename "$VIRTUAL_ENV")]"
    fi

    last_two=$(print -P "%2d")
    if [[ "${last_two}" = /* ]] {
        paths=${last_two}
    } else {
        paths="...${last_two}"
    }

    vcpout=`vcprompt`

    nofill=`print -P "[%n@%m]${vcpout}${venv_prompt} ${paths}  [%*]"`
    (( pos = ${COLUMNS} - ${#nofill} ))
    while [[ $pos -gt 0 ]] {
        fill="-${fill}"
        (( pos = ${pos} - 1 ))
    }

    #z.sh stuff:
    _z --add "$(pwd -P)"

    print -rP '${FX[reset]}${FG[240]}[%n@%m]${vcpout}${venv_prompt} ${FX[reset]}${FG[102]}$paths $fill ${FX[reset]}${FG[245]}[%*]${FX[reset]}' 
}

# Options
#
## Command history configuration
HISTFILE=$HOME/.zsh_history
HISTSIZE=10000
SAVEHIST=10000

setopt append_history
setopt extended_history
setopt hist_expire_dups_first
setopt hist_ignore_dups # ignore duplication command history list
setopt hist_ignore_space
setopt hist_verify
setopt inc_append_history
setopt share_history # share command history data

# alias man='nocorrect man'
# alias mv='nocorrect mv'
# alias mysql='nocorrect mysql'
# alias mkdir='nocorrect mkdir'
# alias gist='nocorrect gist'
# alias heroku='nocorrect heroku'
# alias ebuild='nocorrect ebuild'
# alias hpodder='nocorrect hpodder'

# fixme - the load process here seems a bit bizarre

unsetopt menu_complete   # do not autoselect the first completion entry
unsetopt flowcontrol
setopt auto_menu         # show completion menu on succesive tab press
setopt complete_in_word
setopt always_to_end

WORDCHARS=''

zmodload -i zsh/complist

## case-insensitive (all),partial-word and then substring completion
if [ "x$CASE_SENSITIVE" = "xtrue" ]; then
  zstyle ':completion:*' matcher-list 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
  unset CASE_SENSITIVE
else
  zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
fi

zstyle ':completion:*' list-colors ''

# should this be in keybindings?
bindkey -M menuselect '^o' accept-and-infer-next-history

zstyle ':completion:*:*:*:*:*' menu select
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#) ([0-9a-z-]#)*=01;34=0=01'
zstyle ':completion:*:*:*:*:processes' command "ps -u `whoami` -o pid,user,comm -w -w"

# disable named-directories autocompletion
zstyle ':completion:*:cd:*' tag-order local-directories directory-stack path-directories
cdpath=(.)

# use /etc/hosts and known_hosts for hostname completion
[ -r /etc/ssh/ssh_known_hosts ] && _global_ssh_hosts=(${${${${(f)"$(</etc/ssh/ssh_known_hosts)"}:#[\|]*}%%\ *}%%,*}) || _ssh_hosts=()
[ -r ~/.ssh/known_hosts ] && _ssh_hosts=(${${${${(f)"$(<$HOME/.ssh/known_hosts)"}:#[\|]*}%%\ *}%%,*}) || _ssh_hosts=()
[ -r /etc/hosts ] && : ${(A)_etc_hosts:=${(s: :)${(ps:\t:)${${(f)~~"$(</etc/hosts)"}%%\#*}##[:blank:]#[^[:blank:]]#}}} || _etc_hosts=()
hosts=(
  "$_global_ssh_hosts[@]"
  "$_ssh_hosts[@]"
  "$_etc_hosts[@]"
  "$HOST"
  localhost
)
zstyle ':completion:*:hosts' hosts $hosts

# Use caching so that commands like apt and dpkg complete are useable
zstyle ':completion::complete:*' use-cache 1
zstyle ':completion::complete:*' cache-path ~/.zshcomplcache/

# Don't complete uninteresting users
zstyle ':completion:*:*:*:users' ignored-patterns \
        adm amanda apache avahi beaglidx bin cacti canna clamav daemon \
        dbus distcache dovecot fax ftp games gdm gkrellmd gopher \
        hacluster haldaemon halt hsqldb ident junkbust ldap lp mail \
        mailman mailnull mldonkey mysql nagios \
        named netdump news nfsnobody nobody nscd ntp nut nx openvpn \
        operator pcap postfix postgres privoxy pulse pvm quagga radvd \
        rpc rpcuser rpm shutdown squid sshd sync uucp vcsa xfs

# ... unless we really want to.
zstyle '*' single-ignored show

if [ "x$COMPLETION_WAITING_DOTS" = "xtrue" ]; then
  expand-or-complete-with-dots() {
    echo -n "\e[31m......\e[0m"
    zle expand-or-complete
    zle redisplay
  }
  zle -N expand-or-complete-with-dots
  bindkey "^I" expand-or-complete-with-dots
fi

setopt auto_name_dirs
setopt auto_pushd
setopt pushd_ignore_dups

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

export GREP_OPTIONS='--color=auto'
export GREP_COLOR='1;32'

## smart urls
autoload -U url-quote-magic
zle -N self-insert url-quote-magic

## jobs
setopt long_list_jobs

### Key bindings
bindkey -e
bindkey "^[[5~" up-line-or-history
bindkey "^[[6~" down-line-or-history

# make search up and down work, so partially type and hit up/down to find relevant stuff
bindkey '^[[A' up-line-or-search
bindkey '^[[B' down-line-or-search
# Make the delete key (or Fn + Delete on the Mac) work instead of outputting a ~
bindkey '^?' backward-delete-char
bindkey "^[[3~" delete-char
bindkey "^[3;5~" delete-char
bindkey "\e[3~" delete-char

bindkey ' ' magic-space    # also do history expansion on space
bindkey '^[[Z' reverse-menu-complete

#npm completion
eval "$(npm completion 2>/dev/null)"

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

# django aliases
alias mpy='python manage.py'
alias mpys='python manage.py shell'
alias mpydbs='python manage.py dbshell'
alias mpyrs='python manage.py runserver'
alias mpysm='python manage.py schemamigration'
alias mpysma='python manage.py schemamigration --auto'

alias gvim='mvim'
alias v='mvim'
export EDITOR='mvim -f'

function random () {
    cat /dev/urandom | base64 | head -c$1
}

# Copyright (c) 2009 rupa deadwyler under the WTFPL license

# maintains a jump-list of the directories you actually use
#
# INSTALL:
#   * optionally:
#     set $_Z_CMD in .bashrc/.zshrc to change the command (default z).
#     set $_Z_DATA in .bashrc/.zshrc to change the datafile (default ~/.z).
#   * put something like this in your .bashrc:
#     . /path/to/z.sh
#   * put something like this in your .zshrc:
#     . /path/to/z.sh
#     function precmd () {
#       _z --add "$(pwd -P)"
#     }
#   * cd around for a while to build up the db
#   * PROFIT!!
#
# USE:
#   * z foo     # cd to most frecent dir matching foo
#   * z foo bar # cd to most frecent dir matching foo and bar
#   * z -r foo  # cd to highest ranked dir matching foo
#   * z -t foo  # cd to most recently accessed dir matching foo
#   * z -l foo  # list all dirs matching foo (by frecency)

_z() {

 local datafile="${_Z_DATA:-$HOME/.z}"

 # bail out if we don't own ~/.z (we're another user but our ENV is still set)
 [ -f "$datafile" -a ! -O "$datafile" ] && return

 # add entries
 if [ "$1" = "--add" ]; then
  shift

  # $HOME isn't worth matching
  [ "$*" = "$HOME" ] && return

  # maintain the file
  local tempfile
  tempfile="$(mktemp $datafile.XXXXXX)" || return
  awk -v path="$*" -v now="$(date +%s)" -v datafile="$datafile" -F"|" '
   function notdir(path, tmp) {
    # faster than system()
    n = gsub("/+", "/", path)
    for( i = 0; i < n; i++ ) path = path "/.."
    path = path datafile
    if( ( getline tmp < path ) >= 0 ) {
      close(path)
      return 0
    }
    return 1
   }
   BEGIN {
    rank[path] = 1
    time[path] = now
   }
   $2 >= 1 {
    if( notdir($1) ) next
    if( $1 == path ) {
     rank[$1] = $2 + 1
     time[$1] = now
    } else {
     rank[$1] = $2
     time[$1] = $3
    }
    count += $2
   }
   END {
    if( count > 1000 ) {
     for( i in rank ) print i "|" 0.9*rank[i] "|" time[i] # aging
    } else for( i in rank ) print i "|" rank[i] "|" time[i]
   }
  ' "$datafile" 2>/dev/null >| "$tempfile"
  if [ $? -ne 0 -a -f "$datafile" ]; then
   env rm -f "$tempfile"
  else
   env mv -f "$tempfile" "$datafile"
  fi

 # tab completion
 elif [ "$1" = "--complete" ]; then
  awk -v q="$2" -v datafile="$datafile" -F"|" '
   function notdir(path, tmp) {
    # faster than system()
    n = gsub("/+", "/", path)
    for( i = 0; i < n; i++ ) path = path "/.."
    path = path datafile
    if( ( getline tmp < path ) >= 0 ) {
      close(path)
      return 0
    }
    return 1
   }
   BEGIN {
    if( q == tolower(q) ) nocase = 1
    split(substr(q,3),fnd," ")
   }
   {
    if( notdir($1) ) next
    if( nocase ) {
     for( i in fnd ) tolower($1) !~ tolower(fnd[i]) && $1 = ""
    } else {
     for( i in fnd ) $1 !~ fnd[i] && $1 = ""
    }
    if( $1 ) print $1
   }
  ' "$datafile" 2>/dev/null

 else
  # list/go
  while [ "$1" ]; do case "$1" in
   -h) echo "z [-h][-l][-r][-t] args" >&2; return;;
   -l) local list=1;;
   -r) local typ="rank";;
   -t) local typ="recent";;
   --) while [ "$1" ]; do shift; local fnd="$fnd $1";done;;
    *) local fnd="$fnd $1";;
  esac; local last=$1; shift; done
  [ "$fnd" ] || local list=1

  # if we hit enter on a completion just go there
  case "$last" in
   # completions will always start with /
   /*) [ -z "$list" -a -d "$last" ] && cd "$last" && return;;
  esac

  # no file yet
  [ -f "$datafile" ] || return

  local cd
  cd="$(awk -v t="$(date +%s)" -v list="$list" -v typ="$typ" -v q="$fnd" -v datafile="$datafile" -F"|" '
   function notdir(path, tmp) {
    n = gsub("/+", "/", path)
    for( i = 0; i < n; i++ ) path = path "/.."
    path = path datafile
    if( ( getline tmp < path ) >= 0 ) {
      close(path)
      return 0
    }
    return 1
   }
   function frecent(rank, time) {
    dx = t-time
    if( dx < 3600 ) return rank*4
    if( dx < 86400 ) return rank*2
    if( dx < 604800 ) return rank/2
    return rank/4
   }
   function output(files, toopen, override) {
    if( list ) {
     if( typ == "recent" ) {
      cmd = "sort -nr >&2"
     } else cmd = "sort -n >&2"
     for( i in files ) if( files[i] ) printf "%-10s %s\n", files[i], i | cmd
     if( override ) printf "%-10s %s\n", "common:", override > "/dev/stderr"
    } else {
     if( override ) toopen = override
     print toopen
    }
   }
   function common(matches) {
    # shortest match
    for( i in matches ) {
     if( matches[i] && (!short || length(i) < length(short)) ) short = i
    }
    if( short == "/" ) return

    # escape regex chars in right hand side
    #gsub(/[\(\[\|]/, "\\\&", short)

    # shortest match must be common to each match
    for( i in matches ) if( matches[i] && i !~ short ) return
    return short
   }
   BEGIN { split(q, a, " ") }
   {
    if( notdir($1) ) next
    if( typ == "rank" ) {
     f = $2
    } else if( typ == "recent" ) {
     f = t-$3
    } else f = frecent($2, $3)
    wcase[$1] = nocase[$1] = f
    for( i in a ) {
     if( $1 !~ a[i] ) delete wcase[$1]
     if( tolower($1) !~ tolower(a[i]) ) delete nocase[$1]
    }
    if( wcase[$1] > oldf ) {
     cx = $1
     oldf = wcase[$1]
    } else if( nocase[$1] > noldf ) {
     ncx = $1
     noldf = nocase[$1]
    }
   }
   END {
    if( cx ) {
     output(wcase, cx, common(wcase))
    } else if( ncx ) output(nocase, ncx, common(nocase))
   }
  ' "$datafile")"
  [ $? -gt 0 ] && return
  [ "$cd" ] && cd "$cd"
 fi
}

alias ${_Z_CMD:-z}='_z 2>&1'

if complete &> /dev/null; then
 # bash tab completion
 complete -C '_z --complete "$COMP_LINE"' ${_Z_CMD:-z}
 # populate directory list. avoid clobbering other PROMPT_COMMANDs.
 echo $PROMPT_COMMAND | grep -q "_z --add"
 [ $? -gt 0 ] && PROMPT_COMMAND='_z --add "$(pwd -P 2>/dev/null)" 2>/dev/null;'"$PROMPT_COMMAND"
elif compctl &> /dev/null; then
 # zsh tab completion
 _z_zsh_tab_completion() {
  local compl
  read -l compl
  reply=(${(f)"$(_z --complete "$compl")"})
 }
 compctl -U -K _z_zsh_tab_completion _z
fi

function chpwd () {
    _z --add "$(pwd -P)"
}
