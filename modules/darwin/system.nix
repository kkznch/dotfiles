{ ... }:

{
  # macOS system settings (defaults write)
  system.defaults = {
    # Dock
    dock = {
      autohide = true;
      mru-spaces = false;
      show-recents = false;
      tilesize = 48;
    };

    # Finder
    finder = {
      AppleShowAllExtensions = true;
      FXEnableExtensionChangeWarning = false;
      NewWindowTarget = "PfHm";
      ShowPathbar = true;
    };

    # Trackpad
    trackpad = {
      Clicking = true;
      TrackpadRightClick = true;
      TrackpadRotate = false;
      TrackpadThreeFingerDrag = true;
      TrackpadThreeFingerTapGesture = 2;
      TrackpadTwoFingerDoubleTapGesture = false;
      TrackpadTwoFingerFromRightEdgeSwipeGesture = 0;
    };

    # Screenshot
    screencapture = {
      target = "clipboard";
    };

    # Window Manager
    WindowManager = {
      EnableStandardClickToShowDesktop = false;
      EnableTiledWindowMargins = false;
      StandardHideWidgets = true;
    };

    # Menu bar clock
    menuExtraClock = {
      ShowAMPM = true;
      ShowDayOfWeek = true;
    };

    # Global
    NSGlobalDomain = {
      AppleInterfaceStyle = "Dark";
      AppleShowAllExtensions = true;
      InitialKeyRepeat = 15;
      KeyRepeat = 2;
      NSAutomaticCapitalizationEnabled = false;
      NSAutomaticPeriodSubstitutionEnabled = false;
      NSAutomaticSpellingCorrectionEnabled = false;
      "com.apple.trackpad.forceClick" = false;
      "com.apple.trackpad.scaling" = 3.0;
    };

    # Settings not directly supported by nix-darwin modules
    CustomUserPreferences = {
      "com.apple.loginwindow" = {
        TALLogoutSavesState = false;
      };
      "com.apple.finder" = {
        ShowRecentTags = false;
      };
    };
  };

  # Keyboard settings
  system.keyboard = {
    enableKeyMapping = true;
    remapCapsLockToControl = true;
  };
}
