{ pkgs, ... }:

{
  home.packages = with pkgs; [
    docker
    docker-buildx
    docker-compose
    emacs-nox
    gh
    ghq
    gibo
    go
    jq
    mas
    mise
    pstree
    rustup
    sheldon
    skim
    zellij
  ];
}
