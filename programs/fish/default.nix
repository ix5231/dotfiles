{ lib, config, ... }:

with lib;
{
  config = mkIf config.programs.fish.enable {
    fish = {
      interactiveShellInit = builtin.readFile ./interactiveInit
    }
  };
}
