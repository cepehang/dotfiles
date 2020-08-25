# dotfile management
alias config='/usr/bin/git --git-dir=$HOME/dotfiles.git/ --work-tree=$HOME'

# replace ls with exa
alias ls='exa'
alias la='exa -a'
alias l.='exa -d .*'
alias ll='exa -la'

alias tree='exa --tree'

# override common aliases using better clones
alias fd='fd --type d'
alias ff='fd --type f'
alias srg='rg -C 5'
alias diff='icdiff'

alias -g G='| rg'
alias -g F='| fzf'

alias t='task'
alias vim='nvim'

alias yals='yay -Ql'

alias nvidia='optimus-manager --switch nvidia'
alias intel='optimus-manager --switch intel'

alias us='setxkbmap us'
alias fr='setxkbmap fr'
alias bepo='setxkbmap -layout fr -variant bepo'

alias aliases='${=EDITOR} ${ZDOTDIR:-$HOME}/dotfiles/aliases.zsh'
alias vimrc='${=EDITOR} ${ZDOTDIR:-$HOME}/.vimrc'
alias i3rc='${=EDITOR} ${ZDOTDIR:-$HOME}/.i3/config'
alias xresources='${=EDITOR} ${ZDOTDIR:-$HOME}/.Xresources'
alias tmuxrc='${=EDITOR} ${ZDOTDIR:-$HOME}/.tmux.conf'
