{ config, ... }:

let
  filesDir = "${config.home.homeDirectory}/ghq/github.com/kkznch/dotfiles/files";
  privateDir = "${config.home.homeDirectory}/ghq/github.com/kkznch/dotfiles-private";
  privateExists = builtins.pathExists privateDir;
  mkOutOfStoreSymlink = config.lib.file.mkOutOfStoreSymlink;
in
{
  # Home directory files
  home.file = {
    ".zshrc".source = mkOutOfStoreSymlink "${filesDir}/zshrc";
    ".editorconfig".source = mkOutOfStoreSymlink "${filesDir}/editorconfig";

    # iCloud Drive shortcut
    "iCloudDrive".source = mkOutOfStoreSymlink "${config.home.homeDirectory}/Library/Mobile Documents/com~apple~CloudDocs";

    # VS Code settings
    "Library/Application Support/Code/User/settings.json".source =
      mkOutOfStoreSymlink "${filesDir}/config/vscode/settings.json";
    "Library/Application Support/Code/User/keybindings.json".source =
      mkOutOfStoreSymlink "${filesDir}/config/vscode/keybindings.json";
  } // (if privateExists then {
    # Claude Code settings (~/.claude/*)
    ".claude/settings.json".source = mkOutOfStoreSymlink "${privateDir}/claude/settings.json";
    ".claude/CLAUDE.md".source = mkOutOfStoreSymlink "${privateDir}/claude/CLAUDE.md";
    ".claude/USER.md".source = mkOutOfStoreSymlink "${privateDir}/claude/USER.md";
    ".claude/skills".source = mkOutOfStoreSymlink "${privateDir}/claude/skills";
  } else {});

  # XDG config files (~/.config/*)
  # Note: ~/.config/nix is created by bootstrap.sh (not managed here)
  xdg.configFile = {
    "git".source = mkOutOfStoreSymlink "${filesDir}/config/git";
    "karabiner".source = mkOutOfStoreSymlink "${filesDir}/config/karabiner";
    "sheldon".source = mkOutOfStoreSymlink "${filesDir}/config/sheldon";
    "alacritty".source = mkOutOfStoreSymlink "${filesDir}/config/alacritty";
    "emacs".source = mkOutOfStoreSymlink "${filesDir}/config/emacs";
    "zsh".source = mkOutOfStoreSymlink "${filesDir}/config/zsh";
    "zellij".source = mkOutOfStoreSymlink "${filesDir}/config/zellij";
  } // (if privateExists then {
    "alfred".source = mkOutOfStoreSymlink "${privateDir}/alfred";
  } else {});
}
