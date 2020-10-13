# dotfile management
alias config='/usr/bin/git --git-dir=$HOME/dotfiles.git/ --work-tree=$HOME'

alias fd='fd --type d'
alias ff='fd --type f'

alias srg='rg -C 5'

alias diff='icdiff'

alias ls='exa'
alias la='exa -lah'
alias tree='exa --tree'

alias -g G='| rg'
alias -g F='| fzf'
alias -g D='& disown'

alias t='task'
alias tas='task +ACTIVE stop'

alias gcos='git checkout stash@{0} --'
alias gct='git checkout --track'
alias gmod='git merge origin/develop'
alias gi='git icdiff'
alias glf='git pull --ff-only'

alias txk='tmuxinator stop'

alias vim='nvim'
alias mutt='neomutt'

alias mvnf='mvn com.coveo:fmt-maven-plugin:2.9:format'
alias mvnfci='mvn com.coveo:fmt-maven-plugin:2.9:format clean install'

alias nvidia='optimus-manager --switch nvidia'
alias intel='optimus-manager --switch intel'

alias us='setxkbmap us'
alias fr='setxkbmap fr'
alias bepo='setxkbmap -layout fr -variant bepo'

alias ag='alias | rg'

alias aliases='$EDITOR $ZSH_CUSTOM/aliases.zsh'
alias vimrc='${=EDITOR} $XDG_CONFIG_HOME/nvim/init.vim'
alias tmuxrc='${=EDITOR} ${ZDOTDIR:-$HOME}/.tmux.conf'
