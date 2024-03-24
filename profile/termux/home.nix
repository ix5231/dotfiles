{ config, pkgs, ... }:

{
  home = {
    username = "asakaze";
    homeDirectory = "/home/asakaze";
  };
  mymodules.meta.configRoot = "${config.home.homeDirectory}/nixos";
}
