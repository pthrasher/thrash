autoload -U add-zsh-hook
setopt PROMPT_SUBST

export VIRTUAL_ENV_DISABLE_PROMPT='yeah'
export VCPROMPT_FORMAT=" %n:%b%m%u "
venv_prompt=''

PROMPT="    ¬${FG[240]} %c${FX[reset]}: "
RPROMPT="$(vcprompt)${venv_prompt}"

function prompt-precmd() {
    echo ""
    if [[ -z $VIRTUAL_ENV ]]; then
        venv_prompt=""
    else
        venv_prompt="[$(basename "$VIRTUAL_ENV")]"
    fi
}

function prompt-preexec() {
    echo ""
}

add-zsh-hook precmd prompt-precmd
add-zsh-hook preexec prompt-preexec

