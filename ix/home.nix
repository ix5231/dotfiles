{ pkgs, ... }:

{
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
    };
    rofi.enable = true;
  };

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

  #systemd.user.services.onedrive = {
  #  Unit = {
  #    Description = "Onedrive";
  #  };

  #  Service = {
  #    Restart = "on-failure";
  #    RestartSec = 1;
  #    ExecStart = "${pkgs.onedrive}/bin/onedrive --monitor";
  #  };
  #};

  home.packages = with pkgs; [
    myNeovim git bspwm sxhkd firefox feh
    ipafont source-han-code-jp xorg.xbacklight ponymix spotify musescore
    wget texlive.combined.scheme-full xpdf
  ];
  home.sessionVariables.EDITOR = "nvim";
  programs.zsh.shellAliases = {
    ns = "nix-shell --command zsh";
    sudo = "sudo -E";
  };

  home.file = {
    ".config/bspwm/bspwmrc" = {
      text = builtins.readFile ./dots/bspwmrc;
      executable = true;
    };
    ".config/sxhkd/bspwm".text = builtins.readFile ./dots/sxhkdrc;
  };
}
