{...}: let
  vars = import ../variables.nix;
in {
  wayland.windowManager.hyprland.settings = {
    env = [
      # Themes
      "QT_QPA_PLATFORMTHEME, qt6ct"
      "QT_WAYLAND_DISABLE_WINDOWDECORATION, 1"
      "QT_AUTO_SCREEN_SCALE_FACTOR, 1"
      "XCURSOR_THEME, ${vars.cursorTheme}"
      "XCURSOR_SIZE, ${toString vars.cursorSize}"
      # Toolkit backends
      "GDK_BACKEND, wayland,x11"
      "QT_QPA_PLATFORM, wayland;xcb"
      "SDL_VIDEODRIVER, wayland,x11,windows"
      "CLUTTER_BACKEND, wayland"
      "ELECTRON_OZONE_PLATFORM_HINT, auto"
      # XDG
      "XDG_CURRENT_DESKTOP, Hyprland"
      "XDG_SESSION_TYPE, wayland"
      "XDG_SESSION_DESKTOP, Hyprland"
      # Others
      "_JAVA_AWT_WM_NONREPARENTING, 1"
    ];
  };
}
