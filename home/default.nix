{ config, lib, pkgs, ... }:
{
  home.stateVersion = "22.11";

  xdg.enable = true;

  fonts.fontconfig.enable = true;

  home.packages = with pkgs; [
    lazygit
    unstable.neovim-unwrapped
    shellcheck
    shfmt
    yamllint
    nodePackages.fixjson
    ripgrep
    kubectl
    wget
    tree-sitter
    jq
    fd
    nodejs
    unstable.terraform-ls
    nodePackages.yaml-language-server
    nodePackages.bash-language-server
    nodePackages.pyright
    black
    isort
    python311
    terraform
    tflint
    pylint
    python310Packages.pip
    (nerdfonts.override { fonts = [ "Meslo" ]; })
  ];

  home.sessionVariables = {
    LANG = "en_US.UTF-8";
    LC_CTYPE = "en_US.UTF-8";
    LC_ALL = "en_US.UTF-8";
    EDITOR = "nvim";
  };

  xdg.configFile."starship.toml".text = builtins.readFile ./config/starship.toml;
  xdg.configFile."wezterm/wezterm.lua".text = builtins.readFile ./config/wezterm.lua;
  xdg.configFile."lazygit/config.yml".text = builtins.readFile ./config/lazygit.yml;

  xdg.configFile."nvim" = {
    source = ./config/nvim;
    recursive = true;
  };

  programs = {

    git = {
      enable = true;
      userName = "Ivo Verberk";
      userEmail = "ivo.verberk@gmail.com";
      extraConfig = {
        branch.autosetuprebase = "always";
        color.ui = true;
        core.askPass = "";
        credential.helper = "store";
        github.user = "iverberk";
        push.default = "tracking";
        init.defaultBranch = "main";
      };
    };

    direnv = {
      enable = true;
      nix-direnv.enable = true;
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
      shellAliases = import ./config/aliases;
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
  };
}
