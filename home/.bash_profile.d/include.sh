#!/bin/bash
source /opt/Developer/cinderella.profile

# python venv {{{

# make sure virtualenvwrapper is enabled if availalbe
export VIRTUALENVWRAPPER_PYTHON=`which python`
[[ `which virtualenvwrapper.sh` ]] && . `which virtualenvwrapper.sh`

# if running bash
if [ -n "$BASH_VERSION" ]; then
    # startup virtualenv-burrito
    if [ -f "$HOME/.venvburrito/startup.sh" ]; then
        source "$HOME/.venvburrito/startup.sh"
    fi
fi
#}}}
