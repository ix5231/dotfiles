{ config, pkgs, profile, ... }:

{
  imports = [
    profile
    ./programs
    ./modules
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
    zsh.enable = true;
    git.enable = true;
    ripgrep.enable = true;
    neovim.enable = true;
    fzf = {
      enable = true;
      enableFishIntegration = true;
    };
  };
  mymodules = {
    editorconfig.enable = true;
  };
}
