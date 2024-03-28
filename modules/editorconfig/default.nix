{ lib, config, ... }:

with lib;

let
  cfg = config.mymodules.editorconfig;
  root = config.mymodules.meta.dotfiles;
  link = config.lib.file.mkOutOfStoreSymlink;
in {
    options.mymodules.editorconfig = {
      enable = mkEnableOption "";
    };
  
    config = mkIf cfg.enable {
      home.file.".editorconfig"  = {
        enable = true;
        source = link "${root}/editorconfig";
      };
    };
  }
