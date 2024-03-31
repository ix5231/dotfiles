{ lib, config, ... }:

with lib;
{
  config = mkIf config.programs.zsh.enable {
    programs.zsh = {
      initExtra = builtins.readFile ./config.zsh;
    };
  };
}
