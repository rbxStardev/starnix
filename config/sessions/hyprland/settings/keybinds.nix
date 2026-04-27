{...}: let
  vars = import ../variables.nix;
  wsaction = "~/.config/hypr/scripts/wsaction.sh";
in {
  wayland.windowManager.hyprland.settings = {
    bindr = [
      # Shell Binds #
      # Launcher
      "Super, Super_L, exec, ${vars.quickshellIpc} launcher toggle"
    ];

    bind = [
      # Shell Binds #
      # Misc
      "${vars.kbSession}, exec, ${vars.quickshellIpc} sessionMenu toggle"
      "${vars.kbLock}, exec, ${vars.quickshellIpc} sessionMenu lock"

      # Utilities
      "${vars.kbWallpaperPicker}, exec, ${vars.quickshellIpc} plugin:wallcards toggle"
      ", Print, exec, ${vars.quickshellIpc} plugin:screen-shot-and-record screenshot"
      "Super+Shift, S, exec,${vars.quickshellIpc} plugin:screen-shot-and-record screenshot"
      "Super, V, exec, ${vars.quickshellIpc} plugin:clipper toggle"
      "Super, Period, exec, ${vars.quickshellIpc} launcher emoji"

      # Go To Workspace #
      "${vars.kbGoToWs}, 1, exec, ${wsaction} workspace 1"
      "${vars.kbGoToWs}, 2, exec, ${wsaction} workspace 2"
      "${vars.kbGoToWs}, 3, exec, ${wsaction} workspace 3"
      "${vars.kbGoToWs}, 4, exec, ${wsaction} workspace 4"
      "${vars.kbGoToWs}, 5, exec, ${wsaction} workspace 5"
      "${vars.kbGoToWs}, 6, exec, ${wsaction} workspace 6"
      "${vars.kbGoToWs}, 7, exec, ${wsaction} workspace 7"
      "${vars.kbGoToWs}, 8, exec, ${wsaction} workspace 8"
      "${vars.kbGoToWs}, 9, exec, ${wsaction} workspace 9"
      "${vars.kbGoToWs}, 0, exec, ${wsaction} workspace 10"
      # Go To Workspace -1/+1
      "Super, mouse_down, workspace, -1"
      "Super, mouse_up, workspace, +1"

      # Go To Workspace Group #
      "${vars.kbGoToWsGroup}, 1, exec, ${wsaction} -g workspace 1"
      "${vars.kbGoToWsGroup}, 2, exec, ${wsaction} -g workspace 2"
      "${vars.kbGoToWsGroup}, 3, exec, ${wsaction} -g workspace 3"
      "${vars.kbGoToWsGroup}, 4, exec, ${wsaction} -g workspace 4"
      "${vars.kbGoToWsGroup}, 5, exec, ${wsaction} -g workspace 5"
      "${vars.kbGoToWsGroup}, 6, exec, ${wsaction} -g workspace 6"
      "${vars.kbGoToWsGroup}, 7, exec, ${wsaction} -g workspace 7"
      "${vars.kbGoToWsGroup}, 8, exec, ${wsaction} -g workspace 8"
      "${vars.kbGoToWsGroup}, 9, exec, ${wsaction} -g workspace 9"
      "${vars.kbGoToWsGroup}, 0, exec, ${wsaction} -g workspace 10"
      # Go To Workspace Group -1/+1
      "Ctrl+Super, mouse_down, workspace, -10"
      "Ctrl+Super, mouse_up, workspace, +10"

      # Toggle Special Workspace #
      "${vars.kbToggleSpecialWs}, togglespecialworkspace, special"

      # Move Window To Workspace #
      "${vars.kbMoveWinToWs}, 1, exec, ${wsaction} movetoworkspace 1"
      "${vars.kbMoveWinToWs}, 2, exec, ${wsaction} movetoworkspace 2"
      "${vars.kbMoveWinToWs}, 3, exec, ${wsaction} movetoworkspace 3"
      "${vars.kbMoveWinToWs}, 4, exec, ${wsaction} movetoworkspace 4"
      "${vars.kbMoveWinToWs}, 5, exec, ${wsaction} movetoworkspace 5"
      "${vars.kbMoveWinToWs}, 6, exec, ${wsaction} movetoworkspace 6"
      "${vars.kbMoveWinToWs}, 7, exec, ${wsaction} movetoworkspace 7"
      "${vars.kbMoveWinToWs}, 8, exec, ${wsaction} movetoworkspace 8"
      "${vars.kbMoveWinToWs}, 9, exec, ${wsaction} movetoworkspace 9"
      "${vars.kbMoveWinToWs}, 0, exec, ${wsaction} movetoworkspace 10"
      # Move Window To Workspace -1/+1
      "Super+Alt, mouse_down, movetoworkspace, -1"
      "Super+Alt, mouse_up, movetoworkspace, +1"

      # Move Window To Workspace Group #
      "${vars.kbMoveWinToWsGroup}, 1, exec, ${wsaction} -g movetoworkspace 1"
      "${vars.kbMoveWinToWsGroup}, 2, exec, ${wsaction} -g movetoworkspace 2"
      "${vars.kbMoveWinToWsGroup}, 3, exec, ${wsaction} -g movetoworkspace 3"
      "${vars.kbMoveWinToWsGroup}, 4, exec, ${wsaction} -g movetoworkspace 4"
      "${vars.kbMoveWinToWsGroup}, 5, exec, ${wsaction} -g movetoworkspace 5"
      "${vars.kbMoveWinToWsGroup}, 6, exec, ${wsaction} -g movetoworkspace 6"
      "${vars.kbMoveWinToWsGroup}, 7, exec, ${wsaction} -g movetoworkspace 7"
      "${vars.kbMoveWinToWsGroup}, 8, exec, ${wsaction} -g movetoworkspace 8"
      "${vars.kbMoveWinToWsGroup}, 9, exec, ${wsaction} -g movetoworkspace 9"
      "${vars.kbMoveWinToWsGroup}, 0, exec, ${wsaction} -g movetoworkspace 10"

      # Move Window To/From Special Workspace #
      "Ctrl+Super+Shift, up, movetoworkspace, special"
      "Ctrl+Super+Shift, down, movetoworkspace, e+0"
      "Super+Alt, S, movetoworkspace, special"

      # Window Groups #
      "${vars.kbToggleGroup}, togglegroup"
      "${vars.kbUngroup}, moveoutofgroup"
      "Super+Shift, Comma, lockactivegroup, toggle"

      # Window Actions #
      "Super, left, movefocus, l"
      "Super, right, movefocus, r"
      "Super, up, movefocus, u"
      "Super, down, movefocus, d"
      "Super+Shift, left, movewindow, l"
      "Super+Shift, right, movewindow, r"
      "Super+Shift, up, movewindow, u"
      "Super+Shift, down, movewindow, d"
      "Ctrl+Super, Backslash, centerwindow, 1"
      "Ctrl+Super+Alt, Backslash, resizeactive, exact 55% 70%"
      "Ctrl+Super+Alt, Backslash, centerwindow, 1"
      "${vars.kbPinWindow}, pin"
      "${vars.kbWindowFullscreen}, fullscreen, 0"
      "${vars.kbWindowBorderedFullscreen}, fullscreen, 1"
      "${vars.kbToggleWindowFloating}, togglefloating,"
      "${vars.kbCloseWindow}, killactive,"

      # Special Workspace Toggles #
      "${vars.kbSystemMonitor}, togglespecialworkspace, sysmon"
      "${vars.kbMusic}, togglespecialworkspace, music"
      "${vars.kbCommunication}, togglespecialworkspace, communication"
      "${vars.kbTodo}, togglespecialworkspace, todo"

      # Apps #
      "${vars.kbTerminal}, exec, ${vars.terminal}"
      "${vars.kbBrowser}, exec, ${vars.browser}"
      "${vars.kbEditor}, exec, ${vars.editor}"
      "${vars.kbFileExplorer}, exec, ${vars.fileExplorer}"
    ];

    bindle = [
      ",XF86AudioRaiseVolume, exec, wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"
      ",XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
      ",XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
      ",XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"
    ];

    bindl = [
      # Shell #
      # Utilities

      # Misc
      "${vars.kbClearNotifs}, exec, ${vars.quickshellIpc} notifications clear"

      # Restore Lock
      "${vars.kbRestoreLock}, exec, noctalia-shell -d"
      "${vars.kbRestoreLock}, exec, ${vars.quickshellIpc} sessionMenu lock"

      # Brightness #
      ",XF86MonBrightnessUp, exec, ${vars.quickshellIpc} brightness increase"
      ",XF86MonBrightnessDown, exec, ${vars.quickshellIpc} brightness decrease"

      # Media
      "Ctrl+Super, Space, exec, ${vars.quickshellIpc} media toggle"
      ", XF86AudioPause, exec, ${vars.quickshellIpc} media toggle"
      ", XF86AudioPlay, exec, ${vars.quickshellIpc} media toggle"
      "Ctrl+Super, Equal, exec, ${vars.quickshellIpc} media next"
      ", XF86AudioNext, exec, ${vars.quickshellIpc} media next"
      "Ctrl+Super, Minus, exec, ${vars.quickshellIpc} media previous"
      ", XF86AudioPrev, exec, ${vars.quickshellIpc} media previous"
      ", XF86AudioStop, exec, ${vars.quickshellIpc} media stop"

      # Sleep #
      "Super+Shift, L, exec, systemctl suspend-then-hibernate"
    ];

    binde = [
      # Go To Workspace -1/+1
      "${vars.kbPrevWs}, workspace, -1"
      "${vars.kbNextWs}, workspace, +1"
      "Super, Page_Up, workspace, -1"
      "Super, Page_Down, workspace, +1"

      # Move Window To Workspace -1/+1
      "Super+Alt, Page_Up, movetoworkspace, -1"
      "Super+Alt, Page_Down, movetoworkspace, +1"
      "Ctrl+Super+Shift, right, movetoworkspace, +1"
      "Ctrl+Super+Shift, left, movetoworkspace, -1"

      # Window Groups
      "${vars.kbWindowGroupCycleNext}, cyclenext"
      "${vars.kbWindowGroupCyclePrev}, cyclenext, prev"
      "Ctrl+Alt, Tab, changegroupactive, f"
      "Ctrl+Shift+Alt, Tab, changegroupactive, b"

      # Window Actions
      "Super, Minus, resizeactive, -10% 0" # Resize Left
      "Super, Equal, resizeactive, 10% 0" # Resize Right
      "Super+Shift, Minus, resizeactive, 0 -10%" # Resize Up
      "Super+Shift, Equal, resizeactive, 0 10%" # Resize Down
      "Super+Alt, left, resizeactive, -10% 0"
      "Super+Alt, right, resizeactive, 10% 0"
      "Super+Alt, up, resizeactive, 0 -10%"
      "Super+Alt, down, resizeactive, 0 10%"
    ];

    bindm = [
      "Super, mouse:272, movewindow"
      "${vars.kbMoveWindow}, movewindow"
      "Super, mouse:273, resizewindow"
      "${vars.kbResizeWindow}, resizewindow"
    ];
  };
}
