# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="ys" #"robbyrussell"
#disabled zsh-interactive-cd
plugins=(zsh-lazyload alias-finder genpass pj ansible autoswitch_virtualenv thefuck git virtualenvwrapper httpie zoxide tmux archlinux docker-compose docker systemd aliases kubectl)
PROJECT_PATHS=(~/dev ~/.config)
ZSH_TMUX_AUTOSTART=true
ZSH_TMUX_AUTOSTART_ONCE=true
#ZSH_TMUX_CONFIG=$XDG_CONFIG_HOME/tmux/tmux.conf
ZSH_TMUX_DEFAULT_SESSION_NAME=main
sessions=`tmux ls`
if echo $sessions | grep -q main; then
    unset ZSH_TMUX_DEFAULT_SESSION_NAME
fi


ZSH_TMUX_AUTOQUIT=false
ZSH_TMUX_AUTOCONNECT=false
source $ZSH/oh-my-zsh.sh
# Example aliases
#lazyload nvm -- 'source /usr/share/nvm/init-nvm.sh'

alias vim=nvim
alias zshcfg="nvim ~/.zshrc"
alias i3cfg="nvim ~/.i3/config"
alias view="nvim -R"
alias reloadzsh="source ~/.zshrc"
alias ls="lsd"
alias nvimcfg="nvim ~/.config/nvim/"
alias tmuxcfg="nvim ~/.config/tmux/tmux.conf"
alias ppp=pretty_print_path
alias hman='man --html=firefox'
pretty_print_path() {
  tr ':' '\n' <<< "${PATH}"
}


#export TERM=xterm-256color
#skip_global_compinit=1

source /home/david/.oh-my-zsh/custom/plugins/zsh_autocomplete/zsh-autocomplete.plugin.zsh

bindkey '\t' menu-select "$terminfo[kcbt]" menu-select
bindkey -M menuselect '\t' menu-complete "$terminfo[kcbt]" reverse-menu-complete
# all Tab widgets
#zstyle ':autocomplete:*complete*:*' insert-unambiguous yes
#
## all history widgets
#zstyle ':autocomplete:*history*:*' insert-unambiguous yes
#
## ^S:q
zstyle ':autocomplete:menu-search:*' insert-unambiguous yes
zstyle ':autocomplete:*' delay 0.3
#() {
#   local -a prefix=( '\e'{\[,O} )
#   local -a up=( ${^prefix}A ) down=( ${^prefix}B )
#   local key=
#   for key in $up[@]; do
#      bindkey "$key" up-line-or-history
#   done
#   for key in $down[@]; do
#      bindkey "$key" down-line-or-history
#   done
#   zle -A {.,}history-incremental-search-backward
#   zle -A {.,}vi-history-search-backward
#   bindkey -M emacs '^S' history-incremental-search-forward
#   bindkey -M vicmd '/' vi-history-search-forward
#}
# Rehash PATHS
zshcache_time="$(date +%s%N)"

autoload -Uz add-zsh-hook

rehash_precmd() {
  if [[ -a /var/cache/zsh/pacman ]]; then
    local paccache_time="$(date -r /var/cache/zsh/pacman +%s%N)"
    if (( zshcache_time < paccache_time )); then
      rehash
      zshcache_time="$paccache_time"
    fi
  fi
}

add-zsh-hook -Uz precmd rehash_precmd

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"
