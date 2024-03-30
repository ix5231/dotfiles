{
  description = "NixOS Config";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.11";
    wsl.url = "github:nix-community/NixOS-WSL/main";
    home-manager.url = "github:nix-community/home-manager/release-23.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs: {
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
    };
  };
}
