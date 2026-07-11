{ config, pkgs, ... }:

{
  home.username = "alex";
  home.homeDirectory = "/home/alex";
  home.sessionVariables.NIXOS_OZONE_WL = "1";
  # wayland.windowManager.hyprland = {
  # 	enable = true;
  # 	package = null;
  # 	portalPackage = null;
  # 	systemd.enable = true;
  # 	systemd.variables = ["--all"];
  # 	extraConfig = builtins.readFile ./hyprland.lua;
  # };

  home.packages = with pkgs; [
    # mpv
    # fooyin
  ];

  xdg = {
    enable = true;
    userDirs = {
      enable = true;
      createDirectories = true;
      desktop = null;
    };
  };

  programs = {
    bash = {
      enable = true;
      shellAliases = {
        nrs = "sudo nixos-rebuild switch";
        nrsf = "sudo nixos-rebuild switch --flake .";
        cat = "bat";
      };
    };

    bat = {
      enable = true;
      config = {
        # TODO
      };
    };

    kitty = {
      enable = true;
    };

    git = {
      enable = true;
      # enableCompletion = true; not working
      settings = {
        user.name = "venefex";
        user.email = "git@alexdidom.com";
        init.defaultBranch = "main";
      };
    };

    tealdeer = {
      enable = true;
      settings = {
        updates.auto_update = true;
      };
    };

    yt-dlp = {
      enable = true;
      settings = {
        output = "~/Downloads/Videos/%(title)s.%(ext)s";
      };
    };

    neovim = {
      enable = true;
    };
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  home.stateVersion = "26.05";
}
