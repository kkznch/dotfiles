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
      "k1LoW/tap/git-wt"
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
