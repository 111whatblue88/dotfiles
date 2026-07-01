

export ZSH="$HOME/.oh-my-zsh"
export EDITOR=nvim

ZSH_THEME="lain-fino"

plugins=(
	git
	zsh-autosuggestions
)

source $ZSH/oh-my-zsh.sh

bindkey '^[g' 'forward-char'

