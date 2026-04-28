# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).
{
  config,
  pkgs,
  ...
}: let
  atlauncherVersion = "3.4.40.4";
  atlauncherCustom = pkgs.stdenvNoCC.mkDerivation {
    pname = "atlauncher-custom";
    version = atlauncherVersion;

    src = pkgs.fetchurl {
      url = "https://github.com/ATLauncher/ATLauncher/releases/download/v${atlauncherVersion}/ATLauncher-${atlauncherVersion}.jar";
      hash = "sha256-G5CaXie+UreNJ+KRTsHfNcevj40cEjkNC/SK8ut6dkk=";
    };

    iconSrc = pkgs.fetchurl {
      url = "https://raw.githubusercontent.com/ATLauncher/ATLauncher/master/src/main/resources/assets/image/icon.png";
      hash = "sha256-+1O8q0YdykaI0JNy5x53GXkRotLzVLY4PCAMpnB4txE=";
    };

    dontUnpack = true;

    installPhase = ''
      mkdir -p $out/bin
      mkdir -p $out/share/atlauncher
      mkdir -p $out/share/icons/hicolor/256x256/apps
      mkdir -p $out/share/applications

      cp $src $out/share/atlauncher/atlauncher.jar
      cp $iconSrc $out/share/icons/hicolor/256x256/apps/atlauncher.png

      cat > $out/share/applications/atlauncher.desktop << EOF
      [Desktop Entry]
      Name=ATLauncher Custom
      Exec=atlauncher
      Icon=atlauncher
      Type=Application
      Categories=Game;
      Comment=Custom Minecraft Launcher
      Terminal=false
      EOF

      cat > $out/bin/atlauncher << EOF
      #!/bin/sh
      export AT_DIR="\$HOME/.local/share/atlauncher"
      mkdir -p "\$AT_DIR"
      cd "\$AT_DIR"
      exec ${pkgs.steam-run}/bin/steam-run ${pkgs.jdk}/bin/java \
        -Duser.home="\$AT_DIR" \
        -jar "$out/share/atlauncher/atlauncher.jar" \
        --working-dir "\$AT_DIR" "\$@"
      EOF

      chmod +x $out/bin/atlauncher
    '';
  };
in {
  # Imports
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
  ];

  home-manager.backupFileExtension = "backup";

  # System packages
  environment.systemPackages = with pkgs; [
    # Essential
    vim
    wget
    git

    # Sort this out later uh idk
    lemminx
    omnix

    playerctl
    jdk
    lua
    luajitPackages.luarocks
    curl
    lazygit
    tree-sitter
    stylua
    shfmt
    ripgrep
    fd
    unzip
    gnumake
    gcc
    cmake
    libnotify
    python3
    pywal
    pywalfox-native
    nwg-look
    adw-gtk3
    adwaita-icon-theme
    morewaita-icon-theme

    lact
    direnv
    nix-direnv
    inotify-tools

    # Development
    glfw
    assimp
    vulkan-loader
    vulkan-validation-layers
    vulkan-tools
    spirv-tools
    spirv-cross
    vcpkg

    # C# Development
    (dotnetCorePackages.combinePackages [
      dotnet-sdk_8
      dotnet-sdk_10
    ])
    roslyn-ls
    shader-slang

    # Showing off
    fastfetch
    tty-clock
    cbonsai
    unimatrix
    pipes
    btop

    # Basic File Handling
    mpv
    qimgv
    audacity

    # Video Thumbnails
    ffmpeg-headless
    ffmpegthumbnailer

    # Image Thumbnails
    gdk-pixbuf

    # Extra Thumbnals
    libheif.bin
    libheif.out
    libavif
    libjxl
    webp-pixbuf-loader
    f3d # 3d :0

    # Apps i use
    tmux
    tmate
    ghostty
    atlauncherCustom
    gitkraken
    zed-editor
    jetbrains.rider
    zapzap
    telegram-desktop
    obs-studio
    steam-run
    vesktop
    pear-desktop
    pavucontrol
    uget
    uget-integrator # for firefox
    sox # for audio
    nh

    # Custom SDDM Theme
    #sddm-personal
  ];

  environment.sessionVariables = {
    DOTNET_ROOT = "${pkgs.dotnet-sdk_10}/share/dotnet";

    QML_IMPORT_PATH = [
      "/etc/profiles/per-user/star/lib/qt-6/qml"
      "/run/current-system/sw/lib/qt-6/qml"
    ];
    QML2_IMPORT_PATH = [
      "/etc/profiles/per-user/star/lib/qt-6/qml"
      "/run/current-system/sw/lib/qt-6/qml"
    ];

    QT_IM_MODULE = "fcitx";
    XMODIFIERS = "@im=fcitx";

    GLFW_PATH = "${pkgs.glfw}/lib";
    ASSIMP_PATH = "${pkgs.assimp.lib}/lib";
    VULKAN_LAYER_PATH = "${pkgs.vulkan-validation-layers}/share/vulkan/explicit_layer.d";
  };

  environment.pathsToLink = ["/share/applications" "/share/thumbnailers"];

  # User accounts and security
  users.users.star = {
    isNormalUser = true;
    description = "Miguel";
    extraGroups = ["networkmanager" "wheel"];
    packages = [];
    useDefaultShell = true;
    shell = pkgs.zsh;
  };

  users.defaultUserShell = pkgs.zsh;
  system.userActivationScripts.zshrc = "touch -h .zshrc";

  # Program configurations
  programs.zsh.enable = true;
  programs.nix-ld.enable = true;
  services.supergfxd.enable = true;
  systemd.services.supergfxd.path = [pkgs.pciutils];
  services.asusd = {
    enable = true;
  };
  services.lact.enable = true;

  # Install firefox.
  programs.firefox = {
    enable = true;
    nativeMessagingHosts.packages = [pkgs.uget-integrator];
  };

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
  };
  programs.gamemode.enable = true;

  # Home manager
  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;

  home-manager.users.star = {
    imports = [./home.nix];
  };

  # Desktop environment, window managers and theme
  services.xserver.enable = true;

  services.displayManager.autoLogin = {
    enable = true;
    user = "star";
  };

  # Hyprland
  programs.hyprland = {
    enable = true;
    withUWSM = true;
  };

  # XDG Portals
  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-gtk
      xdg-desktop-portal-hyprland
    ];
    config = {
      hyprland.default = ["hyprland" "gtk"];
      common.default = ["gtk"];
    };
  };

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "br";
    variant = "";
  };

  i18n.inputMethod = {
    type = "fcitx5";
    enable = true;
    fcitx5.addons = with pkgs; [
      fcitx5-gtk
    ];
  };

  # Fonts
  fonts.packages = with pkgs; [
    udev-gothic-nf
    noto-fonts
    liberation_ttf
    nerd-fonts.jetbrains-mono
    nerd-fonts.fira-code
    nerd-fonts.hack
  ];

  fonts.fontconfig = {
    enable = true;
    hinting.style = "slight";
    subpixel.rgba = "rgb";
  };

  # Flatpak
  services.flatpak.enable = true;

  # Thumbnailing and yeah whatever
  services.gvfs.enable = true;
  services.tumbler.enable = true;

  #Environment variables

  # Networking and time
  networking.hostName = "machine";

  networking.networkmanager = {
    enable = true;
    wifi.powersave = false;
  };

  # Set your time zone.
  time.timeZone = "America/Bahia";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "pt_BR.UTF-8";
    LC_IDENTIFICATION = "pt_BR.UTF-8";
    LC_MEASUREMENT = "pt_BR.UTF-8";
    LC_MONETARY = "pt_BR.UTF-8";
    LC_NAME = "pt_BR.UTF-8";
    LC_NUMERIC = "pt_BR.UTF-8";
    LC_PAPER = "pt_BR.UTF-8";
    LC_TELEPHONE = "pt_BR.UTF-8";
    LC_TIME = "pt_BR.UTF-8";
  };

  # Audio and system services.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    wireplumber.enable = true;
  };
  services.blueman.enable = true;
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
  };
  hardware.i2c.enable = true;

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # Power Management Services
  services.power-profiles-daemon.enable = true;
  services.upower.enable = true;

  # Nix settings and maintenance
  nixpkgs.config.allowUnfree = true;

  nix.settings.experimental-features = ["nix-command" "flakes"];

  nix.settings.auto-optimise-store = true;

  nix.gc = {
    automatic = true;
    dates = "daily";
    options = "--delete-older-than 14d";
  };
  boot = {
    consoleLogLevel = 0;
    initrd.verbose = false;
    kernelParams = [
      "quiet"
      "splash"
      "loglevel=3"
      "rd.systemd.show_status=false"
      "rd.udev.log_level=3"
      "udev.log_priority=3"
      "amd_pstate=active"
      "asus_wmi"
    ];
  };

  # Bootloader and kernel
  boot.loader.limine.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.timeout = 0;

  # Kernel Packages and Optimization
  boot.kernelPackages = pkgs.linuxPackages_latest;
  hardware.cpu.amd.updateMicrocode = true;

  boot.kernelModules = ["tcp_bbr"]; # FIX: Network Congestion Control (Helps with packet jitter)
  boot.kernel.sysctl = {
    "net.ipv4.tcp_congestion_control" = "bbr";
    "net.core.default_qdisc" = "fq";
    "net.core.wmem_max" = 1073741824;
    "net.core.rmem_max" = 1073741824;
    "net.ipv4.tcp_rmem" = "4096 87380 1073741824";
    "net.ipv4.tcp_wmem" = "4096 87380 1073741824";
  };

  # ==========================================
  # GPU / GRAPHICS CONFIGURATION (ADDED)
  # ==========================================

  # Enable OpenGL/Vulkan (renamed to hardware.graphics in 24.11+)
  hardware.graphics = {
    enable = true;
    enable32Bit = true; # Required for steam/CS2
  };

  # Load NVIDIA Drivers
  services.xserver.videoDrivers = ["nvidia"];

  hardware.nvidia = {
    # Modesetting is required.
    modesetting.enable = true;

    # Nvidia power management. Experimental, and can cause sleep/suspend to fail.
    # Enable this if you have graphical corruption after suspend/wake.
    powerManagement.enable = false;

    # Fine-grained power management. Turns off GPU when not in use.
    # Experimental and only works on modern Nvidia GPUs (Turing or newer).
    powerManagement.finegrained = false;

    # Use the NVidia open source kernel module (not to be confused with the
    # independent third-party "nouveau" open source driver).
    # Support is limited to the Turing and later architectures.
    # We set to false here for maximum stability on the mobile 3050.
    open = false;

    # Enable the Nvidia settings menu,
    # accessible via `nvidia-settings`.
    nvidiaSettings = true;

    # Select the stable driver version
    package = config.boot.kernelPackages.nvidiaPackages.stable;
  };

  # Configure console keymap
  console.keyMap = "br-abnt2";

  system.stateVersion = "25.11";
}
