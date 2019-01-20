# My config

{ config, pkgs, ... }:

let
  homeManager = builtins.fetchGit {
    url = "https://github.com/rycee/home-manager";
    ref = "release-18.09";
  };
  isUefi = builtins.pathExists /sys/firmware/efi;
in
{
  imports =
    [ # Include the results of the hardware scan.
      "${homeManager}/nixos"
      ./hardware-configuration.nix
      ./hardware-specific-conf.nix
    ];

  nixpkgs.config.allowUnfree = true;

  # Bootloader
  boot.loader = {
    efi.canTouchEfiVariables = isUefi;
    systemd-boot.enable = isUefi;
    grub.enable = !isUefi;
    grub.useOSProber = !isUefi;
  };

  networking.networkmanager.enable = true;

  i18n = {
    consoleFont = "Lat2-Terminus16";
    consoleKeyMap = "us";
    defaultLocale = "ja_JP.UTF-8";
    inputMethod = {
      enabled = "fcitx";
      fcitx.engines = with pkgs.fcitx-engines; [ mozc ];
    };
  };

  # Set your time zone.
  time.timeZone = "Asia/Tokyo";
  services = {
    timesyncd.servers = [ "ntp.nict.jp" "ntp.jst.mfeed.ad.jp" "s2csntp.miz.nao.ac.jp" ];
    xserver = {
      enable = true;
      layout = "us";
      displayManager = {
        auto = {
          enable = true;
          user = "ix";
        };
        sessionCommands = "${pkgs.numlockx}/bin/numlockx on";
      };
      libinput.enable = true;
    };
    openssh = {
      enable = true;
      passwordAuthentication = false;
      permitRootLogin = "no";
      authorizedKeysFiles = [ "/root/.ssh/authorized_keys" ];
    };
  };

  environment.systemPackages = with pkgs; [ fcitx-engines.mozc numlockx virtualbox ];

  # Enable sound.
  sound.enable = true;
  hardware.pulseaudio.enable = true;

  # Enable the X11 windowing system.
  virtualisation.virtualbox.host = {
    enable = true;
    enableExtensionPack = true;
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.ix = {
    isNormalUser = true;
    uid = 1000;
    extraGroups = [ "wheel" "networkmanager" ];
    shell = pkgs.fish;
  };
  home-manager.users.ix = import ./ix/home.nix;

  # This value determines the NixOS release with which your system is to be
  # compatible, in order to avoid breaking some software such as database
  # servers. You should change this only after NixOS release notes say you
  # should.
  system.stateVersion = "18.09"; # Did you read the comment?
}
