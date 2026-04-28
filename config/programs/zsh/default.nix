{config, ...}: {
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
      switch = "sudo nixos-rebuild switch --flake ${config.home.homeDirectory}/nix";
      stop = "shutdown now";

      ls = "eza --icons --group-directories-first";
      l = "ls";
      ll = "eza -l --icons --group-directories-first";
      la = "eza -a --icons --group-directories-first";
      lla = "eza -la --icons --group-directories-first";

      cat = "bat";
    };

    oh-my-zsh = {
      enable = true;
      plugins = [
        "git"
      ];
    };
  };

  home.sessionVariables = {
    hypr = "${config.home.homeDirectory}/nix/config/sessions/hyprland/";
    programs = "${config.home.homeDirectory}/nix/config/programs/";
  };
}
