function fish_prompt
    set color $fish_color_cwd
    echo -n '    ¬ '
    echo -n (basename (prompt_pwd))
    set color normal
    echo -n ': '
end

function fish_right_prompt
    echo -n 'right'
end

set fish_greeting (fortune)
