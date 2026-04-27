setopt APPEND_HISTORY
setopt INC_APPEND_HISTORY
setopt SHARE_HISTORY

cd() {
  builtin cd $@ &&
  eza --icons --group-directories-first
}

fastfetch
