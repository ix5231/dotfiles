{ pkgs, ... }:

{
  xsession.windowManager.command = "bspwm";
  home.packages = with pkgs; [ bspwm sxhkd ];
  xdg.configFile = {
    "bspwm/bspwmrc" = {
      source = ./dots/bspwm/bspwmrc;
      executable = true;
    };
    "sxhkd/bspwm".source = ./dots/bspwm/sxhkdrc;
  };
}
