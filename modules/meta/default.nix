{ lib, config, ... }:

with lib;

let
  cfg = config.mymodules.meta;
in {
    options.mymodules.meta = {
      configRoot = mkOption {
        type = types.str;
        default = "${config.home.homeDirectory}/nixos";
      };
    };
  }
