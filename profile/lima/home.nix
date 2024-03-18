{ config, pkgs, ... }:

{
  imports = [ ../../home.nix ];

  home = {
    username = "lima";
  };
}