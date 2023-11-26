{ conf, more-packages ? [] }:
{ config, pkgs, ... }:
let
  wm = conf.wm;
in
{
  /* The home.stateVersion option does not have a default and must be set */
  home.stateVersion = "22.05";

  home.packages = with pkgs; [
    firefox

    # ugh
    chromium

    # bsdgames
    # CRITICAL THREE
    fortune
    cowsay
    ponysay
    lispPackages.trivia
    lispPackages.quicklisp
    # lutris
    # mono5
    nethack
    # chezmoi
    # wineWowPackages.stable
    # winetricks
    # foliate
  #  thunderbird
    starship
    eza
    dmenu
    xsel
    manix
    shellcheck

    rlwrap
    # i like having easy access to a lot of repls
    deno
    ghc
    sbcl
    chez
    racket
    clojure

    cargo
    clippy
    rustc
    rustfmt

    idris2

    # emacs likes this
    semgrep

    discord
    steam
    rare
    # drm more like pooprm
    # might as well use a newer version
    #(itch.override {electron_11 = electron_22;})

    fzf
    kolourpaint
    audacious
    audacity

    akku
    # managing with elpas :(
    # emacsPackages.idris2-mode
    # emacsPackages.evil
    ripgrep
    tldr
    htop
    pv

    lm_sensors
    libnotify

    hunspell
    aspell
    libsForQt5.krunner-symbols

    mpv
    yt-dlp

    (nerdfonts.override { fonts = [ "JetBrainsMono" ]; })

    lmms
    helm

    #monaspace
    # glow and gum are a good example of something that should really be in a flake.nix or whatever
  ] ++ more-packages;

  programs.fish = {
    enable = true;

    shellInit = import ./fish.conf.nix;
  };

  programs.vscode = {
    enable = true;
    enableUpdateCheck = false;
    # i prefer to let vscode manage stuff
    mutableExtensionsDir = true;
    userSettings = (import ./vscode-settings.nix) { rust-analyzer = pkgs.rust-analyzer; };
  };

  programs.neovim = {
    enable = true;
    coc.enable = true;
    coc.settings = ''
    {
      "rust-analyzer.checkOnSave.command": "clippy",
      "rust-analyzer.checkOnSave.extraArgs": ["-- -W clippy::pedantic"],
      "languageserver": {
        "ccls": {
          "command": "ccls",
          "filetypes": ["c", "cpp", "objc", "objcpp"],
          "rootPatterns": [".ccls", "compile_commands.json", ".vim/", ".git/", ".hg/"],
          "initializationOptions": {
             "cache": {
               "directory": "/tmp/ccls"
             }
           }
        }
      },
      "inlayHint.enable": true,
      "zig.zls.path": "/home/mbk/.config/coc/extensions/coc-zls-data/zls_install/zls"
    }
    '';
    defaultEditor = true;
    # should probably extract this out but meh
    plugins = with pkgs.vimPlugins; [
      vim-airline
      vim-airline-themes
      ale

      vim-fugitive

      vim-bufkill

      suda-vim

      # navigation
      nerdtree
      nerdtree-git-plugin
      plenary-nvim
      telescope-nvim
      telescope-manix

      vim-rooter
      fzfWrapper
      # Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
      # Plug 'junegunn/fzf.vim'
      # Plug 'jlanzarotta/bufexplorer'

      vim-commentary
      #Plug 'mrtazz/DoxygenToolkit.vim'
      vim-surround
      vim-sexp

      vim-operator-user
      #Plug 'rhysd/vim-clang-format'

      #vim-scripts/a.vim
      vim-highlightedyank

      # Plug 'autozimu/LanguageClient-neovim', { 'branch': 'next', 'do': 'bash install.sh' }
      ncm2
      nvim-yarp

      # Completion plugins
      #Plug 'ncm2/ncm2-bufword'
      ncm2-path

      # CoC
      # Plug 'neoclide/coc.nvim', {'branch': 'release'}
      coc-sh
      coc-json

      haskell-vim

      # Syntactic language support
      rust-vim
      vim-toml
      elixir-tools-nvim
      #vim-rubocop
      zig-vim
      gruvbox
    ];
    extraConfig = import ./nvim.conf.nix;
  };

  programs.kitty = {
    enable = true;
    extraConfig = import ./kitty.conf.nix;
  };

  programs.git = {
    enable = true;
    userName = "mehbark";
    userEmail = "terezi@pyrope.net";
    extraConfig = {
      safe = {
      	directory = "*";
      };
    };
  };

  programs.git.difftastic = {
    enable = true;
    background = "dark";
  };

  xsession.windowManager.xmonad = if wm == "xmonad" then {
      enable = true;
      config = pkgs.writeText "xmonad.hs" ''
        import XMonad
        import XMonad.Config.Kde
        main = xmonad kde4Config
            { terminal    = "kitty"
            , modMask     = mod4Mask
            , borderWidth = 1
            }
      '';
  } else {};

  wayland.windowManager.hyprland = if wm == "hyprland"
  then {
    enable = true;
    enableNvidiaPatches = true;
    extraConfig = ''
    $mod = SUPER

    bind = $mod, F, exec, firefox
    bind = , Print, exec, grimblast copy area

    # workspaces
    # binds $mod + [shift +] {1..10} to [move to] workspace {1..10}
    ${builtins.concatStringsSep "\n" (builtins.genList (
        x: let
          ws = let
            c = (x + 1) / 10;
          in
            builtins.toString (x + 1 - (c * 10));
        in ''
          bind = $mod, ${ws}, workspace, ${toString (x + 1)}
          bind = $mod SHIFT, ${ws}, movetoworkspace, ${toString (x + 1)}
        ''
      )
      10)}

    # ...
  '';
  } else {};

  wayland.windowManager.sway = if wm == "sway"
  then {
    enable = true;
    config = rec {
      modifier = "Mod4";
      terminal = "kitty";
      startup = [
      ];
    };
  } else {};

  services.polybar = if wm == "i3"
  then {
    enable = true;
    script = "polybar bar &";
    settings = import ./polybar.conf.nix;
  } else {};

  xsession.windowManager.i3 = if wm == "i3"
  then {
     enable = true;
     extraConfig = import ./i3.conf.nix;
  } else {};

  programs.readline = {
    enable = true;
  };

  # services.emacs.client.enable = true;
  # not working right now
  programs.emacs = {
    enable = false;
    package = pkgs.emacs29;
    extraPackages = epkgs: with epkgs; [
      which-key
      emacs
      all-the-icons-ivy
      counsel
      gruvbox-theme
      lsp-mode
      avy
      consult
      embark
      embark-consult
      vertico
      #vertico-directory
      marginalia
      corfu
      #corfu-popupinfo
      corfu-terminal
      kind-icon
      #eshell
      orderless
      magit
      markdown-mode
      yaml-mode
      json-mode
      eglot
      org
      org
      org-roam
      paredit
      rainbow-delimiters
      geiser-chez
      macrostep-geiser
      evil
      evil-leader
      evil-goggles
      evil-surround
      evil-commentary
      evil-org
      erc-hl-nicks
    ];
    # apparently errors in the config matter? nvm?
    extraConfig = builtins.readFile ./init.el;
  };

  programs.direnv.enable = true;
  programs.direnv.nix-direnv.enable = true;
}
