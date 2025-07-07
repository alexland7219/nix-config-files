{ config, pkgs, ... }:

{
  home.username = "alex";
  home.homeDirectory = "/home/alex";

  home.stateVersion = "24.05";

  xdg.userDirs = {
    enable = true;
    createDirectories = true;
  };

  programs.git = {
    enable = true;
    userName = "USERNAME";
    userEmail = "EMAIL";
  };

  programs.alacritty = {
    enable = true;

    settings = {
      window = {
        padding = { x = 8; y = 8; };
        opacity = 0.9;
      };

      font = {
        size = 9.0;
        normal.family = "JetBrains Mono";
      };

      colors = {
        primary = {
          background = "#1e1e2e";
          foreground = "#cdd6f4";
        };
      };
    };
  };

  programs.bash = {
    enable = true;
    shellAliases = { "ls" = "ls -lAh --color=auto"; };
  };

  dconf.settings = {
    "org/gnome/settings-daemon/plugins/media-keys" = {
      custom-keybindings = [
        "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/"
      ];
    };

    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0" = {
      name = "Launch Alacritty";
      command = "alacritty";
      binding = "<Super>Return";
    };

    "org/gnome/desktop/interface" = {
      "text-scaling-factor" = 0.9;
    };

  };
}
