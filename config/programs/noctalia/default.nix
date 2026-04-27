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

  programs.noctalia-shell.enable = true;

  home.packages = with pkgs; [
    grim
    imagemagick
    wl-clipboard
    satty
    wf-recorder
    wtype
    ddcutil
    upower
    bluez
    wlsunset
    xdg-desktop-portal
    evolution-data-server
  ];

  programs.noctalia-shell.settings = {
    settingsVersion = 0;
  };
  programs.noctalia-shell.plugins = {
    sources = [
      {
        enabled = true;
        name = "Official Noctalia Plugins";
        url = "https://github.com/noctalia-dev/noctalia-plugins";
      }
    ];

    version = 2;
  };

  home.file.".config/noctalia/templates".source =
    config.lib.file.mkOutOfStoreSymlink
    "${config.home.homeDirectory}/nix/config/programs/noctalia/templates";

  home.file.".config/noctalia/user-templates.toml".source =
    config.lib.file.mkOutOfStoreSymlink
    "${config.home.homeDirectory}/nix/config/programs/noctalia/user-templates.toml";
}
