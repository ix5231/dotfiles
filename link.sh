#!/usr/bin/zsh

HERE="${0:A:h}"

ln -s $HERE/dotfiles/zsh/.zshrc $HOME/.zshrc
ln -s $HERE/dotfiles/zsh/.zprofile $HOME/.zprofile
ln -s $HERE/dotfiles/zsh/.zsh_plugins.txt $HOME/.zsh_plugins.txt

ln -s $HERE/dotfiles/nvim $HOME/.config
ln -s $HERE/dotfiles/sway $HOME/.config
