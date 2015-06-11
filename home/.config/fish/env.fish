
set FDK_EXE ~/bin/FDK/Tools/osx

set PATH $PATH $FDK_EXE
set PATH /usr/local/bin $PATH
set PATH /usr/local/sbin $PATH
set PATH /Users/pthrasher/bin $PATH
# set PATH /Applications/Postgres.app/Contents/Versions/9.3/bin $PATH
set PATH /Users/pthrasher/Dropbox/code/Go/bin $PATH
set PATH /usr/local/Cellar/go/1.2.1/libexec/bin $PATH

# Un-fuck xcode's bullshitty shitty-ness.
set -x ARCHFLAGS -Wno-error=unused-command-line-argument-hard-error-in-future

# rbenv
set PATH $HOME/.rbenv/bin $PATH
set PATH $HOME/.rbenv/shims $PATH
set PATH $HOME/bin/depot_tools $PATH

rbenv rehash >/dev/null ^&1

# export is required for these I think.
set -x GPGKEY A859BFB8
set -x GOPATH ~/Dropbox/code/Go
set -x BASEGOPATH $GOPATH
set -x COFFEELINT_CONFIG ~/.coffeelintrc
set -x EDITOR 'mvim -f'

# export is required for these I think.
set -x JAVA_HOME (/usr/libexec/java_home)
# set -x AWS_IAM_HOME "/usr/local/opt/aws-iam-tools/jars"
# set -x AWS_CREDENTIAL_FILE $HOME/.aws-credentials-master

set NODE_PATH /usr/local/lib/node_modules $NODE_PATH
set VCPROMPT_FORMAT '%n:%b%m%u'
set VIRTUALFISH_COMPAT_ALIASES 'on'
set GREP_OPTIONS '--color=auto'

