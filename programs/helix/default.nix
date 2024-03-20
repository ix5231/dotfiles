{ lib, config, ... }:

with lib;
{
  config = mkIf config.programs.helix.enable {
    programs = {
      helix = {
        settings = trivial.pipe ./config/config.toml [builtins.readFile builtins.fromTOML];
        languages = trivial.pipe ./config/languages.toml [builtins.readFile builtins.fromTOML];
      };
    };
    xdg = {
      enable = true;
      # helix runtime dir
      configFile = {
        "helix/runtime" = {
          enable = true;
          source = ./config/runtime;
          recursive = true;
        };
      };
    };
  };
}
