venv_prompt=''
fill=""
paths=""
export VCPROMPT_FORMAT="[%n:%b%m%u]"
export VIRTUAL_ENV_DISABLE_PROMPT='yeah'
setopt PROMPT_SUBST

# PROMPT='${FX[reset]}${FG[240]}[%n@%m]$(vcprompt)${venv_prompt} ${FX[reset]}${FG[102]}$paths $fill ${FX[reset]}${FG[245]}[%*]${FX[reset]}'
PROMPT='${FX[reset]}${FG[093]}> ${FX[reset]}'

add-zsh-hook precmd prompt-precmd() {
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

    print -rP '${FX[reset]}${FG[240]}[%n@%m]${vcpout}${venv_prompt} ${FX[reset]}${FG[102]}$paths $fill ${FX[reset]}${FG[245]}[%*]${FX[reset]}' 
}
