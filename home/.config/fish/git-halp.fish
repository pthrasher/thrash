
. git-util.fish

alias gst "git status"
alias gpo "git push origin"
alias gpull "git pull"
alias gco "git checkout"
alias gca "git commit -avm"
alias gc "git commit -v"
alias gignored "git ls-files -o -i --exclude-standard"

function wtc -d "Get random 'What the Commit' message."
    echo (curl http://whatthecommit.com/index.txt)
end


function gcam -d "Git add .; and git commit -avm <what the commit msg>"
    set msg (wtc)
    git add .; and git commit -avm "$msg"
end


function groot -d "cd's to the root of the current git repo."
    cd (git rev-parse --show-cdup)
end

### git checkout aliases completion
complete -f -c gco -a '(__fish_git_branches)' --description 'Branch'
complete -f -c gco -a '(__fish_git_tags)' --description 'Tag'
complete -f -c gco -s b -d 'Create a new branch'
complete -f -c gco -s t -l track -d 'Track a new branch'

### git pull aliases completion
complete -f -c gpull -s q -l quiet -d 'Be quiet'
complete -f -c gpull -s v -l verbose -d 'Be verbose'
complete -f -c gpull -l all -d 'Fetch all remotes'
complete -f -c gpull -s a -l append -d 'Append ref names and object names'
complete -f -c gpull -s f -l force -d 'Force update of local branches'
complete -f -c gpull -s k -l keep -d 'Keep downloaded pack'
complete -f -c gpull -l no-tags -d 'Disable automatic tag following'
complete -f -c gpull -l progress -d 'Force progress status'
complete -f -c gpull -a '(git remote)' -d 'Remote alias'
complete -f -c gpull -a '(__fish_git_branches)' -d 'Branch'

