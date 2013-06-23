function --on-variable PWD check_for_gopath
    set _found_root (gopath)

    if [ ! -z "$_gp_old_path" ]
        set -x PATH $_gp_old_path
        set -e _gp_old_path
    end

    if [ ! -z "$_gp_old_gopath" ]
        set -x GOPATH $_gp_old_gopath
        set -e _gp_old_gopath
    end

    if [ ! -z "$_found_root" ]
        set -x _gp_old_path $PATH
        set -x _gp_old_gopath $GOPATH
        set -x PATH "$_found_root"/bin $PATH
        set -x GOPATH "$_found_root"
    end
end
