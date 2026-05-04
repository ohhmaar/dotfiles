
[[ -f ~/.bash-preexec.sh ]] && source ~/.bash-preexec.sh
eval "$(atuin init bash)"

if command -v wt >/dev/null 2>&1; then eval "$(command wt config shell init bash)"; fi
