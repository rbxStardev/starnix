{
  stdenvNoCC,
  fetchurl,
  steam-run,
  jdk,
}: let
  atlauncherVersion = "3.4.40.4";
in
  stdenvNoCC.mkDerivation {
    pname = "atlauncher-custom";
    version = atlauncherVersion;

    src = fetchurl {
      url = "https://github.com/ATLauncher/ATLauncher/releases/download/v${atlauncherVersion}/ATLauncher-${atlauncherVersion}.jar";
      hash = "sha256-G5CaXie+UreNJ+KRTsHfNcevj40cEjkNC/SK8ut6dkk=";
    };

    iconSrc = fetchurl {
      url = "https://raw.githubusercontent.com/ATLauncher/ATLauncher/master/src/main/resources/assets/image/icon.png";
      hash = "sha256-+1O8q0YdykaI0JNy5x53GXkRotLzVLY4PCAMpnB4txE=";
    };

    dontUnpack = true;

    installPhase = ''
      mkdir -p $out/bin
      mkdir -p $out/share/atlauncher
      mkdir -p $out/share/icons/hicolor/256x256/apps
      mkdir -p $out/share/applications

      cp $src $out/share/atlauncher/atlauncher.jar
      cp $iconSrc $out/share/icons/hicolor/256x256/apps/atlauncher.png

      cat > $out/share/applications/atlauncher.desktop << EOF
      [Desktop Entry]
      Name=ATLauncher Custom
      Exec=atlauncher
      Icon=atlauncher
      Type=Application
      Categories=Game;
      Comment=Custom Minecraft Launcher
      Terminal=false
      EOF

      cat > $out/bin/atlauncher << EOF
      #!/bin/sh
      export AT_DIR="\$HOME/.local/share/atlauncher"
      mkdir -p "\$AT_DIR"
      cd "\$AT_DIR"
      exec ${steam-run}/bin/steam-run ${jdk}/bin/java \
        -Duser.home="\$AT_DIR" \
        -jar "$out/share/atlauncher/atlauncher.jar" \
        --working-dir "\$AT_DIR" "\$@"
      EOF

      chmod +x $out/bin/atlauncher
    '';
  }
