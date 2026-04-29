{pkgs, ...}: {
  home.packages = with pkgs; [
    nil
    nixd
    alejandra
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
    ];

    languages.language-server = {
      qmlls = {
        command = "/etc/profiles/per-user/star/bin/qmlls";
        args = ["-E"];
      };
    };
  };
}
