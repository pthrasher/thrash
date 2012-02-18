#!/bin/bash

fill="--- "
venv_prompt=''
export VCPROMPT_FORMAT="[%n:%b%m%u]"
export VIRTUAL_ENV_DISABLE_PROMPT='yeah'

# Colors
reset_style='\[\033[00m\]'
status_style=$reset_style'\[\033[0;90m\]' # gray color; use 0;37m for lighter color
prompt_style=$reset_style
command_style=$reset_style'\[\033[1;29m\]' # bold black

# Template
PS1="$status_style"'$venv_prompt[\u@\h]$(vcprompt) $fill \t\n'"$prompt_style"'\W)'"$command_style "

# Reset color for command output
trap 'echo -ne "\033[00m"' DEBUG

function prompt_command {
# Get lengths of every item that may or may not be in the line.
if [[ -z $VIRTUAL_ENV ]]; then
  venv_prompt=""
  venv_len=0
else
  venv_prompt="[$(basename "$VIRTUAL_ENV")]"
  venv_len=$(basename "$VIRTUAL_ENV" | wc -m | awk '{print $1}')
  let venv_len=$venv_len+1
fi

username_len=$(echo $USER | wc -m | awk '{print $1}')
hostname_len=$(hostname -s | wc -m | awk '{print $1}')
vcprompt_len=$(vcprompt | wc -m | awk '{print $1}')

time_len=10
whitespace_len=1

# Calculate how much room we have for dashes.
let fillsize=${COLUMNS}-$username_len-$hostname_len-$vcprompt_len-$time_len-$whitespace_len-$venv_len

fill=""
while [ "$fillsize" -gt "0" ]

do
  fill="-${fill}" # fill with underscores to work on
  let fillsize=${fillsize}-1
done
}

PROMPT_COMMAND=prompt_command
