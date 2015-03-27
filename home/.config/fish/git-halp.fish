. ~/.config/fish/git-util.fish


alias gst "git status"
alias gpo "git push origin"
alias gpull "git pull"
alias gco "git checkout"
alias gca "git commit -avm"
alias gc "git commit -v"
alias gignored "git ls-files -o -i --exclude-standard"
alias gg "git log --oneline --abbrev-commit --all --graph --decorate --color"
alias gaa "git add --all ."


function wtc -d "Get random 'What the Commit' message."
    echo (curl http://whatthecommit.com/index.txt ^/dev/null)
end


function gcam -d "Git add .; and git commit -avm <what the commit msg>"
    set msg (wtc)
    git add .; and git commit -avm "$msg"
end


function groot -d "cd's to the root of the current git repo."
    cd (git rev-parse --show-cdup)
end

function gpush -d "Ensure we're not being dumb."
  if [ $argv[1] = "upstream" ]
    echo "Uhh... I don't think you've had your coffee yet. Pushing upstream??"
  else
    git push $argv
  end
end

function gpud -d "git pull upstream develop/development with guard to ensure im on local/develop or local/development"
    set __branch (git branch --no-color | grep '*' | head -n1 | awk '{print $2}')
    echo ""
    if [ $__branch = "develop" ]
        git pull upstream develop
    else if [ $__branch = "development" ]
        git pull upstream development
    else
        echo "You're not on branch develop or development, aborting."
    end
end


### git checkout aliases completion
complete -f -c gco -a '(__fish_git_branches)' --description 'branch'
complete -f -c gco -a '(__fish_git_tags)' --description 'tag'
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

