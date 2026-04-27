{...}: {
  wayland.windowManager.hyprland.settings = {
    misc = {
      vfr = true;
      vrr = 0;

      animate_manual_resizes = false;
      animate_mouse_windowdragging = false;

      disable_hyprland_logo = true;
      force_default_wallpaper = 0;

      on_focus_under_fullscreen = 2;
      allow_session_lock_restore = true;
      middle_click_paste = false;
      focus_on_activate = true;
      session_lock_xray = true;

      background_color = "rgb(1e1e2e)";
    };

    debug = {
      error_position = 1;
    };
  };
}
