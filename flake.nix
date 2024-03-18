{
  description = "NixOS Config";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    wsl.url = "github:nix-community/NixOS-WSL/main";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs: {
    nixosConfigurations = {
      wsl = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { wsl = inputs.wsl; };
        modules = [
          ./profile/wsl/nixos.nix
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.asakaze = import ./profile/wsl/home.nix;
          }
        ];
      };
    };
    homeConfigurations = {
      lima = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.x86_64-linux;
        modules = [
          ./profile/lima/home.nix
        ];
      };
    };
  };
}
