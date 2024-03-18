{ config, pkgs, ... }:

{
  imports = [ ../../home.nix ];

  home = {
    username = "lima";
    homeDirectory = "/home/lima.linux";
  };
}