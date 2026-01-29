#!/bin/bash

RED="\e[31m"
GREEN="\e[32m"
BLUE="\e[34m"
RESET="\e[0m"

DOTFILES_ROOT="$(git rev-parse --show-toplevel 2>/dev/null)"
ACTIVE_THEME="$(cat ${DOTFILES_ROOT}/info/activeTheme.txt)"

echo -e "${GREEN}starting Oh-My-Zsh! installation${RESET}"

if [[ -d "${HOME}/.oh-my-zsh" ]]; then
	echo -e "oh-my-zsh already installed, ${RED}skipping${RESET}"
else
	echo "installing Oh-My-Zsh!..."
	sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

echo -e "${GREEN}starting Oh-My-Zsh! configuration setup${RESET}"

if [[ -f "${DOTFILES_ROOT}/dotfiles/${ACTIVE_THEME}/.zshrc" ]]; then
	echo -e ".copying ${BLUE}.zshrc${RESET} config..."
	cp -rv "${DOTFILES_ROOT}/dotfiles/${ACTIVE_THEME}/.zshrc" "${HOME}/"
else
	echo -e "current theme \"${ACTIVE_THEME}\" does not include a .zshrc config, ${RED}skipping${RESET}"
fi

if [[ -f "${DOTFILES_ROOT}/dotfiles/${ACTIVE_THEME}/.oh-my-zsh/custom/plugins/pluginsInstall.sh" ]]; then
	echo -e "running ${ACTIVE_THEME} Oh-My-Zsh plugins installer..."
	"${DOTFILES_ROOT}/dotfiles/${ACTIVE_THEME}/.oh-my-zsh/custom/plugins/pluginsInstall.sh"
fi

echo -e "${GREEN}copying zsh-theme files${RESET}"
for file in "${DOTFILES_ROOT}/dotfiles/${ACTIVE_THEME}/.oh-my-zsh/custom/themes"/*; do
	echo -e "copying ${BLUE}${file##*/}${RESET}..."
	cp -rv "${file}" "${HOME}/.oh-my-zsh/custom/themes/"
done


