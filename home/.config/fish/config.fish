function fish_prompt
    set color $fish_color_cwd
    echo -n '    ¬ '
    echo -n (basename (cwd))
    set color normal
    echo -n ': '
end
