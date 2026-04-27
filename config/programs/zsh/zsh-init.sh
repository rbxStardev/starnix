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

fastfetch
