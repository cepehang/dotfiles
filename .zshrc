# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
setopt appendhistory autocd extendedglob nomatch notify
unsetopt beep
bindkey -v
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/cepehang/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall

# Lines copied from pjg (https://github.com/pjg/dotfiles/blob/master/.zshrc)
# editor/visual
if type nvim >/dev/null 2>&1; then
  # neovim
  export EDITOR=nvim
  export VISUAL=nvim
else
  # vim (without support for tmp/current.vim)
  export EDITOR=vim
  export VISUAL=vim
fi

# Delete all characters between a pair of characters. Mimics vim's "di" text object functionality
function delete-in {

  # Create locally-scoped variables we'll need
  local CHAR LCHAR RCHAR LSEARCH RSEARCH COUNT

  # Read the character to indicate which text object we're deleting
  read -k CHAR

  if [ "$CHAR" = "w" ]
  then
    # diw, delete the word

    # find the beginning of the word under the cursor
    zle vi-backward-word

    # set the left side of the delete region at this point
    LSEARCH=$CURSOR

    # find the end of the word under the cursor
    zle vi-forward-word

    # set the right side of the delete region at this point
    RSEARCH=$CURSOR

    # Set the BUFFER to everything except the word we are removing
    RBUFFER="$BUFFER[$RSEARCH+1,${#BUFFER}]"
    LBUFFER="$LBUFFER[1,$LSEARCH]"

    return

  # diw was unique.  For everything else, we just have to define the
  # characters to the left and right of the cursor to be removed
  elif [ "$CHAR" = "(" ] || [ "$CHAR" = ")" ] || [ "$CHAR" = "b" ]
  then
    # di), delete inside of a pair of parenthesis
    LCHAR="("
    RCHAR=")"

  elif [ "$CHAR" = "[" ] || [ "$CHAR" = "]" ]
  then
    # di], delete inside of a pair of square brackets
    LCHAR="["
    RCHAR="]"

  elif [ $CHAR = "{" ] || [ $CHAR = "}" ] || [ "$CHAR" = "B" ]
  then
    # di}, delete inside of a pair of braces
    LCHAR="{"
    RCHAR="}"

  else
    # The character entered does not have a special definition.
    # Simply find the first instance to the left and right of the cursor.
    LCHAR="$CHAR"
    RCHAR="$CHAR"
  fi

  # Find the first instance of LCHAR to the left of the cursor and the
  # first instance of RCHAR to the right of the cursor, and remove everything in between.
  # Begin the search for the left-sided character directly the left of the cursor
  LSEARCH=${#LBUFFER}

  # Keep going left until we find the character or hit the beginning of the buffer
  while [ "$LSEARCH" -gt 0 ] && [ "$LBUFFER[$LSEARCH]" != "$LCHAR" ]
  do
    LSEARCH=$(expr $LSEARCH - 1)
  done

  # If we hit the beginning of the command line without finding the character, abort
  if [ "$LBUFFER[$LSEARCH]" != "$LCHAR" ]
  then
    return
  fi

  # start the search directly to the right of the cursor
  RSEARCH=0

  # Keep going right until we find the character or hit the end of the buffer
  while [ "$RSEARCH" -lt $(expr ${#RBUFFER} + 1 ) ] && [ "$RBUFFER[$RSEARCH]" != "$RCHAR" ]
  do
    RSEARCH=$(expr $RSEARCH + 1)
  done

  # If we hit the end of the command line without finding the character, abort
  if [ "$RBUFFER[$RSEARCH]" != "$RCHAR" ]
  then
    return
  fi

  # Set the BUFFER to everything except the text we are removing
  RBUFFER="$RBUFFER[$RSEARCH,${#RBUFFER}]"
  LBUFFER="$LBUFFER[1,$LSEARCH]"
}

zle -N delete-in


# Delete all characters between a pair of characters and then go to insert mode
# Mimics vim's "ci" text object functionality.
function change-in {
  zle delete-in
  zle vi-insert
}
zle -N change-in

# Delete all characters between a pair of characters as well as the surrounding
# characters themselves. Mimics vim's "da" text object functionality
function delete-around {
  zle delete-in
  zle vi-backward-char
  zle vi-delete-char
  zle vi-delete-char
}
zle -N delete-around

# Delete all characters between a pair of characters as well as the surrounding
# characters themselves and then go into insert mode. Mimics vim's "ca" text object functionality.
function change-around {
  zle delete-in
  zle vi-backward-char
  zle vi-delete-char
  zle vi-delete-char
  zle vi-insert
}
zle -N change-around

# TODO: implement grml-zsh rprompt
## VI MODE KEYBINDINGS (cmd mode)
#bindkey -M vicmd 'ca'    change-around
#bindkey -M vicmd 'ci'    change-in
#bindkey -M vicmd 'da'    delete-around
#bindkey -M vicmd 'di'    delete-in
#
## vim mode indicator in prompt (http://superuser.com/questions/151803/how-do-i-customize-zshs-vim-mode)
#vim_ins_mode="%{$fg[cyan]%}[INS]%{$reset_color%}"
#vim_cmd_mode="%{$fg[green]%}[CMD]%{$reset_color%}"
#vim_mode=$vim_ins_mode
#
#function zle-keymap-select {
#  vim_mode="${${KEYMAP/vicmd/${vim_cmd_mode}}/(main|viins)/${vim_ins_mode}}"
#  zle reset-prompt
#}
#zle -N zle-keymap-select
#
#function zle-line-finish {
#  vim_mode=$vim_ins_mode
#}
#zle -N zle-line-finish
#
## Fix a bug when you C-c in CMD mode and you'd be prompted with CMD mode indicator, while in fact you would be in INS mode
## Fixed by catching SIGINT (C-c), set vim_mode to INS and then repropagate the SIGINT, so if anything else depends on it, we will not break it
#function TRAPINT() {
#  vim_mode=$vim_ins_mode
#  return $(( 128 + $1 ))
#}
#
## online indicator in prompt (https://gist.github.com/remy/6079223)
#ONLINE="%{%F{green}%}◉%{$reset_color%}"
#OFFLINE="%{%F{red}%}⦿%{$reset_color%}"
#
#function prompt_online() {
#  if [[ -f ~/.offline ]]; then
#    echo $OFFLINE
#  else
#    echo $ONLINE
#  fi
#}
#
## don't display RPROMPT for previously accepted lines; only display it next to current line
#setopt transient_rprompt
#
## parameter expansion, command substitution and arithmetic expansion are performed in prompts
#setopt prompt_subst
#
#export RPROMPT='${vim_mode} $(prompt_online)'
## End of lines copied from pjg

autoload -U history-incremental-search-backward
autoload -U history-incremental-search-forward
autoload -U up-line-or-beginning-search
autoload -U down-line-or-beginning-search
zle -N history-incremental-search-backward
zle -N history-incremental-search-forward
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search

# Copied from Stratus3D (http://stratus3d.com/blog/2017/10/26/better-vi-mode-in-zshell/)
# Better searching in command mode
bindkey -M vicmd '?' history-incremental-search-backward
bindkey -M vicmd '/' history-incremental-search-forward

# Beginning search with arrow keys
bindkey "^[OA" up-line-or-beginning-search
bindkey "^[OB" down-line-or-beginning-search
bindkey -M vicmd "k" up-line-or-beginning-search
bindkey -M vicmd "j" down-line-or-beginning-search
# End of lines copied from Stratus3D

# instant esc
export KEYTIMEOUT=1

# aliases
source .aliases
