{
  description = "NixOS Development Environment";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/release-22.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    home-manager = {
      url = "github:nix-community/home-manager/release-22.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs: let
    user = "iverberk";
    overlays = [
      (final: prev: {
        unstable = inputs.nixpkgs-unstable.legacyPackages.${prev.system};
      })
    ];
  in {
    nixosConfigurations.vm-aarch64 = nixpkgs.lib.nixosSystem rec {
      system = "aarch64-linux";

      modules = [
        {
          nixpkgs.overlays = overlays;
        }

        ./hardware/vm-aarch64.nix
        ./machines/vm-aarch64.nix

        home-manager.nixosModules.home-manager {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.${user} = import ./users/${user}/home-manager.nix;
        }

        {
          config._module.args = {
            currentSystemName = "vm-aarch64";
            currentSystem = system;
          };
        }
      ];
    };
  };
}
