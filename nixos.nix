{ pkgs, profile, ... }:

{
  imports = [ profile ];

  programs.fish.enable = true;

  system.stateVersion = "23.11"; # Did you read the comment?

  users.users.asakaze = {
    isNormalUser  = true;
    home  = "/home/asakaze";
    extraGroups  = [ "wheel" ];
    hashedPassword = "$y$j9T$IxVv98/6EjhtFMQhcvBvi1$uIXySEoZDCVjBSFqxUH3aWzqum6cV6Ndmq./f3eycb/";
    shell = pkgs.fish;
  };

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
}
