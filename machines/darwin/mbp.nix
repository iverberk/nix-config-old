{ config, pkgs, ... }:
{
  # Enable and auto-update Nix Daemon
  services.nix-daemon.enable = true;

  # Install ZSH shell
  programs.zsh.enable = true;

  # Enable touch ID for sudo
  security.pam.enableSudoTouchIdAuth = true;

  # List view by default in Finder windows
  system.defaults.finder.FXPreferredViewStyle = "Nlsv";

  system.defaults.dock.autohide = true;

  # Increase key speed
  system.defaults.NSGlobalDomain.InitialKeyRepeat = 12;
  system.defaults.NSGlobalDomain.KeyRepeat = 1;
  system.defaults.NSGlobalDomain.ApplePressAndHoldEnabled = false;

  # Install Homebrew-managed packages
  homebrew = {
    enable = true;
    onActivation = {
      autoUpdate = true;
      upgrade = true;
      cleanup = "uninstall";
    };

    taps = [
      "homebrew/bundle"
      "homebrew/cask"
      "homebrew/cask-versions"
      "homebrew/core"
    ];

    brews = [];

    casks = [
      "teamviewer"
      "slack"
      "caffeine"
      "alfred"
      "docker"
      "drawio"
      "firefox"
      "istat-menus"
      "microsoft-auto-update"
      "microsoft-excel"
      "microsoft-outlook"
      "microsoft-teams"
      "onedrive"
      "rectangle"
      "spotify"
      "vmware-fusion"
      "whatsapp"
      "zoom"
      "openvpn-connect"
      "wezterm"
      "visual-studio-code"
      "dbeaver-community"
    ];
  };
}
