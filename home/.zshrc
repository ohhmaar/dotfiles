# Removed Powerlevel10k instant prompt - now using Starship

ZIM_HOME=${ZDOTDIR:-${HOME}}/.zim
# Download zimfw plugin manager if missing.
if [[ ! -e ${ZIM_HOME}/zimfw.zsh ]]; then
  if (( ${+commands[curl]} )); then
    curl -fsSL --create-dirs -o ${ZIM_HOME}/zimfw.zsh \
        https://github.com/zimfw/zimfw/releases/latest/download/zimfw.zsh
  else
    mkdir -p ${ZIM_HOME} && wget -nv -O ${ZIM_HOME}/zimfw.zsh \
        https://github.com/zimfw/zimfw/releases/latest/download/zimfw.zsh
  fi
fi
# Install missing modules, and update ${ZIM_HOME}/init.zsh if missing or outdated.
if [[ ! ${ZIM_HOME}/init.zsh -nt ${ZIM_CONFIG_FILE:-${ZDOTDIR:-${HOME}}/.zimrc} ]]; then
  source ${ZIM_HOME}/zimfw.zsh init
fi
ZSH_AUTOSUGGEST_STRATEGY=(completion history)

zstyle ':zim:input' double-dot-expand yes
zstyle ':zim' 'disable-version-check' 'true'

ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#665c54"  # darker gray with bold
# Initialize modules.
source ${ZIM_HOME}/init.zsh


# Initialize Starship prompt
export STARSHIP_CONFIG="$HOME/starship.toml"
eval "$(starship init zsh)"


alias reload-zsh="exec zsh"
alias edit-zsh="nvim ~/.zshrc"

# history setup
HISTFILE=$HOME/.zhistory
SAVEHIST=1000
HISTSIZE=999
setopt INC_APPEND_HISTORY     # Immediately append to history file.
setopt EXTENDED_HISTORY       # Record timestamp in history.
setopt HIST_EXPIRE_DUPS_FIRST # Expire duplicate entries first when trimming history.
setopt HIST_IGNORE_DUPS       # Dont record an entry that was just recorded again.
setopt HIST_IGNORE_ALL_DUPS   # Delete old recorded entry if new entry is a duplicate.
setopt HIST_FIND_NO_DUPS      # Do not display a line previously found.
setopt HIST_IGNORE_SPACE      # Dont record an entry starting with a space.
setopt HIST_SAVE_NO_DUPS      # Dont write duplicate entries in the history file.
setopt SHARE_HISTORY          # Share history between all sessions.
unsetopt HIST_VERIFY          # Execute commands using history (e.g.: using !$) immediately

# --- setup fzf theme (gruvbox-material) ---
fg="#d4be98"
bg="#1d2021"
bg_highlight="#3c3836"
purple="#d3869b"
blue="#7daea3"
cyan="#89b482"
green="#a9b665"
yellow="#d8a657"
orange="#e78a4e"
red="#ea6962"

export NVM_DIR="$HOME/.nvm"
  [ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"  # This loads nvm
  [ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion

alias vim='nvim'
alias oc='opencode '
export GOROOT="/opt/homebrew/opt/go@1.24/libexec"
export GOPATH="$HOME/Documents/go" 
export PATH="$GOPATH/bin:$GOROOT/bin:$PATH"
export HOMEBREW_NO_AUTO_UPDATE=1
export PATH="$HOME/.bun/bin:$PATH"

alias cat='bat'
alias gc='git checkout'

. "$HOME/.atuin/bin/env"

# bun completions
[ -s "$HOME/.bun/_bun" ] && source "$HOME/.bun/_bun"

eval "$(fzf --zsh; atuin init zsh; zoxide init zsh)"
