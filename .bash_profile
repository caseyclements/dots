# See /usr/share/doc/bash/bashref.pdf for the bash reference manual
echo "Calling .bash_profile from " $HOME

# add paths
export PATH="/usr/local/lib:$PATH"
export PATH="/usr/local/include:$PATH"
# for aws cli
export PATH="$PATH:$HOME/.local/bin"

# JAVA BITS (FOR OPENGAMMA PRIMARILY)
#export JAVA_HOME="/Library/Java/JavaVirtualMachines/jdk1.8.0_92.jdk/Contents/Home"
#export JAVA_HOME=$(/usr/libexec/java_home)
#export PATH="$PATH:/usr/local/maven/apache-maven-3.3.9/bin"

# add paths if doing pyspark work
#export SPARK_HOME="/Users/cclements/code/spark-1.4.1-bin-hadoop2.6"
#export PYTHONPATH="$SPARK_HOME/python:$SPARK_HOME/python/lib/py4j-0.8.2.1-src.zip"

# add user's bin to path ===> THIS SHOULD BE PUT BACK AFTER VIM SORTED OUT <=======
export PATH="/Users/cclements/bin:$PATH"
# add postgres bin to path
export PATH="/Applications/Postgres.app/Contents/Versions/9.4/bin:$PATH"

# MacPorts Installer addition on 2014-08-29_at_12:14:16: adding an appropriate PATH variable for use with MacPorts.
export PATH="/opt/local/bin:/opt/local/sbin:$PATH"

# added by Miniconda3 4.2.12 installer
# export PATH="/Users/cclements/miniconda3/bin:$PATH"  # commented out by conda initialize

# Add token for brew commands 
export HOMEBREW_GITHUB_API_TOKEN="cb1e7808bd2d4284b106b7ce7ee80e00e1b08999"

#   -----------------------------
#   1.  ALIASES
#   -----------------------------

alias cp='cp -iv'                           # Preferred 'cp' implementation
alias mv='mv -iv'                           # Preferred 'mv' implementation
alias mkdir='mkdir -pv'                     # Preferred 'mkdir' implementation
alias ll='ls -FlAhp'                       # Preferred 'ls' implementation
alias less='less -FSRXc'                    # Preferred 'less' implementation
alias findname='find . -name'
alias cls='echo -en "\033c" && clear'   # resets terminal clearing screen and history
alias dude='du -h -d 1 .'
alias vi='vim'
greps () { grep -rnI --color=auto "$1" . ; }
mkcd () {
  case "$1" in /*) :;; *) set -- "./$1";; esac
  mkdir -p "$1" && cd "$1"
}



alias f='open -a Finder ./'                 # f:            Opens current directory in MacOS Finder
alias edit='mate'                           # edit:         Opens any file in preferred editor (currently textMate)
#alias find='find / -name art 2>/dev/null'   # omit 'pemission denied' warnings
alias grep='grep --color=auto'
alias grpr='fgrep -rnI --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
#alias pylab='ipython --pylab'
alias remove_pycache='find . -name "__pycache__" -type d -exec rm -r "{}" \;'
alias remove_pyc='find . -name "*.pyc" -exec rm -r "{}" \;'
alias gvim="mvim -g"
alias excel='open -a "Microsoft Excel"'
#alias chrome='open -a "Google Chrome" --args '
alias chrome='"/Applications/Google Chrome.app/Contents/MacOS/Google Chrome"'
# The following are used to show/hide hidden files in finder
alias showFiles='defaults write com.apple.finder AppleShowAllFiles YES;
killall Finder /System/Library/CoreServices/Finder.app'
alias hideFiles='defaults write com.apple.finder AppleShowAllFiles NO; killall Finder /System/Library/CoreServices/Finder.app'

#   -----------------------------
#   2.  GRAHAM's PROMPT
#   -----------------------------

# First bit resets to the default attributes and puts newline
#export PS1="\n"

# Very first bit is the exit code of the previous process.

#if [ -x /usr/local/bin/exitcode ]; then
#        export PS1=${PS1}"\`/usr/local/bin/exitcode \$? \${PIPESTATUS[*]} \`"
#fi

# Then username@machine. Green for local, cyan for remote.

REMOTE_IP=`/bin/echo $SSH_CLIENT | cut -f1 -d " "`

#if [ "$REMOTE_IP" ]; then
        # A cyan prompt with username@hostname in prompt and title bar
        #export PS1=${PS1}"\[\e]0;\u@\h:\w\007\]\[\e[36m\]\u@\h "
#else
        # A green prompt with working directory in title bar.
        #export PS1=${PS1}"\[\e]0;\u@\h:\w\007\]\[\e[32m\]\u@\h:"
#fi

# Show the time
#export PS1=${PS1}"\e[34m\]\t\e[m\] "

# Show git branch if there is one
#export PS1=${PS1}'$(__git_ps1 "\e[35m\](%s)\e[m\] ")'

# The next bit of the status line is the current directory in yellow.
#export PS1=${PS1}"\[\e[33m\]\w\[\e[0m\]"

# Finally we add the $ prompt on the prompt line.
#export PS1=${PS1}"\n\$ "


#   -----------------------------
#   3.  conda workon alias
#   -----------------------------
function workon {
    if [ $# -eq 0 ] 
    then
        conda info -e # list available environments
    elif  [ $# -gt 1 ]
    then
        echo 'workon takes no more than 1 arg'
    else
        conda activate $1
    fi
}
function workoff {
    if  [ $# -gt 0 ]
    then
        echo 'workoff takes no more than 0 arg'
    else
        conda deactivate
    fi
}

# !!! I created the following signing certificate when playing with dask.distributed
# !!! OSX kept bringing up firewall requests
# See: https://stackoverflow.com/questions/19688841/add-python-to-os-x-firewall-options
# (I believe) This is needed as each conda environment's Python is a different Python Distribution.
alias sign_python='codesign -s "My Custom Signing Identity" -f $(which python)'


#   -----------------------------
#   4.  FROM BRYAN
#   -----------------------------

# Bryan's prompt
function parse_git_branch {
    git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/|\1/'
}

# Simple prompt without any git functionality
#export PS1="\[\033[38;5;2m\]\u@\h:\[$(tput sgr0)\]\[\033[38;5;11m\]\w\[$(tput sgr0)\]\[\033[38;5;15m\]\n\\$ \[$(tput sgr0)\]"
export PS1="\[\033[38;5;2m\]\[$(tput sgr0)\]\[\033[38;5;11m\]\w\[$(tput sgr0)\]\[\033[38;5;15m\\n\\$ \[$(tput sgr0)\]"

# virtualenvwrapper
if [ -f /opt/local/bin/virtualenvwrapper.sh-2.7 ]; then
    source /opt/local/bin/virtualenvwrapper.sh-2.7
fi

# Enable extended bash completion
if [ -f /opt/local/etc/bash_completion ]; then
    . /opt/local/etc/bash_completion
fi

# http://hmarr.com/2010/jan/19/making-virtualenv-play-nice-with-git/
# Automatically activate Git projects' virtual environments based on the
# directory name of the project. Virtual environment name can be overridden
# by placing a .venv file in the project root with a virtualenv name in it
function workon_cwd {
    # Check that this is a Git repo
    GIT_DIR=`git rev-parse --git-dir 2> /dev/null`
    if [ $? == 0 ]; then
        # Find the repo root
        GIT_DIR=`\cd $GIT_DIR; pwd`
        PROJECT_ROOT=`dirname "$GIT_DIR"`
        # virtualenv name defaults to project directory name
        ENV_NAME=`basename "$PROJECT_ROOT"`
        # Allow override of virtualenv name in any subdirectory
        if [ -f .venv ]; then
            ENV_NAME=`cat .venv`
        fi
        # Activate the environment only if it is not already active
        #if [ "$VIRTUAL_ENV" != "$WORKON_HOME/$ENV_NAME" ]; then
            if [ -e "$WORKON_HOME/$ENV_NAME/bin/activate" ]; then
                workon "$ENV_NAME" && export CD_VIRTUAL_ENV="$ENV_NAME"
            fi
        #fi
    elif [ $CD_VIRTUAL_ENV ]; then
        # We've just left the repo, deactivate the environment
        # Note: this only happens if the virtualenv was activated automatically
        deactivate && unset CD_VIRTUAL_ENV
    fi
}
# New cd function that does the virtualenv magic
function venv_cd {
    cd "$@" && workon_cwd
    # Hack: Set tmux default path so that new windows open here
    # tmux set-option default-path `pwd` >> /dev/null
}
alias cd="venv_cd"
# Try to activate virtualenv immediately in case shell started in repository
# workon_cwd


# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/Users/cclements/miniconda3/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/Users/cclements/miniconda3/etc/profile.d/conda.sh" ]; then
        . "/Users/cclements/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="/Users/cclements/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

