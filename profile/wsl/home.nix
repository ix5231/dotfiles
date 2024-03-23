{ config, pkgs, ... }:

{
  mymodules.meta.configRoot = "${config.home.homeDirectory}/nixos";
  home = {
    packages = [ pkgs.nixd ];
    shellAliases = {
      update = "sudo nixos-rebuild switch --flake /home/asakaze/nixos#wsl";
    };
  };
  programs.git.extraConfig = {
    credential.helper = "/mnt/c/Program\\ Files/Git/mingw64/bin/git-credential-manager.exe";
  };
}
