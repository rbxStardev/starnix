{...}: let
  vars = import ../variables.nix;
in {
  wayland.windowManager.hyprland.settings = {
    general = {
      layout = "dwindle";

      allow_tearing = false; # Allows `immediate` window rule to work

      gaps_workspaces = vars.workspaceGaps;
      gaps_in = vars.windowGapsIn;
      gaps_out = vars.windowGapsOut;
      border_size = vars.windowBorderSize;
    };

    dwindle = {
      preserve_split = true;
      smart_split = false;
      smart_resizing = true;
    };
  };
}
