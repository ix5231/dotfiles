{ lib, config, ... }:

with lib;

let
  cfg = config.mymodules.editorconfig;
in {
    options.mymodules.editorconfig = {
      enable = mkEnableOption "";
    };
  
    config = mkIf cfg.enable {
      home.file.".editorconfig"  = {
        enable = true;
        source = ./editorconfig;
      };
    };
  }
