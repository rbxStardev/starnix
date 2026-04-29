{
  pkgs,
  lib,
  ...
}: let
  discord-rpc-lsp = pkgs.buildGoModule {
    pname = "discord-rpc-lsp";
    version = "1.0.1";

    src = pkgs.fetchFromGitHub {
      owner = "zerootoad";
      repo = "discord-rpc-lsp";
      rev = "1.0.1";
      hash = "sha256-1Zw+F/EfYjHHU0AYlAHT7g1sbuJrHRtGp9E1u9EPW8E=";
    };

    proxyVendor = true;
    vendorHash = "sha256-ggeWQMfeQTb6bDwvA+N2Kt69ziVqGDPsJ1y5QCbSzMU=";
    preBuild = ''
      go mod download
    '';
  };
in {
  home.packages = with pkgs; [
    discord-rpc-lsp
  ];
}
