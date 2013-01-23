autoload -U add-zsh-hook
setopt PROMPT_SUBST

export VIRTUAL_ENV_DISABLE_PROMPT='yeah'
export VCPROMPT_FORMAT=" %n:%b%m%u "
venv_prompt=''
vcpout=''

PROMPT="    ¬${FG[240]} %c${FX[reset]}: "

function prompt-precmd() {
    echo ""
    if [[ -z $VIRTUAL_ENV ]]; then
        venv_prompt=""
    else
        venv_prompt=":$(basename "$VIRTUAL_ENV")"
    fi
    vcpout=`vcprompt`
    RPROMPT="${FG[247]}${vcpout} ${venv_prompt}${FX[reset]}"
}

function prompt-preexec() {
    echo ""
}

add-zsh-hook precmd prompt-precmd
add-zsh-hook preexec prompt-preexec

