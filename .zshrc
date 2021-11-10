#git
alias g='git'
alias ga='git add'
alias gco='git commit'
alias pro='cd programs'
alias co='code .'
alias ns='npm start'
alias gpo='git push origin'
alias ni='npm install'
alias gc='git checkout'
alias cr='cd programs/work/react-redux'
alias note='cd programs/note'
alias cof='git branch -a | fzf | xargs git checkout'
alias tac='tail -r'

function chpwd() {
  powered_cd_add_log
}

function powered_cd_add_log() {
  local i=0
  cat ~/.powered_cd.log | while read line; do
    (( i++ ))
    if [ i = 30 ]; then
      sed -i -e "30,30d" ~/.powered_cd.log
    elif [ "$line" = "$PWD" ]; then
      sed -i -e "${i},${i}d" ~/.powered_cd.log 
    fi
  done
  echo "$PWD" >> ~/.powered_cd.log
}

function powered_cd() {
  if [ $# = 0 ]; then
    cd $(tac ~/.powered_cd.log | fzf)
  elif [ $# = 1 ]; then
    cd $1
  else
    echo "powered_cd: too many arguments"
  fi
}

_powered_cd() {
  _files -/
}

compdef _powered_cd powered_cd

[ -e ~/.powered_cd.log ] || touch ~/.powered_cd.log

zle -N powered_cd
bindkey '^u' powered_cd

eval "$(starship init zsh)"
source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
eval "$(nodenv init -)"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
