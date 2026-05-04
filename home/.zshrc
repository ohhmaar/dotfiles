[[ -x /opt/homebrew/bin/brew ]] && eval "$(/opt/homebrew/bin/brew shellenv)"
typeset -U path PATH

ZIM_HOME=${ZDOTDIR:-$HOME}/.zim
[[ -r "${ZIM_HOME}/init.zsh" ]] && source "${ZIM_HOME}/init.zsh"

zstyle ':zim:input' double-dot-expand yes
zstyle ':zim' disable-version-check true
ZSH_AUTOSUGGEST_STRATEGY=(completion history)
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=#665c54'

export STARSHIP_CONFIG="$HOME/starship.toml"
if [[ -o interactive ]] && command -v starship >/dev/null 2>&1; then
  eval "$(starship init zsh)"
fi

HISTFILE="$HOME/.zhistory"
HISTSIZE=5000
SAVEHIST=5000
setopt INC_APPEND_HISTORY
setopt EXTENDED_HISTORY
setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_FIND_NO_DUPS
setopt HIST_IGNORE_SPACE
setopt SHARE_HISTORY
unsetopt HIST_VERIFY

export EDITOR="nvim"
export HOMEBREW_NO_AUTO_UPDATE=1
export GOPATH="$HOME/Documents/go"

path=(
  "$HOME/.local/share/bob/nvim-bin"
  "$HOME/.bun/bin"
  "$GOPATH/bin"
  $path
)

[[ -r "$HOME/.atuin/bin/env" ]] && source "$HOME/.atuin/bin/env"
unset __MISE_DIFF __MISE_ORIG_PATH __MISE_SESSION __MISE_ZSH_PRECMD_RUN
if command -v mise >/dev/null 2>&1; then
  eval "$(mise activate zsh)"
fi

if [[ -o interactive && -t 0 && -t 1 ]]; then
  if command -v fzf >/dev/null 2>&1; then
    eval "$(fzf --zsh)"
  fi
  if command -v atuin >/dev/null 2>&1; then
    eval "$(atuin init zsh)"
  fi
  if command -v zoxide >/dev/null 2>&1; then
    eval "$(zoxide init zsh)"
  fi
fi

[[ -s "$HOME/.bun/_bun" ]] && source "$HOME/.bun/_bun"

alias reload-zsh='exec zsh'
alias edit-zsh='nvim ~/.zshrc'
alias vim='nvim'
alias oc='opencode attach http://0.0.0.0:4096 --dir=. '
alias cat='bat'
alias gc='git checkout'

ga() {
  if [[ -z "$1" ]]; then
    echo "Usage: ga [branch-name]"
    return 1
  fi

  if ! git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
    echo "ga: not inside a git repository"
    return 1
  fi

  local branch="$1"
  local base branch_slug repo_root worktree_path

  repo_root="$(git rev-parse --show-toplevel)" || return 1
  base="$(basename "$repo_root")"
  branch_slug="${branch//\//-}"
  worktree_path="$(dirname "$repo_root")/${base}--${branch_slug}"

  git -C "$repo_root" worktree add -b "$branch" "$worktree_path" || return 1

  if command -v mise >/dev/null 2>&1; then
    mise trust "$worktree_path"
  fi

  cd "$worktree_path" || return 1
}

gd() {
  local cwd worktree root branch

  if ! git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
    echo "gd: not inside a git repository"
    return 1
  fi

  cwd="$(git rev-parse --show-toplevel)"
  worktree="$(basename "$cwd")"
  root="${worktree%%--*}"
  branch="$(git branch --show-current)"

  if [[ "$root" == "$worktree" ]]; then
    echo "gd: not in a <repo>--<branch> worktree directory"
    return 1
  fi

  if [[ -z "$branch" ]]; then
    echo "gd: unable to determine current branch"
    return 1
  fi

  if command -v gum >/dev/null 2>&1; then
    gum confirm "Remove worktree and branch?" || return 0
  else
    read -q "REPLY?Remove worktree and branch? [y/N] "
    echo
    [[ "$REPLY" == [Yy] ]] || return 0
  fi

  cd "$(dirname "$cwd")/$root" || return 1
  git worktree remove "$cwd" --force || return 1
  git branch -D "$branch"
}

bindkey -s '^f' '~/dotfiles/bin/tmux-sessionizer\n'
alias wsc='wt switch --create'
# opencode
export PATH=/Users/basrawi/.opencode/bin:$PATH
export PATH="$HOME/.local/bin:$PATH"

if command -v wt >/dev/null 2>&1; then eval "$(command wt config shell init zsh)"; fi

if [[ -o interactive && -f /Applications/WezTerm.app/Contents/Resources/wezterm.sh ]]; then
  source /Applications/WezTerm.app/Contents/Resources/wezterm.sh
fi
