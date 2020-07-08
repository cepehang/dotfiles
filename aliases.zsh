alias fd='fd --type d'
alias ff='fd --type f'
alias srg='rg -C 5'

alias vim='nvim'

alias nvidia='optimus-manager --switch nvidia'
alias intel='optimus-manager --switch intel'

alias aliases='${=EDITOR} ${ZDOTDIR:-$HOME}/dotfiles/aliases.zsh'
alias vimrc='${=EDITOR} ${ZDOTDIR:-$HOME}/.vimrc' # Quick access to the .zshrc file
alias i3rc='${=EDITOR} ${ZDOTDIR:-$HOME}/.i3/config' # Quick access to the .zshrc file
alias xresources='${=EDITOR} ${ZDOTDIR:-$HOME}/.Xresources' # Quick access to the .zshrc file
alias tmuxrc='${=EDITOR} ${ZDOTDIR:-$HOME}/.tmux.conf' # Quick access to the .zshrc file

alias -g F='| fzf'
