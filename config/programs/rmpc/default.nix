{
  config,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    rmpc
  ];

  xdg.configFile = {
    "rmpc/config.ron".source = ./config.ron;
    "rmpc/themes/gruvbox.ron".source = ./themes/gruvbox.ron;
  };
}
