{...}: let
  vars = import ../variables.nix;
  keyboardColorUpdate = "~/.config/hypr/scripts/keyboardColorUpdate.sh";
in {
  wayland.windowManager.hyprland.settings = {
    exec-once = [
      keyboardColorUpdate
      "noctalia-shell &"
      "wl-paste --type text --watch cliphist store"
      "wl-paste --type image --watch cliphist store"
      "gsettings set org.gnome.desktop.interface cursor-theme ${vars.cursorTheme}"
      "gsettings set org.gnome.desktop.interface cursor-size ${toString vars.cursorSize}"
    ];
  };
}
