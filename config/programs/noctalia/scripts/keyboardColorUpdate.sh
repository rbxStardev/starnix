#!/usr/bin/env zsh

TARGET="$HOME/.config/keyboardColor.txt"

if [[ -f "$TARGET" ]]; then
  COLOR=$(cat "$TARGET")
  asusctl aura effect static --colour "$COLOR"
fi
