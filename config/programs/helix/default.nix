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
  ];

  programs.helix = {
    enable = true;

    settings = {
      theme = "noctalia";

      editor.cursor-shape = {
        insert = "bar";
        normal = "bar";
        select = "underline";
      };
    };

    languages.language = [
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
      qmlls = {
        command = "/etc/profiles/per-user/star/bin/qmlls";
        args = ["-E"];
      };
      csharp-ls = {
        command = "csharp-ls";
      };
      lemminx = {
        command = "lemminx";
      };
    };
  };
}
