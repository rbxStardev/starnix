{config, ...}: {
  programs.alacritty = {
    enable = true;
    settings = {
      font = {
        normal.family = "JetBrainsMono Nerd Font";
        size = 12;
      };
      window = {
        opacity = 0.78;
      };
      cursor = {
        style = {
          shape = "Beam";
          blinking = "Never";
        };
      };
      scrolling.history = 10000;
    };
  };
}
