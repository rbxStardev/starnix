{pkgs, ...}: {
  home.packages = with pkgs; [
    nil
    nixd
    alejandra

    marksman

    csharp-ls
    csharpier
    netcoredbg

    lemminx

    bash-language-server
    shellcheck
    shfmt

    taplo

    glsl_analyzer

    lua-language-server
    stylua

    qt6Packages.qtdeclarative
  ];

  programs.helix = {
    enable = true;

    settings = {
      theme = "noctalia";

      editor = {
        bufferline = "multiple";
        color-modes = true;
        popup-border = "all";
        statusline = {
          left = ["mode" "spinner" "spacer" "version-control" "file-name" "file-modification-indicator"];
          center = [];
          right = ["diagnostics" "selections" "position" "file-type"];
          separator = "|";
          mode = {
            normal = "󰈈 NOR";
            insert = " INS";
            select = " SEL";
          };
          diagnostics = ["warning" "error"];
          workspace-diagnostics = ["warning" "error"];
        };
        cursor-shape = {
          insert = "bar";
          normal = "bar";
          select = "underline";
        };
        indent-guides = {
          render = true;
        };
      };
    };

    languages.language = [
      {
        name = "lua";
        auto-format = true;
        injection-regex = "lua";
        file-types = ["lua" "rockspec"];
        shebangs = ["lua" "luajit"];
        roots = [".luarc.json" ".luacheckrc" ".stylua.toml" "selene.toml"];
        comment-token = "--";
        block-comment-tokens = {
          start = "--[[";
          end = "--]]";
        };
        indent = {
          tab-width = 4;
          unit = "    ";
        };
        formatter = {
          command = "stylua";
          args = ["-"];
        };
        language-servers = ["lua-language-server"];
      }
      {
        name = "nix";
        auto-format = true;
        language-servers = ["nil" "nixd"];
        formatter = {
          command = "alejandra";
          args = ["--quiet" "--"];
        };
      }
      {
        name = "c-sharp";
        language-servers = ["csharp-ls"];
        formatter = {
          command = "csharpier";
          args = ["format" "--write-stdout"];
        };
        auto-format = true;
      }
      {
        name = "xml";
        language-servers = ["lemminx"];
        auto-format = true;
        file-types = [
          "xml"
          "xsd"
          "xsl"
          "xslt"
          "svg"
          "csproj"
          "config"
          "props"
          "targets"
          "task"
          {glob = "*.slnx";}
        ];
      }
    ];

    languages.language-server = {
      nixd = {
        command = "nixd";
        config = {
          nixd = {
            nixpkgs = {
              expr = "import <nixpkgs> {}";
            };
            options = {
              nixos = {
                expr = ''(builtins.getFlake "/home/star/NixOS").nixosConfigurations.machine.options'';
              };
              flake-parts = {
                expr = ''(builtins.getFlake "/home/star/NixOS").debug.options'';
              };
            };
          };
        };
      };
      qmlls = {
        command = "qmlls";
        args = ["-E"];
      };
      csharp-ls = {
        command = "csharp-ls";
      };
      lemminx = {
        command = "lemminx";
      };
      lua-language-server = {
        command = "lua-language-server";
        config = {
          Lua = {
            hint = {
              enable = true;
              arrayIndex = "Enable";
              setType = true;
              paramName = "All";
              paramType = true;
              await = true;
            };
          };
        };
      };
    };
  };
}
