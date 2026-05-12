{
  lib,
  stdenvNoCC,
  fetchurl,
}:
stdenvNoCC.mkDerivation {
  pname = "phinger-cursors-gruvbox-material";
  version = "3328966123";

  src = fetchurl {
    url = "https://github.com/rehanzo/phinger-cursors-gruvbox-material/releases/download/3328966123/phinger-cursors-variants.tar.bz2";
    hash = "sha256-qAEGY3B0tphEwYGfhkJ555yLgAu1nflCjqCOfZ8vjIE=";
  };

  dontUnpack = true;

  installPhase = ''
    mkdir -p $out/share/icons
    tar xfj $src -C $out/share/icons
  '';

  meta = {
    description = "Phinger cursors with Gruvbox Material theme";
    homepage = "https://github.com/rehanzo/phinger-cursors-gruvbox-material";
    license = lib.licenses.cc-by-sa-40;
    platforms = lib.platforms.linux;
  };
}
