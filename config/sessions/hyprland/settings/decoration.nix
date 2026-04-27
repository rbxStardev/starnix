{...}: let
  vars = import ../variables.nix;
in {
  wayland.windowManager.hyprland.settings = {
    decoration = {
      rounding = vars.windowRounding;
      rounding_power = vars.windowRoundingPower;

      blur = {
        enabled = vars.blurEnabled;
        xray = vars.blurXray;
        special = vars.blurSpecialWs;
        ignore_opacity = true; # Allows opacity blurring
        popups = vars.blurPopups;
        input_methods = vars.blurInputMethods;
        size = vars.blurSize;
        passes = vars.blurPasses;
        vibrancy = vars.blurVibrancy;
      };

      shadow = {
        enabled = vars.shadowEnabled;
        range = vars.shadowRange;
        render_power = vars.shadowRenderPower;
      };
    };
  };
}
