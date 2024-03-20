{ config, lib, pkgs, wsl, ... }@attrs:

{
  imports = [
    wsl.nixosModules.default
  ];

  # FIXME: nixdに必要、不要になったら削除
  nixpkgs.config.permittedInsecurePackages = [
    "nix-2.16.2"
  ];

  wsl.enable = true;
  wsl.defaultUser = "asakaze";
}
