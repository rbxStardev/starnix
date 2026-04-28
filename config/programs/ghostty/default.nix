{config, ...}: {
  programs.ghostty = {
    enable = true;
    settings = {
      font-family = "JetBrainsMono Nerd Font";
      font-size = 12;
      background-opacity = 0.78;
      cursor-style = "block";
      cursor-style-blink = false;
      scrollback-limit = 10000;
      window-padding-x = 25;
      window-padding-y = 25;
      command = "tmux new-session -A -s main";
      custom-shader = "~/.config/ghostty/shaders/cursor_warp.glsl";
    };
  };

  home.file.".config/ghostty/shaders".source =
    config.lib.file.mkOutOfStoreSymlink
    "${config.home.homeDirectory}/nix/config/programs/ghostty/shaders";
}
