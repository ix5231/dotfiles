{ config, pkgs, ... }:

{
  home = {
    stateVersion = "23.11";
    sessionVariables = {
      COLORTERM = "truecolor";
    };
  };
  programs = {
    home-manager.enable = true;
    helix = {
      enable = true;
      defaultEditor = true;
      settings = pkgs.lib.trivial.pipe ./config/helix/config.toml [builtins.readFile builtins.fromTOML];
      languages = pkgs.lib.trivial.pipe ./config/helix/languages.toml [builtins.readFile builtins.fromTOML];
    };
    fish.enable = true;
    git.enable = true;
  };
  xdg = {
    enable = true;
    # helix runtime dir
    configFile = {
      "helix/runtime" = {
        enable = true;
        source = ./config/helix/runtime;
        recursive = true;
      };
    };
  };
}
