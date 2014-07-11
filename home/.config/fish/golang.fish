function --on-variable PWD check_for_gopath
    set -x PATH (coffee ~/bin/set-go-path.coffee -b)
    set -x GOPATH (coffee ~/bin/set-go-path.coffee)
end
