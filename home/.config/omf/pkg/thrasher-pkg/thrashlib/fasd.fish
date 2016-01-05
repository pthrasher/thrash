
function --on-variable PWD update_fasd
    fasd -A "'"(pwd)"'"
end

function z
    cd (fasd -d -l -1 $argv)
end

