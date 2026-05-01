{
  stdenv,
  fetchurl,
  mono,
  libusb1,
  unzip,
}:
stdenv.mkDerivation rec {
  pname = "hakchi2-ce";
  version = "3.9.3";
  src = fetchurl {
    url = "https://github.com/TeamShinkansen/hakchi2-ce/releases/download/v${version}/hakchi2-ce-${version}-portable.zip";
    hash = "sha256-RlIMi5o8dote58LLSHitwR49oYaarigQANdQErfp8SI=";
  };
  nativeBuildInputs = [unzip];
  unpackPhase = ''
    unzip -qq $src -d source || true
    chmod -R u+rw source
  '';
  sourceRoot = "source";
  dontConfigure = true;
  dontBuild = true;
  installPhase = ''
        runHook preInstall
        echo "Copying files to store..."
        mkdir -p $out/share/hakchi
        cp -rp . $out/share/hakchi
        echo "Creating launcher..."
        mkdir -p $out/bin
        cat > $out/bin/hakchi << EOF
    #!/bin/sh
    HAKCHI_HOME="\$HOME/.local/share/hakchi2-ce"
    if [ ! -f "\$HAKCHI_HOME/hakchi.exe" ]; then
      echo "First run: setting up hakchi2-ce in \$HAKCHI_HOME ..."
      mkdir -p "\$HAKCHI_HOME"
      cp -rp "$out/share/hakchi/." "\$HAKCHI_HOME/"
      chmod -R u+rw "\$HAKCHI_HOME"
    fi
    export LD_LIBRARY_PATH="${libusb1}/lib:\$LD_LIBRARY_PATH"
    exec ${mono}/bin/mono "\$HAKCHI_HOME/hakchi.exe" "\$@"
    EOF
        chmod +x $out/bin/hakchi

        echo "Creating desktop entry..."
        mkdir -p $out/share/applications
        cat > $out/share/applications/hakchi2-ce.desktop << EOF
    [Desktop Entry]
    Name=hakchi2 CE
    Comment=NES/SNES Classic Mini manager
    Exec=$out/bin/hakchi
    Icon=$out/share/hakchi/icon.ico
    Terminal=false
    Type=Application
    Categories=Utility;Emulator;
    EOF

        runHook postInstall
  '';
}
