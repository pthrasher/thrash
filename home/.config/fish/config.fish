
. ~/.config/fish/env.fish
. ~/.config/fish/rbenv.fish
. ~/.config/fish/solarized_colors.fish
. ~/.config/fish/ui.fish
. ~/.config/fish/fasd.fish
. ~/.config/fish/git-halp.fish
. ~/.config/fish/virtual.fish
. ~/.config/fish/django.fish
. ~/.config/fish/angular.fish
. ~/.priv-env.fish

# important
ulimit -n 1024000

function reload_config -d "Reload the .config/fish shit."
    . ~/.config/fish/config.fish
end

function confpush -d "add, commit, and push dotfiles, homesick pull, reload_config"
    gcam; and git push origin; and homesick pull thrash; and reload_config
end


function take -d "Creates a named directory and then cd's to it."
    mkdir -p $argv[1]
    cd $argv[1]
end

function nginx-restart -d "Restart nginx."
    launchctl unload ~/Library/LaunchAgents/homebrew.mxcl.nginx.plist
    launchctl load ~/Library/LaunchAgents/homebrew.mxcl.nginx.plist
end


alias cdconf 'z sh/ho'
alias vimrc 'z sh/ho; and v .vimrc'
alias fishrc 'z sh/ho; and v .config/fish/config.fish'


alias serve 'python -m SimpleHTTPServer'
alias .. 'cd ..'
alias ll 'ls -lah'


alias gvim 'mvim'
alias v 'mvim'

alias vssh 'vagrant ssh'
