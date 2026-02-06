{ config, ... }:

let
  dotfilesDir = "${config.home.homeDirectory}/ghq/github.com/kkznch/dotfiles";
  privateDir = "${config.home.homeDirectory}/ghq/github.com/kkznch/dotfiles-private";
  privateExists = builtins.pathExists privateDir;
  mkOutOfStoreSymlink = config.lib.file.mkOutOfStoreSymlink;
in
{
  # Home directory files
  home.file = {
    ".zsh".source = config.lib.file.mkOutOfStoreSymlink "${dotfilesDir}/_zsh";
    ".zshrc".source = config.lib.file.mkOutOfStoreSymlink "${dotfilesDir}/_zshrc";
    ".editorconfig".source = config.lib.file.mkOutOfStoreSymlink "${dotfilesDir}/_editorconfig";

    # ~/.claude -> ~/.config/claude
    # ".claude".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.config/claude";

    # iCloud Drive shortcut
    "iCloudDrive".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/Library/Mobile Documents/com~apple~CloudDocs";

    # VS Code settings
    "Library/Application Support/Code/User/settings.json".source =
      config.lib.file.mkOutOfStoreSymlink "${dotfilesDir}/_app/vscode/settings.json";
    "Library/Application Support/Code/User/keybindings.json".source =
      config.lib.file.mkOutOfStoreSymlink "${dotfilesDir}/_app/vscode/keybindings.json";
  };

  # XDG config files (~/.config/*)
  # Note: ~/.config/nix is created by bootstrap.sh (not managed here)
  xdg.configFile = {
    "git".source = mkOutOfStoreSymlink "${dotfilesDir}/_config/git";
    "karabiner".source = mkOutOfStoreSymlink "${dotfilesDir}/_config/karabiner";
    "sheldon".source = mkOutOfStoreSymlink "${dotfilesDir}/_config/sheldon";
    "alacritty".source = mkOutOfStoreSymlink "${dotfilesDir}/_config/alacritty";
    "zellij".source = mkOutOfStoreSymlink "${dotfilesDir}/_config/zellij";
  } // (if privateExists then {
    # Private configs from dotfiles-private repository
    # Only linked if privateDir exists
    "alfred".source = mkOutOfStoreSymlink "${privateDir}/alfred";
    "claude/settings.json".source = mkOutOfStoreSymlink "${privateDir}/claude/settings.json";
    "claude/CLAUDE.md".source = mkOutOfStoreSymlink "${privateDir}/claude/CLAUDE.md";
  } else {});
}
