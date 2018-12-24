{ pkgs, ... }:

{
  imports = [ ./hardware-specific-conf.nix ];

  programs = {
    home-manager = {
        enable = true;
        path = https://github.com/rycee/home-manager/archive/release-18.09.tar.gz;
    };
    termite = {
      enable = true;
      allowBold = true;
      font = "Source Han Code JP 10";
      backgroundColor = "#282828";
      foregroundColor = "#ebbdb2";
      colorsExtra = builtins.readFile ./dots/termite_colors;
    };
    zsh = {
      enable = true;
      oh-my-zsh = {
        enable = true;
        theme = "arrow";
      };
      shellAliases = {
        ns = "nix-shell --command zsh";
        sudo = "sudo -E";
      };
    };
    rofi.enable = true;
  };

  services.dunst.enable = true;

  xsession = {
    enable = true;
    windowManager.command = "bspwm";
  };

  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.packageOverrides = with pkgs; {
    myNeovim = neovim.override {
      configure = {
        customRC = builtins.readFile ./dots/init.vim;
        packages.myVimPackage = with pkgs.vimPlugins; {
          start = [];
          opt = [];
        };
      };
    };
  };

  home.packages = with pkgs; [
    myNeovim git bspwm sxhkd firefox libnotify fzf llpp
    ipafont source-han-code-jp xorg.xbacklight ponymix spotify musescore
    wget texlive.combined.scheme-full shellcheck
  ];
  home.sessionVariables.EDITOR = "nvim";

  xdg.configFile = {
    "bspwm/bspwmrc" = {
      source = ./dots/bspwmrc;
      executable = true;
    };
    "sxhkd/bspwm".source = ./dots/sxhkdrc;
  };
  home.file.".latexmkrc".source = ./dots/latexmkrc;
}
