function fish_title
    if [ $_ = "fish" ]
        echo 'idle'
    else
        echo $_
    end
end
