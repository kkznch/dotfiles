{ pkgs, username, ... }:

{
  imports = [
    ./links.nix
    ./packages.nix
  ];

  home = {
    username = username;
    homeDirectory = "/Users/${username}";
    stateVersion = "24.05";

  };

  # Let home-manager manage itself
  programs.home-manager.enable = true;
}
