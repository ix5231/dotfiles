{ config, pkgs, ... }:

{
  home = {
    packages = [ pkgs.nixd ];
    shellAliases = {
      update = "sudo nixos-rebuild switch --flake /home/asakaze/nixos#wsl";
    };
  };
}
