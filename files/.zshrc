# ZSH Configs ----------------------------------------------------------------------------------------------------------

autoload -Uz compinit
compinit


# ref: https://github.com/ohmyzsh/ohmyzsh/wiki/Plugins
plugins=(
  zsh-autosuggestions
  zsh-completions
  git
  cp
  docker
  docker-compose
  ansible
  kubectl
  nmap
  terraform
  z
)

ZSH_THEME="sh-theme-powerlevel10k"
source /usr/share/zsh-theme-powerlevel10k/powerlevel10k.zsh-theme

# enable History
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=1000
setopt SHARE_HISTORY

# Enable VTE -----------------------------------------------------------------------------------------------------------
if [ $TILIX_ID ] || [ $VTE_VERSION ]; then
  source /etc/profile.d/vte.sh
fi

# Binds ---------------------------------------------------------------------------------------------------------------
# to enable ctrl+left/right
bindkey "^[[1;5C" forward-word
bindkey "^[[1;5D" backward-word
bindkey  "^[[H"   beginning-of-line
bindkey  "^[[F"   end-of-line
bindkey  "^[[3~"  delete-char


# Alias ----------------------------------------------------------------------------------------------------------------
alias vi=vim
alias ls=lsd

alias ls='ls --color=auto'
alias grep='grep --colour=auto'
alias egrep='egrep --colour=auto'
alias fgrep='fgrep --colour=auto'
alias diff='diff --color=auto'
alias k=kubectl
alias ktx=kubectx
alias kns=kubens

alias myip="curl http://ipecho.net/plain; echo"

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

export EDITOR=/usr/bin/vim
export K9S_EDITOR=/usr/bin/vim
