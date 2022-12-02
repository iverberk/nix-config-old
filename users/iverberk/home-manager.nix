{ config, lib, pkgs, ... }:
{
  home.stateVersion = "18.09";

  xdg.enable = true;

  fonts.fontconfig.enable = true;

  home.packages = [
    pkgs.firefox
    pkgs.rofi
    pkgs.unstable.neovim-unwrapped # Not managed with HM because of init conflict
    pkgs.unstable.gopls
    pkgs.unstable.terraform-ls
    pkgs.shellcheck
    pkgs.shfmt
    pkgs.yamllint
    pkgs.nodePackages.fixjson
    pkgs.ripgrep
    pkgs.gdb
  ];

  home.sessionVariables = {
    LANG = "en_US.UTF-8";
    LC_CTYPE = "en_US.UTF-8";
    LC_ALL = "en_US.UTF-8";
    EDITOR = "nvim";
    PAGER = "less -FirSwX";
    MANPAGER = "sh -c 'col -bx | ${pkgs.bat}/bin/bat -l man -p'";
  };

  xresources.extraConfig = builtins.readFile ./Xresources;

  xdg.configFile."rofi/config.rasi".text = builtins.readFile ./rofi;
  xdg.configFile."i3/config".text = builtins.readFile ./i3;
  xdg.configFile."starship.toml".text = builtins.readFile ./starship.toml;
  xdg.configFile."kitty" = {
    source = ./kitty;
    recursive = true;
  };

  xdg.configFile."nvim" = {
    source = ./nvim;
    recursive = true;
  };

  home.pointerCursor = {
    name = "Vanilla-DMZ";
    package = pkgs.vanilla-dmz;
    size = 128;
    x11.enable = true;
  };

  programs = {

    git = {
      enable = true;
      userName = "Ivo Verberk";
      userEmail = "ivo.verberk@gmail.com";
      # signing = {
      #   key = "523D5DC389D273BC";
      #   signByDefault = true;
      # };
      extraConfig = {
        branch.autosetuprebase = "always";
        color.ui = true;
        core.askPass = ""; # needs to be empty to use terminal for ask pass
        credential.helper = "store"; # want to make this more secure
        github.user = "iverberk";
        push.default = "tracking";
        init.defaultBranch = "main";
      };
    };

    lazygit = {
      enable = true;
      settings = {
        quitOnTopLevelReturn = true;
        keybinding = {
          universal = {
            nextBlock = "<c-j>";
            prevBlock = "<c-k>";
          };
          commits = {
            moveDownCommit = "j";
            moveUpCommit = "k";
          };
        };
      };
    };

    go = {
      enable = true;
      goPath = "code/go";
    };

    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };

    vscode = {
      enable = true;

      extensions = with pkgs.vscode-extensions; [

      ];

      userSettings = {
        "window.titleBarStyle" = "custom"; # Get rid of the system title bar
      };
    };

    starship = {
      enable = true;
      settings = {};
    };

    zsh = {
      enable = true;
      enableAutosuggestions = true;
      enableCompletion = true;
      enableSyntaxHighlighting = true;
      shellAliases = import ./aliases;
      cdpath = [ "~/code/iverberk" "~/code" ];
      history = {
        ignoreDups = true;
        save = 100000;
        size = 100000;
      };
      initExtraBeforeCompInit = ''
        mkdir -p ~/code/{github.com,go} ~/scratch
        export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=#757575'

        bindkey '^[[A' history-substring-search-up
        bindkey '^[[B' history-substring-search-down
      '';
      zplug = {
        enable = true;
        plugins = [
          { name = "zsh-users/zsh-history-substring-search"; tags = [ defer:3 ]; }
          { name = "chriskempson/base16-shell"; tags = [ use:scripts/base16-tomorrow-night-eighties.sh defer:0 ]; }
        ];
      };
    };

    kitty = {
      enable = true;
      extraConfig = builtins.readFile ./kitty/kitty.conf;
      font.name = "Meslo";
      font.package = (pkgs.nerdfonts.override { fonts = [ "Meslo" ]; });
    };

    i3status = {
      enable = true;

      general = {
        colors = true;
        color_good = "#8C9440";
        color_bad = "#A54242";
        color_degraded = "#DE935F";
      };

      modules = {
        ipv6.enable = false;
        "wireless _first_".enable = false;
        "battery all".enable = false;
      };
    };
  };
}
