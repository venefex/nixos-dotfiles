{
  description = "NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    disko = {
      url = "github:nix-community/disko/latest";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # noctalia = {
    #   url = "github:noctalia-dev/noctalia";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };
  };

  outputs = inputs@{ self, nixpkgs, disko, home-manager, ... }: {
    nixosConfigurations.janus = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        ./configuration.nix
        disko.nixosModules.disko
        home-manager.nixosModules.home-manager
        {
          home-manager = {
            useGlobalPkgs = true;
            useUserPackages = true;
            users.alex = import ./home.nix;
            # backupFileExtension = "backup";
          };
        }

        # === Unfree packages configuration ===
        {
          nixpkgs.config.allowUnfreePredicate = pkg:
            builtins.elem (nixpkgs.lib.getName pkg) [
              "steam"
              "discord"
              "vscode"
              "jetbrains.rider"
              "jetbrains.clion"
            ];
        }
      ];
    };
  };
}
