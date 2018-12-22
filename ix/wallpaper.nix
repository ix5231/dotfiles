{ config, lib, pkgs, ... }:

let
  cfg = config.services.wallpaper;
in

with lib;

{
  options = {
    services.wallpaper = {
      enable = mkEnableOption "wallpaper provived by feh";

      picture = mkOption {
        type = types.path;
      };
    };
  };

  config = mkIf cfg.enable {
    programs.feh.enable = true;

    systemd.user.services.wallpaper = {
	  Unit = {
		Description = "Showing wallpaper";
        After = [ "graphical-session-pre.target" ];
        PartOf = [ "graphical-session.target" ];
	  };

	  Install = {
		WantedBy = [ "graphical-session.target" ];
	  };

	  Service = {
		Type = "oneshot";
		ExecStart = "${pkgs.feh}/bin/feh --bg-scale ${cfg.picture}";
      };
    };
  };
}
