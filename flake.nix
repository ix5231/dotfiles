{
  description = "NixOS Config";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.11";
    wsl.url = "github:nix-community/NixOS-WSL/main";
    home-manager.url = "github:nix-community/home-manager/release-23.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    home-manager-unstable.url = "github:nix-community/home-manager/master";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    home-manager-unstable.inputs.nixpkgs.follows = "nixpkgs-unstable";
  };

  outputs = { self, nixpkgs, home-manager, nixpkgs-unstable, home-manager-unstable, ... }@inputs: {
    nixosConfigurations = {
      wsl = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { wsl = inputs.wsl; profile = ./profile/wsl/nixos.nix; };
        modules = [
          ./nixos.nix
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.asakaze = import ./home.nix;
            home-manager.extraSpecialArgs = { profile = ./profile/wsl/home.nix; };
          }
        ];
      };
    };
    homeConfigurations = {
      termux = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.aarch64-linux;
        modules = [
          ./home.nix
        ];
        extraSpecialArgs = { profile = ./profile/termux/home.nix; };
      };

      lima = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.x86_64-linux;
        modules = [
          ./home.nix
        ];
        extraSpecialArgs = { profile = ./profile/lima/home.nix; };
      };

      wsl1 = home-manager-unstable.lib.homeManagerConfiguration {
        pkgs = nixpkgs-unstable.legacyPackages.x86_64-linux;
        modules = [
          ./home.nix
        ];
        extraSpecialArgs = { profile = ./profile/wsl1/home.nix; };
      };
    };
  };
}
