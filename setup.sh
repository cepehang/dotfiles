#! /bin/bash

dotfiles_dir="$HOME/dotfiles"
nvim_config_dir="$HOME/.config/nvim"
nvim_config_file="$nvim_config_dir/init.vim" 

ohmyzsh_custom_dir="$HOME/.oh-my-zsh/"

if [ ! -f "$nvim_config_file"  ]; then
	if [ ! -d "$nvim_config_dir" ]; then
		mkdir -pv $nvim_config_dir;
	fi

	echo Creating $nvim_config_file
	{
		echo 'set runtimepath^=~/.vim runtimepath+=~/.vim/after'
		echo 'let &packpath = &runtimepath'
		echo 'source ~/.vimrc' 
	} >> $nvim_config_file
fi

ln -sv $dotfiles_dir/.vimrc $HOME/.vimrc
ln -sv $dotfiles_dir/.tmux.conf $HOME/.tmux.conf

if [ ! -d "$ohmyzsh_custom_dir" ]; then
	sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
fi

ln -sv $dotfiles_dir/better-vi-mode.zsh $ohmyzsh_custom_dir/.zshrc
ln -sv $dotfiles_dir/env.zsh $ohmyzsh_custom_dir/env.zsh
ln -sv $dotfiles_dir/aliases.zsh $ohmyzsh_custom_dir/aliases.zsh

if [ ! -d "$ohmyzsh_custom_dir/custom/themes/powerlevel10k" ]; then
	git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/themes/powerlevel10k
fi
