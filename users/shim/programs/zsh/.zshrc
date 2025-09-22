# Set the directory we want to store zinit and plugins
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

# Download Zinit, if it's not there yet
if [ ! -d "$ZINIT_HOME" ]; then
   mkdir -p "$(dirname $ZINIT_HOME)"
   git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

# Source/Load zinit
source "${ZINIT_HOME}/zinit.zsh"

# Add in zsh plugins
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light Aloxaf/fzf-tab

# Add in snippets
zinit snippet OMZL::git.zsh
zinit snippet OMZP::git
zinit snippet OMZP::sudo
zinit snippet OMZP::archlinux
zinit snippet OMZP::aws
zinit snippet OMZP::kubectl
zinit snippet OMZP::kubectx
zinit snippet OMZP::command-not-found

# Load completions
autoload -Uz compinit && compinit

zinit cdreplay -q

# Keybindings
bindkey -e
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward
bindkey '^[w' kill-region

# History
HISTSIZE=5000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

# Completion styling
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls --color $realpath'

# Aliases
alias ls='eza -l --color'
alias vim='nvim'
alias c='clear'
alias sp='spotify_player'
alias mt='make run-term'
alias ..="cd .."
alias n="sudo nixos-rebuild switch --flake ~/nix#paddington"
alias nd="nix develop --command $SHELL -i"

# Shell integrations
eval "$(fzf --zsh)"

eval $(thefuck --alias)

export STM32CubeMX_PATH=/Applications/STMicroelectronics/STM32CubeMX.app/Contents/Resources

export PATH=/usr/local/bin:$PATH

v() {
  if [[ $# -eq 0 ]]; then
    nvim
  else
    nvim "$@"
  fi
}

alias zshrc="nvim ~/.zshrc"
alias z="__zoxide_z"

eval "$(zoxide init zsh)"

# # The next line updates PATH for the Google Cloud SDK.
# if [ -f '/Users/shim/Downloads/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/shim/Downloads/google-cloud-sdk/path.zsh.inc'; fi
#
# # The next line enables shell command completion for gcloud.
# if [ -f '/Users/shim/Downloads/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/shim/Downloads/google-cloud-sdk/completion.zsh.inc'; fi

# Added by LM Studio CLI (lms)
path+=/home/shim/.config/emacs/bin
export PATH="$PATH:/Users/shim/.cache/lm-studio/bin"
export PATH="$PATH:/home/shim/.config/emacs/bin"

function sesh-sessions() {
  {
    exec </dev/tty
    exec <&1
    local session
    session=$(sesh list -t -c | fzf --height 40% --reverse --border-label ' sesh ' --border --prompt '⚡  ')
    zle reset-prompt > /dev/null 2>&1 || true
    [[ -z "$session" ]] && return
    sesh connect $session
  }
}

zle     -N             sesh-sessions
bindkey -M emacs '\es' sesh-sessions
bindkey -M vicmd '\es' sesh-sessions
bindkey -M viins '\es' sesh-sessions

sesh_kill_enhanced() {
  local session
  session=$(tmux list-sessions -F "#S" | fzf \
    --prompt="Select a session (Ctrl-K to kill): " \
    --bind "ctrl-k:execute-silent(tmux kill-session -t {})+reload(tmux list-sessions -F '#S')")
  
  # If you select (i.e., press Enter) on a session, attach to it:
  [ -n "$session" ] && tmux attach -t "$session"
}

eval "$(starship init zsh)"

