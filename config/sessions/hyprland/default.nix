{
  config,
  pkgs,
  ...
}: let
  settingsDir = ./settings;
  settingsFiles = builtins.readDir settingsDir;
  settingsNixFiles =
    builtins.filter
    (name: builtins.match ".*\\.nix" name != null)
    (builtins.attrNames settingsFiles);
  settingsFileImports = map (name: settingsDir + "/${name}") settingsNixFiles;

  pluginsDir = ./plugins;
  pluginsFiles = builtins.readDir pluginsDir;
  pluginsNixFiles =
    builtins.filter
    (name: builtins.match ".*\\.nix" name != null)
    (builtins.attrNames pluginsFiles);
  pluginsFileImports = map (name: pluginsDir + "/${name}") pluginsNixFiles;
in {
  imports = settingsFileImports ++ pluginsFileImports;

  wayland.windowManager.hyprland.enable = true;

  home.packages = with pkgs; [
    jq
    eza
    bat
    wl-clipboard
    qt6Packages.qt6ct
    qt6.qtbase
    qt6.qtmultimedia
    qt6.qt5compat
    qt6.qtsvg
    qt6.qtdeclarative
    qt5.qtimageformats
    quickshell
    cliphist
    awww
    brightnessctl
    hypridle
    thunar
    thunar
    thunar-archive-plugin
    xarchiver
    rofi
  ];

  wayland.windowManager.hyprland.settings = {
    monitor = ", 1920x1080@144, auto, 1";
  };

  home.sessionVariables.NIXOS_OZONE_WL = "1";
  home.file.".config/hypr/scripts".source =
    config.lib.file.mkOutOfStoreSymlink
    "${config.home.homeDirectory}/nix/config/sessions/hyprland/scripts";
}
