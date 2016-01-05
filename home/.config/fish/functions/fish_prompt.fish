function fish_prompt
    set_color normal
    echo ''
    echo -n '    '
    set_color $fish_color_cwd
    echo -n '¬'
    echo -n ' '
    set_color normal
    echo -n (basename (prompt_pwd))
    set_color $fish_color_cwd
    echo -n ': '
    # echo -e "\e[00m"
    set_color normal
end
