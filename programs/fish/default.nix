{ lib, config, ... }:

with lib;
{
  config = mkIf config.programs.fish.enable {
    programs.fish = {
      interactiveShellInit = builtins.readFile ./interactiveInit.fish;
    };
  };
}
