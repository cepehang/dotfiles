# powerlevel10k, should stay at the beginning
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# aliases eval and oh my zsh plugins
plugins=(
  vi-mode
  archlinux
  colored-man-pages
  common-aliases
  fancy-ctrl-z
  fzf
  git
  github
  git-escape-magic
  httpie
  mvn
  npm
  pass
  ripgrep
  rsync
  systemd
  taskwarrior
  tmux
  tmuxinator
  transfer
  yarn
  z
  zsh_reload
)
eval $(thefuck --alias)

# env
export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"
export ZSH="$XDG_CONFIG_HOME/oh-my-zsh"
export _Z_DATA="$XDG_CONFIG_HOME/z/z"
export JDK_HOME='/usr/lib/jvm/default/'

export FZF_DEFAULT_COMMAND='fd --no-ignore --hidden'
export FZF_CTRL_T_COMMAND='fd --no-ignore --hidden'
export FZF_ALT_C_COMMAND='fd --no-ignore --hidden --type directory'

# oh my zsh config
ZSH_THEME="powerlevel10k/powerlevel10k"
HYPHEN_INSENSITIVE="true"
DISABLE_UPDATE_PROMPT="true"

source $ZSH/oh-my-zsh.sh

# !! in peace
unsetopt HIST_VERIFY

# Copied from Stratus3D (http://stratus3d.com/blog/2017/10/26/better-vi-mode-in-zshell/)
# Better searching in command mode
bindkey -M vicmd '?' history-incremental-search-backward
bindkey -M vicmd '/' history-incremental-search-forward

# Beginning search with arrow keys
bindkey "^[OA" up-line-or-beginning-search
bindkey "^[OB" down-line-or-beginning-search
bindkey -M vicmd "k" up-line-or-beginning-search
bindkey -M vicmd "j" down-line-or-beginning-search

# instant esc
export KEYTIMEOUT=1

# easy last argument
bindkey -M viins '\e.' insert-last-word
