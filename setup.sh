#! /bin/bash

dotfiles_dir="$HOME/dotfiles";
nvim_config_dir="$HOME/.config/nvim";
nvim_config_file="$nvim_config_dir/init.vim"; 

if [ ! -f "$nvim_config_file"  ]; then
	if [ ! -d "$nvim_config_dir" ]; then
		mkdir -pv $nvim_config_dir;
	fi

	echo Creating $nvim_config_file;
	{
		echo 'set runtimepath^=~/.vim runtimepath+=~/.vim/after'
		echo 'let &packpath = &runtimepath'
		echo 'source ~/.vimrc' 
	} >> $nvim_config_file;
fi

ln -sfv $dotfiles_dir/.vimrc $HOME/.vimrc;
ln -sfv $dotfiles_dir/.zshrc $HOME/.zshrc;
ln -sfv $dotfiles_dir/.aliases $HOME/.aliases;
ln -sfv $dotfiles_dir/.tmux.conf $HOME/.tmux.conf;
