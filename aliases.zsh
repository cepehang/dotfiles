alias fd='fd --type d'
alias ff='fd --type f'
alias srg='rg -C 5'

alias -g F='| fzf'

alias vim='nvim'

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
