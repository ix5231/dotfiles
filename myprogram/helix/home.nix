{ config, pkgs, ... }:

{
  programs = {
    helix = {
      enable = true;
      settings = pkgs.lib.trivial.pipe ./config/config.toml [builtins.readFile builtins.fromTOML];
      languages = pkgs.lib.trivial.pipe ./config/languages.toml [builtins.readFile builtins.fromTOML];
    };
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
