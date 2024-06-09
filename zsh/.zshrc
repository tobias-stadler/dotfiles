if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="powerlevel10k/powerlevel10k"

HYPHEN_INSENSITIVE="true"

plugins=(
  git
  fzf
  zsh-syntax-highlighting
  zsh-autosuggestions
)

source $ZSH/oh-my-zsh.sh

setopt append_history
setopt share_history
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_find_no_dups

bindkey '^p' up-line-or-search
bindkey '^n' down-line-or-search
bindkey '^[[A' up-line-or-search
bindkey '^[[B' down-line-or-search
bindkey '^[OA' up-line-or-search
bindkey '^[OB' down-line-or-search

export EDITOR="nvim"
alias vim="nvim"

alias uni="cd /data/onedrive/Uni/SS24"
alias hiwi="cd /data/hiwi"
alias podfed="podman run -it --rm -v .:/app/:Z --log-driver=none --tmpfs /ram fed39-dev"
alias podhw="podman run -it --rm -v .:/app/:Z --log-driver=none --tmpfs /ram arch-dev-hw"

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
