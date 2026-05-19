{...}: let
  vars = import ../variables.nix;
in {
  wayland.windowManager.hyprland.settings = {
    env = [
      "XCURSOR_THEME, ${vars.cursorTheme}"
      "XCURSOR_SIZE, ${toString vars.cursorSize}"
      "HYPRCURSOR_THEME, ${vars.cursorTheme}"
      "HYPRCURSOR_SIZE, ${toString vars.cursorSize}"
    ];
  };
}
