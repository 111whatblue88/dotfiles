# Misaki Theme 
# zshrc config

export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="misaki-fino"

plugins=(
        git
        zsh-autosuggestions
)

source $ZSH/oh-my-zsh.sh

bindkey '^[g' 'forward-word'

if command -v tmux &> /dev/null && [ -z "$TMUX" ]; then
  tmux attach-session -t default || tmux new-session -s default
fi
