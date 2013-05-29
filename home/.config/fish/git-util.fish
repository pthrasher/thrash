function __fish_git_branches
  command git branch --no-color -a ^/dev/null | sgrep -v ' -> ' | sed -e 's/^..//' -e 's/^remotes\///'
end


function __fish_git_tags
  command git tag
end


function __fish_git_heads
  __fish_git_branches
  __fish_git_tags
end


function __fish_git_remotes
  command git remote
end


function __fish_git_ranges
  set -l from (commandline -ot | perl -ne 'if (index($_, "..") > 0) { my @parts = split(/\.\./); print $parts[0]; }')
  if test -z "$from"
    __fish_git_branches
    return 0
  end

  set -l to (commandline -ot | perl -ne 'if (index($_, "..") > 0) { my @parts = split(/\.\./); print $parts[1]; }')
  for from_ref in (__fish_git_heads | sgrep -e "$from")
    for to_ref in (__fish_git_heads | sgrep -e "$to")
      printf "%s..%s\n" $from_ref $to_ref
    end
  end
end


function __fish_git_needs_command
  set cmd (commandline -opc)
  if [ (count $cmd) -eq 1 -a $cmd[1] = 'git' ]
    return 0
  end
  return 1
end


function __fish_git_using_command
  set cmd (commandline -opc)
  if [ (count $cmd) -gt 1 ]
    if [ $argv[1] = $cmd[2] ]
      return 0
    end

    # aliased command
    set -l aliased (command git config --get "alias.$cmd[2]" | sed 's/ .*$//')
    if [ $argv[1] = "$aliased" ]
      return 0
    end
  end
  return 1
end
