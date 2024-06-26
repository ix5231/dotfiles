{ lib, config, pkgs, ... }:

with lib;
{
  config = mkIf config.programs.zsh.enable {
    programs.zsh = {
      # initExtra = builtins.readFile ./config.zsh;
      plugins = [
        {
          name = "powerlevel10k";
          src = pkgs.zsh-powerlevel10k;
          file = "share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
        }
        {
          name = "powerlevel10k-config";
          src = ./p10k-config;
          file = "p10k.zsh";
        }
        {
          name = "escape-bind";
          src = ./escape-bind;
          file = "escape-bind.zsh";
        }
      ];
      profileExtra = "if [ -e $HOME/.nix-profile/etc/profile.d/nix.sh ]; then . $HOME/.nix-profile/etc/profile.d/nix.sh; fi";
    };
  };
}
