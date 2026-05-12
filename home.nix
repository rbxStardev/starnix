{
  pkgs,
  inputs,
  config,
  ...
}: let
  # 0. Get cursor package
  phinger-gruvbox = pkgs.callPackage ./pkgs/phinger-cursors-gruvbox-material.nix {};

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

  cursorConfig = {
    name = "phinger-cursors-gruvbox-material";
    size = 24;
    package = phinger-gruvbox;
  };
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
    EDITOR = "hx";
  };

  home.pointerCursor = {
    gtk.enable = true;
    x11.enable = true;
    inherit (cursorConfig) name size package;
  };

  qt = {
    enable = true;
    platformTheme.name = "qt6ct";
  };

  gtk = {
    enable = true;
  };

  services.mpd = {
    enable = true;
    musicDirectory = "${config.home.homeDirectory}/Music";
    extraConfig = ''
      audio_output {
        type "pipewire"
        name "PipeWire Output"
      }
    '';
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
