args@{ config, pkgs, ... }:

{
  imports = [
    (
      import ./home.nix (args // { profile = ./profile/wsl1/home.nix; })
    )
  ];
}
