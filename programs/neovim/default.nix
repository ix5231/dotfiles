{ lib, config, ... }:

with lib;
let
  root = config.mymodules.meta.dotfiles;
  link = config.lib.file.mkOutOfStoreSymlink;
in {
    config = mkIf config.programs.neovim.enable {
      xdg = {
        enable = true;
        configFile = {
          "nvim/init.lua" = {
            enable = true;
            source = link "${root}/nvim/init.lua";
          };
        };
      };
    };
  }
