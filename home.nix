{
  pkgs,
  inputs,
  ...
}: let
  # 1. Define the path to your programs directory
  programsDir = ./config/programs;

  # 2. Get the content of the directory
  files = builtins.readDir programsDir;

  # 3. Filter for directories only (ignoring regular files like .DS_Store or READMEs)
  directories =
    builtins.filter
    (name: files.${name} == "directory")
    (builtins.attrNames files);

  # 4. Map the directory names to import paths
  programImports = map (name: programsDir + "/${name}") directories;
in {
  imports =
    [
      # Sessions
      ./config/sessions/hyprland/default.nix
    ]
    ++ programImports;

  home.username = "star";
  home.homeDirectory = "/home/star";
  home.stateVersion = "25.11";

  home.sessionVariables = {
    EDITOR = "nvim";
  };

  home.pointerCursor = let
    getFrom = url: hash: name: {
      gtk.enable = true;
      x11.enable = true;
      name = name;
      size = 24;
      package = pkgs.runCommand "moveUp" {} ''
        mkdir -p $out/share/icons
        ln -s ${pkgs.fetchzip {
          url = url;
          hash = hash;
        }}/dist $out/share/icons/${name}
      '';
    };
  in
    getFrom
    "https://github.com/yeyushengfan258/ArcMidnight-Cursors/archive/refs/heads/main.zip"
    "sha256-VgOpt0rukW0+rSkLFoF9O0xO/qgwieAchAev1vjaqPE="
    "ArcMidnight-Cursors"; # <- O nome do tema do cursor

  qt = {
    enable = true;
    platformTheme.name = "qt6ct";
  };

  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      "inode/directory" = ["thunar.desktop"];
      "image/png" = ["qimgv.desktop"];
      "image/jpeg" = ["qimgv.desktop"];
      "application/pdf" = ["firefox.desktop"];
      "application/vnd.openxmlformats-officedocument.wordprocessingml.document" = ["firefox.desktop"];
      "audio/x-vorbis+ogg" = ["audacity.desktop"];
      "x-scheme-handler/tg" = ["org.telegram.desktop.desktop"];
      "x-scheme-handler/tonsite" = ["org.telegram.desktop.desktop"];
      "x-scheme-handler/discord" = ["vesktop.desktop"];
      "x-scheme-handler/jetbrains" = ["jetbrainsd.desktop"];
      "x-scheme-handler/http" = ["firefox.desktop"];
      "x-scheme-handler/https" = ["firefox.desktop"];
    };
  };

  xdg.configFile."xdg-desktop-portal/portals.conf".text = ''
    [preferred]
    default=hyprland;gtk
    org.freedesktop.impl.portal.OpenURI=gtk
    org.freedesktop.impl.portal.FileChooser=gtk
  '';

  programs.home-manager.enable = true;
  fonts.fontconfig.enable = true;
}
