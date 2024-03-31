{ pkgs, profile, ... }:

{
  imports = [ profile ];

  programs.zsh.enable = true;

  system.stateVersion = "23.11";

  users.users.asakaze = {
    isNormalUser  = true;
    home  = "/home/asakaze";
    extraGroups  = [ "wheel" ];
    hashedPassword = "$y$j9T$IxVv98/6EjhtFMQhcvBvi1$uIXySEoZDCVjBSFqxUH3aWzqum6cV6Ndmq./f3eycb/";
    shell = pkgs.zsh;
  };

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  time.timeZone = "Asia/Tokyo";
}
