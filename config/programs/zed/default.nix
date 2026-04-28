{
  pkgs,
  lib,
  ...
}: {
  programs.zed-editor = {
    enable = true;
    extensions = [
      "html"
      "csharp"
      "nix"
      "qml"
      "toml"
      "discord-presence"
      "xml"
      "tombi"
      "slang"
      "glsl"
    ];

    extraPackages = with pkgs; [nixd nil alejandra];

    userSettings = {
      theme = {
        mode = "dark";
        light = "Noctalia Light Transparent";
        dark = "Noctalia Dark Transparent";
      };

      ui_font_size = lib.mkForce 14;
      buffer_font_size = lib.mkForce 16;
      tab_bar = {
        show = true;
      };
      tabs = {
        show_diagnostics = "errors";
      };
      indent_guides = {
        enabled = true;
        coloring = "indent_aware";
      };
      inlay_hints = {
        enabled = true;
      };
      auto_install_extensions = true;
      outline_panel = {
        dock = "right";
      };
      collaboration_panel = {
        dock = "left";
      };
      notification_panel = {
        dock = "left";
      };

      auto_update = false;
      terminal = {
        alternate_scroll = "off";
        blinking = "off";
        copy_on_select = false;
        dock = "bottom";
        detect_venv = {
          on = {
            directories = [
              ".env"
              "env"
              ".venv"
              "venv"
            ];
            activate_script = "default";
          };
        };
        env = {
          EDITOR = "zeditor --wait";
          TERM = "ghostty";
        };
        font_family = "JetBrainsMono Nerd Font";
        font_features = null;
        line_height = "comfortable";
        option_as_meta = false;
        button = false;
        shell = "system";
        working_directory = "current_project_directory";
      };
      file_types = {
        JSON = [
          "json"
          "jsonc"
          "*.code-snippets"
        ];
        XML = [
          "xml"
          "axaml"
          "csproj"
          "props"
          "targets"
        ];
      };
      languages = {
        Markdown = {
          formatter = "prettier";
          format_on_save = "on";
        };
        JSON = {
          formatter = "prettier";
          format_on_save = "on";
        };
        TOML = {
          formatter = "language_server";
          format_on_save = "on";
        };
        XML = {
          formatter = "language_server";
          format_on_save = "on";
        };
        QML = {
          formatter = "language_server";
          format_on_save = "on";
        };
        Slang = {
          formatter = "language_server";
          format_on_save = "on";
        };
        Nix = {
          formatter = [
            {
              external = {
                command = "alejandra";
                arguments = ["--quiet" "--"];
              };
            }
          ];
          language_servers = ["nil" "nixd"];
          format_on_save = "on";
        };
      };

      lsp = {
        qmljs = {
          binary = {
            path = "/etc/profiles/per-user/star/bin/qmlls";
            arguments = ["-E"];
          };
        };
      };
    };
  };
}
