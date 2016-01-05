function fish_right_prompt -d "Write out the right prompt"
    set_color normal
    echo -n (vcprompt)
    if [ ! -z "$VIRTUAL_ENV" ]
        set venv (basename "$VIRTUAL_ENV")
        if [ $venv != "default" ]
          echo -n "venv:$venv"
        end
    end
    # echo -e "\e[00m"
    set_color normal
end
