{pkgs, ...}: {
  wayland.windowManager.hyprland = {
    plugins = [pkgs.hyprlandPlugins.hypr-dynamic-cursors];

    settings = {
      plugin = {
        dynamic-cursors = {
          enabled = true;

          mode = "stretch";
          stretch = {
            limit = 3000;
            function = "quadratic";
            window = 100;
          };
          shake = {
            enabled = false;
          };

          hyprcursor = {
            nearest = true;
            enabled = true;
            resolution = -1;
            fallback = "clientside";
          };
        };
      };
    };
  };
}
