{ pkgs, ... }:

{
  imports = [ ./hardware-specific-conf.nix
              ./bspwm.nix];

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
    tmux = {
      enable = true;
      extraConfig = builtins.readFile ./dots/tmux.conf;
      plugins = with pkgs; [
        tmuxPlugins.cpu
        {
          plugin = tmuxPlugins.resurrect;
          extraConfig = "set -g @resurrect-strategy-nvim 'session'";
        }
        {
          plugin = tmuxPlugins.continuum;
          extraConfig = ''
            set -g @continuum-restore 'on'
            set -g @continuum-save-interval '60' # minutes
          '';
        }
      ];
    };
  };

  services = {
    dunst = {
      enable = true;
      settings = {
        global = {
          padding = 7;
          horizontal_padding = 7;
          frame_width = 3;
          geometry = "400x0-20+20";
          font = "Source Han Code JP bold 10";
        };

        urgency_low  =  {
          background = "#282828";
          foreground = "#ebdbb2";
          frame_color = "#a89984";
        };

        urgency_normal  =  {
          background = "#282828";
          foreground = "#ebdbb2";
          frame_color = "#458588";
        };

        urgency_critical  =  {
          background = "#282828";
          foreground = "#fb4934";
          frame_color = "#cc241d";
        };
      };
    };
    compton.enable = true; 
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
          border-color = "#689d6a";
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
      myNeovim git firefox libnotify fzf llpp
      ipafont source-han-code-jp xorg.xbacklight ponymix spotify musescore
      wget texlive.combined.scheme-full shellcheck
    ];
    sessionVariables.EDITOR = "nvim";
    file.".latexmkrc".source = ./dots/latexmkrc;
  };

  xdg.configFile = {
    "nixpkgs/config.nix".text = "{ allowUnfree = true; }";
  };
}
