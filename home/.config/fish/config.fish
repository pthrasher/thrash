function fish_prompt
    set color $fish_color_cwd
    echo ''
    echo -n '    ¬ '
    echo -n (basename (prompt_pwd))
    set color normal
    echo -n ': '
end

set fish_greeting (fortune)

function --on-variable PWD update_fasd

    fasd -A (pwd)

end

function z

    cd (fasd -d -l -r -1 $argv)

end

alias gst "git status"
alias gpo "git pull origin"
alias gpu "git pull upstream"
alias gco "git checkout"
alias gca "git commit -avm"
alias gc "git commit -v"
