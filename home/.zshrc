# vim key bindings
bindkey -v

fortune

HOME=/Users/pthrasher

source $HOME/.zsh/options.zsh
source $HOME/.zsh/env.zsh
source $HOME/.zsh/funcs.zsh
source $HOME/.zsh/prompt.zsh
# source $HOME/.zsh/z.zsh # not using z anymore, now I'm using fasd (or at least on a trial basis.)
source $HOME/.zsh/aliases.zsh
source $HOME/.zsh/completion.zsh
source $HOME/.zsh/bindings.zsh

which virtualenvwrapper.sh > /dev/null && source `which virtualenvwrapper.sh`
if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi
eval "$(fasd --init auto)"

