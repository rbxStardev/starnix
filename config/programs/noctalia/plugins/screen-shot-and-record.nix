{...}: {
  programs.noctalia-shell.plugins.states.screen-shot-and-record = {
    enabled = true;
    sourceUrl = "https://github.com/noctalia-dev/noctalia-plugins";
  };

  programs.noctalia-shell.pluginSettings.screen-shot-and-record = {
    enableWindowsSelection = true;
    enableCross = true;
    screenshotEditor = "satty";
  };
}
