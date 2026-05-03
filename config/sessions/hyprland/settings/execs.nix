{...}: let
  vars = import ../variables.nix;
  keyboardColorUpdate = "~/.config/hypr/scripts/keyboardColorUpdate.sh";
in {
  wayland.windowManager.hyprland.settings = {
    exec-once = [
      "dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP"
      keyboardColorUpdate
      "noctalia-shell &"
      "wl-paste --type text --watch cliphist store"
      "wl-paste --type image --watch cliphist store"
    ];
  };
}
