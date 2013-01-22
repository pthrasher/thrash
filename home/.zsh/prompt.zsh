autoload -U add-zsh-hook
setopt PROMPT_SUBST

export VIRTUAL_ENV_DISABLE_PROMPT='yeah'
PROMPT="    ${FG[240]}¬ %c:${FX[reset]} "

function prompt-precmd() {
    echo "\n"
}

function prompt-preexec() {
    echo "\n"
}

add-zsh-hook precmd prompt-precmd
add-zsh-hook preexec prompt-preexec

