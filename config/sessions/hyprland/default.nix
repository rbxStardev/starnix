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

  # =========================================================
  # Mapeamento de Arquivos LUA usando caminhos relativos
  # =========================================================
  xdg.configFile = {
    # 1. Links diretos para os arquivos e pastas da sua árvore
    "hypr/hyprland.lua".source = ./hyprland.lua;
    "hypr/variables.lua".source = ./variables.lua;
    "hypr/settings".source = ./settings;
    "hypr/scripts".source = ./scripts;
    "hypr/plugins".source = ./plugins;

    # 2. Gerador do init.lua das configurações (agora em hypr/settings_init.lua)
    "hypr/settings_init.lua".text = let
      # Reaproveitamos a leitura de ./settings feita lá em cima
      luaFiles = builtins.filter (f: builtins.match ".*\\.lua" f != null) (builtins.attrNames settingsFiles);
      requires = map (f: "require(\"settings.${builtins.replaceStrings [".lua"] [""] f}\")") luaFiles;
    in
      "require(\"theme\")\n" + builtins.concatStringsSep "\n" requires;

    # 3. LSP para o editor reconhecer a API do Hyprland
    "hypr/.luarc.json".text = builtins.toJSON {
      workspace.library = [
        "${pkgs.hyprland}/share/hypr/stubs"
      ];
    };
  };
}
