function fish_prompt
    set color $fish_color_cwd
    echo -n '    ¬ '
    echo -n (basename (prompt_pwd))
    set color normal
    echo -n ': '
end

set fish_greeting (fortune)
