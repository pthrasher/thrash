#!/bin/bash

# Generic stuff {{{
extract () {
  if [ $# -ne 1 ]
  then
    echo "Error: No file specified."
    return 1
  fi
  if [ -f $1 ] ; then
    case $1 in
      *.tar.bz2) tar xvjf $1   ;;
      *.tar.gz)  tar xvzf $1   ;;
      *.bz2)     bunzip2 $1    ;;
      *.rar)     unrar x $1    ;;
      *.gz)      gunzip $1     ;;
      *.tar)     tar xvf $1    ;;
      *.tbz2)    tar xvjf $1   ;;
      *.tgz)     tar xvzf $1   ;;
      *.zip)     unzip $1      ;;
      *.Z)       uncompress $1 ;;
      *.7z)      7z x $1       ;;
      *)         echo "'$1' cannot be extracted via extract" ;;
    esac
  else
    echo "'$1' is not a valid file"
  fi
}

function ips {
  ifconfig | grep "inet " | awk '{ print $2 }'
}

function down4me() {
  curl -s "http://www.downforeveryoneorjustme.com/$1" | sed '/just you/!d;s/<[^>]*>//g'
}

function myip {
  res=$(curl -s checkip.dyndns.org | grep -Eo '[0-9\.]+')
  echo "Your public IP is: ${bold_green} $res ${normal}"
}

pass() {
  which gshuf &> /dev/null
  if [ $? -eq 1 ]
  then
    echo "Error: shuf isn't installed!"
    return 1
  fi

  pass=$(shuf -n4 /usr/share/dict/words | tr '\n' ' ')
  echo "With spaces (easier to memorize): $pass"
  echo "Without (use this as the pass): $(echo $pass | tr -d ' ')"
}

# Function for previewing markdown files in the browser

function pmdown() {
  if command -v markdown &>/dev/null
  then
    markdown $1 | browser
  else
    echo "You don't have a markdown command installed!"
  fi
}

# Make a directory and immediately 'cd' into it

function mkcd() {
  mkdir -p "$*"
  cd "$*"
}

# Search through directory contents with grep

function lsgrep(){
  ls | grep "$*"
}

# View man documentation in Preview
pman () {
   man -t "${1}" | open -f -a $PREVIEW
}


pcurl() {
  curl "${1}" | open -f -a $PREVIEW
}
quiet() {
  $* &> /dev/null &
}

# back up file with timestamp
# useful for administrators and configs
buf () {
    filename=$1
    filetime=$(date +%Y%m%d_%H%M%S)
    cp ${filename} ${filename}_${filetime}
}
#}}}

# Git {{{
function git_stats {
# awesome work from https://github.com/esc/git-stats
# including some modifications

if [ -n "$(git symbolic-ref HEAD 2> /dev/null)" ]; then
    echo "Number of commits per author:"
    git --no-pager shortlog -sn --all
    AUTHORS=$( git shortlog -sn --all | cut -f2 | cut -f1 -d' ')
    LOGOPTS=""
    if [ "$1" == '-w' ]; then
        LOGOPTS="$LOGOPTS -w"
        shift
    fi
    if [ "$1" == '-M' ]; then
        LOGOPTS="$LOGOPTS -M"
        shift
    fi
    if [ "$1" == '-C' ]; then
        LOGOPTS="$LOGOPTS -C --find-copies-harder"
        shift
    fi
    for a in $AUTHORS
    do
        echo '-------------------'
        echo "Statistics for: $a"
        echo -n "Number of files changed: "
        git log $LOGOPTS --all --numstat --format="%n" --author=$a | cut -f3 | sort -iu | wc -l
        echo -n "Number of lines added: "
        git log $LOGOPTS --all --numstat --format="%n" --author=$a | cut -f1 | awk '{s+=$1} END {print s}'
        echo -n "Number of lines deleted: "
        git log $LOGOPTS --all --numstat --format="%n" --author=$a | cut -f2 | awk '{s+=$1} END {print s}'
        echo -n "Number of merges: "
        git log $LOGOPTS --all --merges --author=$a | grep -c '^commit'
    done
else
    echo "you're currently not in a git repository"
fi
}
#}}}

# Terminal {{{
# New tab, right here. Super useful
function tab() {
  osascript 2>/dev/null <<EOF
    tell application "System Events"
      tell process "Terminal" to keystroke "t" using command down
    end
    tell application "Terminal"
      activate
      do script with command "cd \"$PWD\"; $*" in window 1
    end tell
EOF
}
#}}}

# SSH {{{
function add_ssh() {
  echo -en "\n\nHost $1\n  HostName $2\n  User $3\n  ServerAliveInterval 30\n  ServerAliveCountMax 120" >> ~/.ssh/config
}

function sshlist() {
  awk '$1 ~ /Host$/ { print $2 }' ~/.ssh/config
}
#}}}

# Todo {{{
#list, or add todos
function t() {
   if [[ "$*" == "" ]] ; then
     cat -n ~/.t
   else
     echo "$*" >> ~/.t
   fi
}

function _merge_tmp() {
  cat ~/.t_tmp > .t
  rm ~/.t_tmp
}

function _del_todo() {
  if [[ -n "$1" ]] ; then
    del_code="$1"
    sed $del_code ~/.t > ~/.t_tmp
    _merge_tmp
  fi
}

# this is how you finish commands. type t, to get
# the line number, and then type fin line-no to close one out
# you can also close multiple separating each number by a space
function fin() {
  if [[ -n "$2" ]] ; then
    # we have multiple
    items=$*
    command_string=""
    for i in $items; do
      command_string="$command_string -e ${i}d"
    done
    _del_todo "$command_string"
  else
    # we've only got one
    if [[ -n "$1" ]] ; then
      cmd_string="$1d"
      _del_todo $cmd_string
    fi
  fi
}

function uup {
  if [[ -n "$1" ]] ; then
    lineno=$1
    awk '{a[NR]=$0} END {print a['${lineno}']; for (i=1;i<=NR;i++) if (i != '$lineno') print a[i]}' ~/.t > ~/.t_tmp
    _merge_tmp
    t
  fi
}

function ddown {
  if [[ -n "$1" ]] ; then
    lineno=$1
    awk '{a[NR]=$0} END {for (i=1;i<=NR;i++) if (i != '${lineno}') print a[i]; print a['${lineno}'];}' ~/.t > ~/.t_tmp
    _merge_tmp
    t
  fi
}

function up {
  if [[ -n "$1" ]] ; then
    lineno=$1
    let linenonext=$1-1
    awk '{a[NR]=$0} END {for (i=1;i<=NR;i++) if (i != '$linenonext' && i != '$lineno') { print a[i] } else if (i == '$linenonext') { print a['$lineno']; print a['$linenonext'] } }' ~/.t > ~/.t_tmp
    _merge_tmp
    t
  fi
}

function down {
  if [[ -n "$1" ]] ; then
    lineno=$1
    let linenonext=$1+1
    awk '{a[NR]=$0} END {for (i=1;i<=NR;i++) if (i != '$lineno' && i != '$linenonext') { print a[i] } else if (i == '$linenonext') { print a['$linenonext']; print a['$lineno'] } }' ~/.t > ~/.t_tmp
    _merge_tmp
    t
  fi
}
#}}}

# python venv {{{

# make sure virtualenvwrapper is enabled if availalbe
[[ `which virtualenvwrapper.sh` ]] && . `which virtualenvwrapper.sh`

# if running bash
if [ -n "$BASH_VERSION" ]; then
    # startup virtualenv-burrito
    if [ -f "$HOME/.venvburrito/startup.sh" ]; then
        source "$HOME/.venvburrito/startup.sh"
    fi
fi
#}}}

# z {{{

#!/bin/bash

# maintains a jump-list of the directories you actually use
#
# INSTALL:
#   * put something like this in your .bashrc:
#     . /path/to/z.sh
#   * cd around for a while to build up the db
#   * PROFIT!!
#
# USE:
#   * z foo     # goes to most frecent dir matching foo
#   * z foo bar # goes to most frecent dir matching foo and bar
#   * z -r foo  # goes to highest ranked dir matching foo
#   * z -t foo  # goes to most recently accessed dir matching foo
#   * z -l foo  # list all dirs matching foo (by frecency)

z() {
 local datafile="$HOME/.z"
 if [ "$1" = "--add" ]; then
  # add
  shift
  # $HOME isn't worth matching
  [ "$*" = "$HOME" ] && return
  awk -v p="$*" -v t="$(date +%s)" -F"|" '
   BEGIN { rank[p] = 1; time[p] = t }
   $2 >= 1 {
    if( $1 == p ) {
     rank[$1] = $2 + 1
     time[$1] = t
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
  ' "$datafile" 2>/dev/null > "$datafile.tmp"
  mv -f "$datafile.tmp" "$datafile"
 elif [ "$1" = "--complete" ]; then
  # tab completion
  awk -v q="$2" -F"|" '
   BEGIN {
    if( q == tolower(q) ) nocase = 1
    split(substr(q,3),fnd," ")
   }
   {
    if( system("test -d \"" $1 "\"") ) next
    if( nocase ) {
     for( i in fnd ) tolower($1) !~ tolower(fnd[i]) && $1 = ""
     if( $1 ) print $1
    } else {
     for( i in fnd ) $1 !~ fnd[i] && $1 = ""
     if( $1 ) print $1
    }
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
  [ -d "$last" ] && cd "$last" && return
  [ -f "$datafile" ] || return
  local cd="$(awk -v t="$(date +%s)" -v list="$list" -v typ="$typ" -v q="$fnd" -v tmpfl="$datafile.tmp" -F"|" '
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
   function common(matches, fnd, nc) {
    for( i in matches ) {
     if( matches[i] && (!short || length(i) < length(short)) ) short = i
    }
    if( short == "/" ) return
    for( i in matches ) if( matches[i] && i !~ short ) x = 1
    if( x ) return
    if( nc ) {
     for( i in fnd ) if( tolower(short) !~ tolower(fnd[i]) ) x = 1
    } else for( i in fnd ) if( short !~ fnd[i] ) x = 1
    if( !x ) return short
   }
   BEGIN { split(q, a, " ") }
   {
    if( system("test -d \"" $1 "\"") ) next
    print $0 >> tmpfl
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
     output(wcase, cx, common(wcase, a, 0))
    } else if( ncx ) output(nocase, ncx, common(nocase, a, 1))
   }
  ' "$datafile")"
  if [ $? -gt 0 ]; then
   rm -f "$datafile.tmp"
  else
   mv -f "$datafile.tmp" "$datafile"
   [ "$cd" ] && cd "$cd"
  fi
 fi
}
# tab completion
complete -C 'z --complete "$COMP_LINE"' z
# populate directory list. avoid clobbering other PROMPT_COMMANDs.
echo $PROMPT_COMMAND | grep -q "z --add"
[ $? -gt 0 ] && PROMPT_COMMAND='z --add "$(pwd -P)";'"$PROMPT_COMMAND"

#}}}
