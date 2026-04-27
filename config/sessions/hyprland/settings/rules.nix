{...}: let
  vars = import ../variables.nix;
in {
  wayland.windowManager.hyprland.settings = {
    # ######## Window rules ########
    windowrule = [
      "opacity ${toString vars.windowOpacity} override, match:fullscreen false"

      "opaque true, match:class foot|equibop|org\\.quickshell|imv|swappy" # They use native transparency or we want them opaque
      "center true, match:float true, match:xwayland false" # Center all floating windows (not xwayland cause popups)

      # Float
      "float true, match:class guifetch"
      "float true, match:class yad"
      "float true, match:class zenity"
      "float true, match:class wev"
      "float true, match:class org\\.gnome\\.FileRoller"
      "float true, match:class file-roller" # WHY IS THERE TWOOOOOOOOOOOOOOOO
      "float true, match:class blueman-manager"
      "float true, match:class com\\.github\\.GradienceTeam\\.Gradience"
      "float true, match:class feh"
      "float true, match:class imv"
      "float true, match:class system-config-printer"
      "float true, match:class org\\.quickshell"

      # Float, Resize and Center
      "float true, match:class ${vars.terminal}, match:title nmtui"
      "size 60% 70%, match:class ${vars.terminal}, match:title nmtui"
      "center 1, match:class ${vars.terminal}, match:title nmtui"

      "float true, match:class org\\.gnome\\.Settings"
      "size 70% 80%, match:class org\\.gnome\\.Settings"
      "center 1, match:class org\\.gnome\\.Settings"

      "float true, match:class org\\.pulseaudio\\.pavucontrol|yad-icon-browser"
      "size 60% 70%, match:class org\\.pulseaudio\\.pavucontrol|yad-icon-browser"
      "center 1, match:class org\\.pulseaudio\\.pavucontrol|yad-icon-browser"

      "float true, match:class nwg-look"
      "size 50% 60%, match:class nwg-look"
      "center 1, match:class nwg-look"

      # Special Workspaces
      "workspace special:sysmon, match:class btop"
      "workspace special:music, match:class feishin|Spotify|Supersonic|Cider|com.github.th_ch.youtube_music|Plexamp"
      "workspace special:music, match:initial_title Spotify( Free)?" # Spotify wayland, it has no class for some reason
      "workspace special:communication, match:class discord|equibop|vesktop|whatsapp"
      "workspace special:todo, match:class Todoist"

      # Dialogs
      "float true, match:title (Select|Open)( a)? (File|Folder)(s)?"
      "float true, match:title File (Operation|Upload)( Progress)?"
      "float true, match:title .* Properties"
      "float true, match:title Export Image as PNG"
      "float true, match:title GIMP Crash Debug"
      "float true, match:title Save As"
      "float true, match:title Library"

      # Picture In Picture (resize and move done via script)
      "move 100%-w-2% 100%-w-3%, match:title Picture(-| )in(-| )[Pp]icture" # Initial move so window doesn't shoot across the screen from the center
      "keep_aspect_ratio true, match:title Picture(-| )in(-| )[Pp]icture"
      "float true, match:title Picture(-| )in(-| )[Pp]icture"
      "pin true, match:title Picture(-| )in(-| )[Pp]icture"

      # Creative Software
      "opaque true, match:class krita|gimp|inkscape|darktable|resolve|kdenlive|shotcut|blender|godot"

      # Ueberzugpp
      "float true, match:class ^(ueberzugpp_.*)$"
      "no_initial_focus true, match:class ^(ueberzugpp_.*)$"

      # Steam
      "rounding 10, match:class steam"
      "float true, match:title Friends List, match:class steam"

      # Games (Steam, Lutris/Wine, Gamescope)
      "opaque true, match:class (steam_app_(default|[0-9]+))|gamescope"
      "immediate true, match:class (steam_app_(default|[0-9]+))|gamescope" # Allow tearing for games
      "idle_inhibit always, match:class (steam_app_(default|[0-9]+))|gamescope" # Always idle inhibit when playing a game

      # Minecraft Launcher Consoles
      "float true, match:class com-atlauncher-App, match:title ATLauncher Console"
      "float true, match:class PandoraLauncher, match:title Minecraft Game Output"

      # Autodesk Fusion 360
      "no_blur true, match:title Fusion360|(Marking Menu), match:class fusion360\\.exe"

      # Ugh xwayland Popups
      "no_dim true, match:xwayland 1, match:title win[0-9]+"
      "no_shadow true, match:xwayland 1, match:title win[0-9]+"
      "rounding 10, match:xwayland 1, match:title win[0-9]+"
    ];

    # ######## Workspace rules ########
    workspace = [
      "w[tv1]s[false], gapsout:${toString vars.singleWindowGapsOut}"
      "f[1]s[false], gapsout:${toString vars.singleWindowGapsOut}"
    ];

    # ######## Layer rules ########
    layerrule = [
      "animation fade, match:namespace hyprpicker" # Colour picker out animation
      "animation fade, match:namespace logout_dialog" # wlogout
      "animation fade, match:namespace selection" # slurp
      "animation fade, match:namespace wayfreeze"

      # Fuzzel
      "animation popin 80%, match:namespace launcher"
      "blur true, match:namespace launcher"

      # Noctalia
      "ignore_alpha 0.5, match:namespace noctalia-background-"
      "blur true, match:namespace noctalia-background-"
      "blur_popups true, match:namespace noctalia-background-"
      "no_anim true, match:namespace noctalia-shell:regionSelector"
    ];
  };
}
