
function fish_prompt
    set_color $fish_color_cwd
    echo ''
    echo -n '    ¬ '
    echo -n (basename (prompt_pwd))
    set_color normal
    echo -n ': '
end


function fish_right_prompt -d "Write out the right prompt"
    set_color $fish_color_comment
    echo -n (vcprompt)
    if [ ! -z "$VIRTUAL_ENV" ]
        set venv (basename "$VIRTUAL_ENV")
        echo -n " venv:$venv"
    end
    set_color normal
end


function fish_title
    if [ $_ = "fish" ]
        echo 'idle'
    else
        echo $_
    end
end


set -e fish_greeting
if status --is-interactive
    function fish_greeting
        fortune
    end
end
