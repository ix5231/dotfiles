{ lib, config, ... }:

with lib;
{
  config = mkIf config.programs.neovim.enable {
    xdg = {
      enable = true;
      configFile = {
        "nvim" = {
          enable = true;
          source = ./config;
          recursive = true;
        };
      };
    };
  };
}
