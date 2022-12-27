{
  description = "Nix Configurations";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/release-22.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    darwin = {
      url = "github:LnL7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager/release-22.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, nixpkgs-unstable, home-manager, darwin }: let
    username = "iverberk";

    # Add unstable packages
    overlays = [
      (final: prev: {
        unstable = nixpkgs-unstable.legacyPackages.${prev.system};
      })
    ];

    nixpkgsConfig = {
      overlays = overlays;
      config = {
        allowUnfree = true;
        allowUnsupportedSystem = true;
      };
    };

  in {
    darwinConfigurations.mbp = darwin.lib.darwinSystem {
      system = "aarch64-darwin";

      modules = [
        {
          nixpkgs = nixpkgsConfig;
        }

        ./machines/default.nix
        ./machines/darwin/mbp.nix

        home-manager.darwinModules.home-manager {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.${username} = import ./home/default.nix;
        }
      ];
    };

    homeConfigurations.${username} = home-manager.lib.homeManagerConfiguration {
      pkgs = nixpkgs.legacyPackages.x86_64-linux;

      modules = [
        {
          nixpkgs = nixpkgsConfig;
        }

        {
          home = {
            username = "${username}";
            homeDirectory = "/home/${username}";
          };

          programs.home-manager.enable = true;
          targets.genericLinux.enable = true;
        }

        ./home/default.nix
      ];
    };

    # nixosConfigurations.vm-aarch64 = nixpkgs.lib.nixosSystem rec {
    #   system = "aarch64-linux";

    #   modules = [
    #     {
    #       nixpkgs.overlays = overlays;
    #     }

    #     ./hardware/vm-aarch64.nix
    #     ./machines/vm-aarch64.nix

    #     home-manager.nixosModules.home-manager {
    #         home-manager.useGlobalPkgs = true;
    #         home-manager.useUserPackages = true;
    #         home-manager.users.${username} = import ./users/${username}/home-manager.nix;
    #     }

    #     {
    #       config._module.args = {
    #         currentSystemName = "vm-aarch64";
    #         currentSystem = system;
    #       };
    #     }
    #   ];
    # };
  };
}
