{...}: let
  vars = import ../variables.nix;
in {
  wayland.windowManager.hyprland.settings = {
    gestures = {
      workspace_swipe_distance = 700;
      workspace_swipe_cancel_ratio = 0.15;
      workspace_swipe_min_speed_to_force = 5;
      workspace_swipe_direction_lock = true;
      workspace_swipe_direction_lock_threshold = 10;
      workspace_swipe_create_new = true;
    };

    gesture = [
      "${toString vars.workspaceSwipeFingers}, horizontal, workspace"
      "${toString vars.gestureFingers}, up, special, special"
      "${toString vars.gestureFingers}, down, dispatcher, togglespecialworkspace, special"
      "${toString vars.gestureFingersMore}, down, dispatcher, exec, systemctl suspend-then-hibernate"
    ];
  };
}
