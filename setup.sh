#! /bin/bash

dotfiles_dir="$HOME/dotfiles"
nvim_config_dir="$HOME/.config/nvim"
nvim_config_file="$nvim_config_dir/init.vim" 

ohmyzsh_custom_dir="$HOME/.oh-my-zsh/custom"

plugins="plugins=(vi-mode archlinux colored-man-pages common-aliases fzf git magic-enter systemd thefuck tmux)"

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

ln -sv $dotfiles_dir/better-vi-mode.zsh $ohmyzsh_custom_dir/better-vi-mode.zsh
ln -sv $dotfiles_dir/env.zsh $ohmyzsh_custom_dir/env.zsh
ln -sv $dotfiles_dir/aliases.zsh $ohmyzsh_custom_dir/aliases.zsh

if [ ! -d "$ohmyzsh_custom_dir/custom/themes/powerlevel10k" ]; then
	git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/themes/powerlevel10k
fi

sed -i 's/ZSH_THEME="robbyrussell"/ZSH_THEME="powerlevel10k\/powerlevel10k"/' $HOME/.zshrc
sed -i "s/plugins=(git)/$plugins/" $HOME/.zshrc

# if [ ! -f "/etc/udevmon.yaml" ]; then
# 	{
# 		echo '- JOB: "intercept -g $DEVNODE | caps2esc | uinput -d $DEVNODE"'
# 		echo '  DEVICE:'
# 		echo '    EVENTS:'
# 		echo '      EV_KEY: [KEY_CAPSLOCK, KEY_ESC]'
# 	} >> /etc/udevmon.yaml
# fi
