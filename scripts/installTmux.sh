#!/bin/bash

RED="\e[31m"
GREEN="\e[32m"
BLUE="\e[34m"
RESET="\e[0m"

DOTFILES_ROOT="$(git rev-parse --show-toplevel 2>/dev/null)"
ACTIVE_THEME="$(cat ${DOTFILES_ROOT}/info/activeTheme.txt)"

echo -e "${GREEN}starting tmux installation${RESET}"

echo "installing oh-my-tmux..."
curl -fsSL "https://github.com/gpakosz/.tmux/raw/refs/heads/master/install.sh#$(date +%s)" | bash

if [[ -d ${HOME}/.config/tmux ]]; then
  echo ""
else
  echo -e "${RED}tmux config folder not found, maybe oh-my-tmux did not install correctly?${RESET}"
  echo -e "${RED}ending tmux installation...${RESET}"
  return -1
fi

echo "copying config..."

if [[ -f "${DOTFILES_ROOT}/dotfiles/${ACTIVE_THEME}/.zshrc" ]]; then
  cp -rv "${DOTFILES_ROOT}/dotfiles/${ACTIVE_THEME}/.config/tmux/tmux.conf.local" "${HOME}/.config/tmux/"
else
  echo -e "current theme \"${ACTIVE_THEME}\" does not include a .tmux.conf.local config, ${RED}skipping${RESET}"
fi

echo -e "${GREEN}finished installing tmux!${RESET}"
