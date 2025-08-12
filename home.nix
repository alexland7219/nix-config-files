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
    userName = "NAME";
    userEmail = "EMAIL";
  };

  programs.alacritty = {
    enable = true;
    theme = "enfocado_dark";

    settings = {
      window = {
        padding = { x = 8; y = 8; };
        opacity = 0.9;
      };

      font = {
        size = 10.0;
        normal.family = "JetBrains Mono";
      };

    };
  };

  programs.bash = {
    enable = true;
    shellAliases = { "ls" = "ls -lAh --color=auto"; 
		     "h++" = "g++ -std=c++23 -O3 -Wall -Wextra -Wpedantic -Werror -march=native";
    };
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

  };
}
