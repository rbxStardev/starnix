{...}: {
  programs.ghostty = {
    enable = true;
    settings = {
      font-family = "JetBrainsMono Nerd Font";
      font-size = 12;
      background-opacity = 0.78;
      cursor-style = "bar";
      cursor-style-blink = false;
      scrollback-limit = 10000;
      window-padding-x = 25;
      window-padding-y = 25;
      command = "tmux new-session -A -s main";
    };
  };
}
