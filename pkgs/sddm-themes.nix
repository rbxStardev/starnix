{
  stdenv,
  fetchFromGitHub,
  qt6Packages,
  theme ? "astronaut",
}:
stdenv.mkDerivation {
  pname = "sddm-astronaut-theme";
  version = "d73842c761f7d7859f3bdd80e4360f09180fad41";
  dontBuild = true;
  dontWrapQtApps = true;

  nativeBuildInputs = [qt6Packages.qtsvg qt6Packages.qtvirtualkeyboard qt6Packages.qtmultimedia];

  installPhase = ''
    mkdir -p $out/share/sddm/themes
    cp -aR $src $out/share/sddm/themes/sddm-astronaut-theme
    mkdir -p $out/share/fonts
    cp -r $src/Fonts/. $out/share/fonts

    chmod -R u+w $out/share/sddm/themes/sddm-astronaut-theme

    sed -i "s|ConfigFile=.*|ConfigFile=Themes/${theme}.conf|" \
      $out/share/sddm/themes/sddm-astronaut-theme/metadata.desktop
  '';

  src = fetchFromGitHub {
    owner = "Keyitdev";
    repo = "sddm-astronaut-theme";
    rev = "d73842c761f7d7859f3bdd80e4360f09180fad41";
    hash = "sha256-+94WVxOWfVhIEiVNWwnNBRmN+d1kbZCIF10Gjorea9M=";
  };
}
