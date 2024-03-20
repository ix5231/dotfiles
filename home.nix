{ config, pkgs, profile, ... }:

{
  imports = [
    profile
    ./programs
  ];

  home = {
    stateVersion = "23.11";
    sessionVariables = {
      COLORTERM = "truecolor";
    };
  };
  programs = {
    home-manager.enable = true;
    fish.enable = true;
    git.enable = true;
    ripgrep.enable = true;
    neovim.enable = true;
  };
}
