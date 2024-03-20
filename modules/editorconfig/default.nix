{ lib, config, ... }:

let
  cfg = config.mymodules.editorconfig;
in with lib; {
  options.mymodules.editorconfig = {
    enable = mkEnableOption "mymodules.editorconfig";
  };

  config = mkIf cfg.enable {
    home.file.".editorconfig"  = {
      enable = true;
      source = ./editorconfig;
    };
  };
}
