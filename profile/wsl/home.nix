{ config, pkgs, ... }:

{
  imports = [ ../../home.nix ];

  home = {
    packages = [ pkgs.nixd ];
    shellAliases = {
      update = "sudo nixos-rebuild switch --flake #wsl";
    };
  };
}
