{ config, pkgs, ... }:

{
  mymodules.meta.configRoot = "${config.home.homeDirectory}/dotfiles";
  home = {
    packages = [ pkgs.nixd ];
    shellAliases = {
      update = "sudo nixos-rebuild switch --flake /home/asakaze/nixos#wsl";
    };
    username = "asakaze";
    homeDirectory = "/home/asakaze";
  };
  programs.git.extraConfig = {
    credential.helper = "/mnt/c/Program\\ Files/Git/mingw64/bin/git-credential-manager.exe";
  };
  programs.zsh.profileExtra = "if [ -e $HOME/.nix-profile/etc/profile.d/nix.sh ]; then . $HOME/.nix-profile/etc/profile.d/nix.sh; fi";
}
