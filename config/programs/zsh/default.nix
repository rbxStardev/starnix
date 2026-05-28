{
  config,
  pkgs,
  ...
}: {
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    history.size = 10000;
    history.path = "${config.home.homeDirectory}/.zsh_history";
    history.ignoreAllDups = true;
    initContent = builtins.readFile ./zsh-init.sh;
    shellAliases = {
      stop = "shutdown now";
      ls = "eza --icons --group-directories-first";
      l = "ls";
      ll = "eza -l --icons --group-directories-first";
      la = "eza -a --icons --group-directories-first";
      lla = "eza -la --icons --group-directories-first";
      cat = "bat";
    };

    plugins = [
      # {
      #   name = "zsh-notify";
      #   src = pkgs.fetchFromGitHub {
      #     owner = "marzocchi";
      #     repo = "zsh-notify";
      #     rev = "master";
      #     sha256 = "sha256-ovmnl+V1B7J/yav0ep4qVqlZOD3Ex8sfrkC92dXPLFI=";
      #   };
      #   file = "notify.plugin.zsh";
      # }
    ];

    oh-my-zsh = {
      enable = true;
      plugins = ["git"];
    };
  };

  home.packages = with pkgs; [libnotify xdotool wmctrl];

  home.sessionVariables = {
    hypr = "${config.home.homeDirectory}/nix/config/sessions/hyprland/";
    programs = "${config.home.homeDirectory}/nix/config/programs/";
  };
}
