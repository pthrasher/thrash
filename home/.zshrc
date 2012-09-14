fortune

HOME=/Users/pthrasher

source $HOME/.zsh/options.zsh
source $HOME/.zsh/env.zsh
source $HOME/.zsh/funcs.zsh
source $HOME/.zsh/prompt.zsh
source $HOME/.zsh/aliases.zsh
source $HOME/.zsh/bindings.zsh
source $HOME/.zsh/z.zsh
source $HOME/.zsh/completion.zsh

which virtualenvwrapper.sh > /dev/null && source `which virtualenvwrapper.sh`
if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi

