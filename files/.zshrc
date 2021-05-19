export ZSH="/usr/share/oh-my-zsh"

#ZSH_THEME="powerlevel10k/powerlevel10k"
ZSH_THEME="/usr/share/zsh-theme-powerlevel10k"

plugins=(
  git
  cp
  docker
  ansible
)

source $ZSH/oh-my-zsh.sh

# Enable VTE
if [ $TILIX_ID ] || [ $VTE_VERSION ]; then
        source /etc/profile.d/vte.sh
fi
