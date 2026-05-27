{config, ...}: {
  programs.alacritty = {
    enable = true;
    settings = {
      font = {
        bold = {
          family = "JetBrainsMono Nerd Font";
          style = "Bold";
        };
        italic = {
          family = "JetBrainsMono Nerd Font";
          style = "Italic";
        };
        normal = {
          family = "JetBrainsMono Nerd Font";
          style = "Regular";
        };
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
