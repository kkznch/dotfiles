{ pkgs, ... }:

{
  home.packages = with pkgs; [
    # Add nix-managed CLI tools here
    # Most tools are managed by Homebrew for now (see darwin/homebrew.nix)
  ];
}
