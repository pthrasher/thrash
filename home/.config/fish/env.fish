set FDK_EXE ~/bin/FDK/Tools/osx
set PATH ~/bin /usr/local/bin $PATH $FDK_EXE

# export is required for these I think.
set -x GPGKEY A859BFB8
set -x GOPATH ~/Dropbox/code/Go /usr/local/go
set -x COFFEELINT_CONFIG ~/.coffeelintrc
set -x EDITOR 'mvim -f'

set NODE_PATH /usr/local/lib/node_modules $NODE_PATH
set VCPROMPT_FORMAT '%n:%b%m%u'
set VIRTUALFISH_COMPAT_ALIASES 'on'
set GREP_OPTIONS '--color=auto'

