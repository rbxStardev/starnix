{...}: {
  programs.noctalia-shell.settings = {
    notifications = {
      enabled = true;
      enableMarkdown = false;
      density = "default";
      monitors = [];
      location = "top_right";
      overlayLayer = true;
      backgroundOpacity = 1;
      respectExpireTimeout = false;
      lowUrgencyDuration = 3;
      normalUrgencyDuration = 8;
      criticalUrgencyDuration = 15;
      clearDismissed = true;
      saveToHistory = {
        low = true;
        normal = true;
        critical = true;
      };
      sounds = {
        enabled = true;
        volume = 0.5;
        separateSounds = true;
        criticalSoundFile = ./../assets/critical.mp3;
        normalSoundFile = ./../assets/normal.mp3;
        lowSoundFile = ./../assets/low.mp3;
        excludedApps = "discord,firefox,chrome,chromium,edge";
      };
      enableMediaToast = false;
      enableKeyboardLayoutToast = true;
      enableBatteryToast = true;
    };
    osd = {
      enabled = true;
      location = "top_right";
      autoHideMs = 2000;
      overlayLayer = true;
      backgroundOpacity = 1;
      enabledTypes = [
        0
        1
        2
      ];
      monitors = [];
    };
  };
}
