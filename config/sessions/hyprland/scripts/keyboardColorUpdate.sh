#!/usr/bin/env zsh

TARGET="$HOME/.config/keyboardColor.txt"

apply_color() {
    if [[ -f "$TARGET" ]]; then
        COLOR=$(cat "$TARGET")
        asusctl aura effect static --colour "$COLOR"
    fi
}

apply_color

inotifywait -m -e close_write "$TARGET" | while read -r directory events filename; do
    apply_color
done
