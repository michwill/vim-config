# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=10000
SAVEHIST=100000
TERM="xterm"
PROMPT=$'%{\e[1;32m%}%n %{\e[0m%}%{\e[1;34m%}%~ $%{\e[0m%} '
# PATH=/home/michwill/Downloads/qiwib/bin:$PATH
setopt appendhistory
unsetopt beep
bindkey -e
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/michwill/.zshrc'

autoload -Uz compinit
compinit

function precmd() {print -Pn "\e]0;%~\a"}
# End of lines added by compinstall

export JYTHON_HOME=/home/michwill/jython2.7.1b3
export PATH=${PATH}:/home/michwill/android-sdks/platform-tools:/home/michwill/android-sdks/tools:$HOME/go/bin
export GOROOT=$HOME/go

alias zz="cd ~/Projects/zerodb && source activate"
