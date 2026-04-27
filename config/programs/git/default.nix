{...}: {
  programs.git = {
    enable = true;
    settings = {
      user = {
        name = "rbxStardev";
        email = "miguelscb0310@gmail.com";
      };
      push.autoSetupRemote = true;
    };
  };

  programs.ssh = {
    enable = true;
    enableDefaultConfig = false;
    matchBlocks."*".addKeysToAgent = "yes";
  };
}
