{
  config,
  pkgs,
  ...
}: let
  settingsDir = ./settings;
  settingsFiles = builtins.readDir settingsDir;

  pluginsDir = ./plugins;
  pluginsFiles = builtins.readDir pluginsDir;

  pluginsNixFiles =
    builtins.filter
    (name: builtins.match ".*\\.nix" name != null)
    (builtins.attrNames pluginsFiles);
  pluginsFileImports = map (name: pluginsDir + "/${name}") pluginsNixFiles;
in {
  imports = pluginsFileImports;

  wayland.windowManager.hyprland = {
    enable = true;
    xwayland.enable = true;
    configType = "lua"; # Enables lua config

    settings = {
      monitor = ", 1920x1080@144, auto, 1";
    };
  };

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
    thunar-archive-plugin
    xarchiver
    rofi
  ];

  home.sessionVariables.NIXOS_OZONE_WL = "1";

  xdg.configFile = {
    "hypr/hyprland.lua".source = ./hyprland.lua;
    "hypr/variables.lua".source = ./variables.lua;
    "hypr/settings".source = ./settings;
    "hypr/scripts".source = ./scripts;

    "hypr/settings_init.lua".text = let
      luaFiles = builtins.filter (f: builtins.match ".*\\.lua" f != null) (builtins.attrNames settingsFiles);
      requires = map (f: "require(\"settings.${builtins.replaceStrings [".lua"] [""] f}\")") luaFiles;
    in
      "require(\"theme\")\n" + builtins.concatStringsSep "\n" requires;

    "hypr/.luarc.json".text = builtins.toJSON {
      workspace.library = [
        "${pkgs.hyprland}/share/hypr/stubs"
      ];
    };
  };
}
