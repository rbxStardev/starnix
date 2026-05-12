{
  # ### Hyprland ###
  # Apps
  terminal = "ghostty";
  browser = "firefox";
  editor = "zeditor";
  fileExplorer = "thunar";

  # QuickshellConfig
  quickshellIpc = "noctalia-shell ipc call";

  # Touchpad
  touchpadDisableTyping = true;
  touchpadScrollFactor = 0.3;
  workspaceSwipeFingers = 4;
  gestureFingers = 3;
  gestureFingersMore = 4;

  # Blur
  blurEnabled = true;
  blurSpecialWs = false;
  blurPopups = true;
  blurInputMethods = true;
  blurSize = 3;
  blurPasses = 2;
  blurVibrancy = 0.1696;
  blurXray = false;

  # Shadow
  shadowEnabled = true;
  shadowRange = 4;
  shadowRenderPower = 3;

  # Gaps
  workspaceGaps = 20;
  windowGapsIn = 5;
  windowGapsOut = 10;
  singleWindowGapsOut = 10;

  # Window Styling
  windowOpacity = 0.95;
  windowRounding = 0;
  windowRoundingPower = 0;

  windowBorderSize = 1;

  # Misc
  volumeStep = 10; # In percent
  cursorTheme = "phinger-cursors-gruvbox-material";
  cursorSize = 24;

  # ### Keybinds ###
  # Workspaces
  kbMoveWinToWs = "Super+Alt";
  kbMoveWinToWsGroup = "Ctrl+Super+Alt";
  kbGoToWs = "Super";
  kbGoToWsGroup = "Ctrl+Super";

  kbNextWs = "Ctrl+Super, right";
  kbPrevWs = "Ctrl+Super, left";

  kbToggleSpecialWs = "Super, S";

  # Window Groups
  kbWindowGroupCycleNext = "Alt, Tab";
  kbWindowGroupCyclePrev = "Shift+Alt, Tab";
  kbUngroup = "Super, U";
  kbToggleGroup = "Super, Comma";

  # Window Actions
  kbMoveWindow = "Super, Z";
  kbResizeWindow = "Super, X";
  kbWindowPip = "Super+Alt, Backslash";
  kbPinWindow = "Super, P";
  kbWindowFullscreen = "Super, F";
  kbWindowBorderedFullscreen = "Super+Alt, F";
  kbToggleWindowFloating = "Super+Alt, Space";
  kbCloseWindow = "Super, Q";

  # Special Workspace Toggles
  kbSystemMonitor = "Ctrl+Shift, Escape";
  kbMusic = "Super, M";
  kbCommunication = "Super, D";
  kbTodo = "Super, R";

  # Apps
  kbTerminal = "Super, T";
  kbBrowser = "Super, W";
  kbEditor = "Super, C";
  kbFileExplorer = "Super, E";

  # Misc
  kbSession = "Ctrl+Alt, Delete";
  kbClearNotifs = "Ctrl+Alt, C";
  kbShowPanels = "Super, K";
  kbLock = "Super, L";
  kbRestoreLock = "Super+Alt, L";
  kbWallpaperPicker = "Super+Shift, W";
}
