{...}: {
  programs.noctalia-shell.settings = {
    templates = {
      activeTemplates = [
        {
          id = "discord";
          enabled = true;
        }
        {
          id = "ghostty";
          enabled = true;
        }
        {
          id = "gtk";
          enabled = true;
        }
        {
          id = "qt";
          enabled = true;
        }
        {
          id = "zed";
          enabled = true;
        }
        {
          id = "pywalfox";
          enabled = true;
        }
        {
          id = "btop";
          enabled = true;
        }
        {
          id = "helix";
          enabled = true;
        }
      ];
      enableUserTheming = true;
    };
  };
}
