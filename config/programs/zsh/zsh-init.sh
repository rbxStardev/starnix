setopt APPEND_HISTORY
setopt INC_APPEND_HISTORY
setopt SHARE_HISTORY

cd() {
  builtin cd $@ &&
    eza --icons --group-directories-first
}

function nix() {
  if [[ "$1" == "shell" ]]; then
    IN_NIX_SHELL=impure command nix "$@"
  else
    command nix "$@"
  fi
}

function slashes() {
  while true; do
    X=$((RANDOM % $(tput cols)))
    Y=$((RANDOM % $(tput lines)))
    tput cup $Y $X
    sleep 0.05
  done
}

# fastfetch
