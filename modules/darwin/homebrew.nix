{ ... }:

{
  homebrew = {
    enable = true;

    onActivation = {
      autoUpdate = true;
      cleanup = "uninstall"; # zap is too dangerous (deletes app data)
    };

    taps = [
      "k1LoW/tap"
    ];

    brews = [
      "mise"
      "emacs"
      "docker"
      "docker-buildx"
      "docker-compose"
      "k1LoW/tap/git-wt"
      "gh"
      "ghq"
      "gibo"
      "go"
      "jq"
      "mas"
      "pstree"
      "sheldon"
      "sk"
      "zellij"
    ];

    casks = [
      "1password"
      "alacritty"
      "claude-code"
      "alfred"
      "firefox"
      "font-hackgen-nerd"
      "google-chrome"
      "karabiner-elements"
      "logi-options+"
      "obsidian"
      "slack"
      "visual-studio-code"
    ];

    masApps = {
      "Kindle" = 302584613;
      "LINE" = 539883307;
    };
  };
}
