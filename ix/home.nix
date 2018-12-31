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
      colorsExtra = builtins.readFile ./dots/template/termite_colors;
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

  services = {
    dunst.enable = true;
    compton = {
      enable = true;
      #blur = true;
    };
    polybar = {
      enable = true;
      config = {
        "bar/bottom" = {
          bottom = true;
          width = "100%:-20";
          height = 25;
          offset-x = 10;
          offset-y = 4;
          tray-position = "right";
          modules-center = "date battery";
          module-margin = 1;
          font-0 = "Source Han Code JP:weight=bold:size=12;3";
          background = "#282828";
          foreground = "#fbf1c7";
          fixed-center = true;
          border-size = 4;
          border-color = "#689D6A";
        };
        "module/date" = {
          type = "internal/date";
          interval = 30;
          date = "%Y-%m-%d";
          time = "%H:%M";
          label = "%date% %time%";
        };
        "module/battery" = {
          type = "internal/battery";
          full-at = 98;
          label-charging = "! %percentage%%";
        };
      };
      script = "polybar bottom &";
    };
  };

  xsession = {
    enable = true;
    windowManager.command = "bspwm";
    initExtra = "${./dots/battery_warn.sh} &";
  };

  nixpkgs.config = {
    allowUnfree = true;
    packageOverrides = with pkgs; {
      myNeovim = neovim.override {
        configure = {
          customRC = builtins.readFile ./dots/nvim/init.vim;
          packages.myVimPackage = with pkgs.vimPlugins; {
            start = [];
            opt = [];
          };
        };
      };
    };
  };

  home = {
    packages = with pkgs; [
      myNeovim git bspwm sxhkd firefox libnotify fzf llpp
      ipafont source-han-code-jp xorg.xbacklight ponymix spotify musescore
      wget texlive.combined.scheme-full shellcheck
    ];
    sessionVariables.EDITOR = "nvim";
    file.".latexmkrc".source = ./dots/latexmkrc;
  };

  xdg.configFile = {
    "bspwm/bspwmrc" = {
      source = ./dots/bspwm/bspwmrc;
      executable = true;
    };
    "sxhkd/bspwm".source = ./dots/bspwm/sxhkdrc;
    "nixpkgs/config.nix".text = "{ allowUnfree = true; }";
  };
}
