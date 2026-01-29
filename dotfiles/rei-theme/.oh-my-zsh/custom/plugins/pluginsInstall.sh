#!/bin/bash

RED="\e[31m"
RESET="\e[0m"

echo "installing zsh-autosuggestions..."
if [[ -d ${HOME}/.oh-my-zsh/custom/plugins/zsh-autosuggestions ]]; then
	echo -e "zsh-autosuggestions already installed, ${RED}skipping${RESET}"
else 
	git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
fi
