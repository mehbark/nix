{ conf, more-packages ? [], darwin ? false }:
{ config, pkgs, ... }:
let
  wm = conf.wm;
in
{
  home.stateVersion = "22.05";

  home.packages = with pkgs; [
    # bsdgames
    # CRITICAL THREE
    fortune
    cowsay
    ponysay
    # lutris
    # mono5
    nethack
    angband
    brogue-ce
    # cataclysm-dda
    # adom
    # not yet
    # celeste64

    starship
    eza
    dmenu
    watchexec
    wl-clipboard
    xsel
    manix
    shellcheck
    jq
    file
    fd
    zip
    semgrep
    pandoc

    rlwrap
    # i like having easy access to a lot of repls
    deno
    ghc
    ghcid
    cabal-install
    sbcl
    chez
    chicken
    guile
    gambit
    clojure
    ruby_3_3
    ruby-lsp
    elixir
    rubocop
    lua
    maxima
    zls

    # ocaml
    # ocamlPackages.utop
    # ocamlPackages.ocaml-lsp
    # ocamlPackages.ocamlformat

    idris2
    # might as well use it consistently
    haskell-language-server
    typst

    slipstream
    # drm more like pooprm
    # might as well use a newer version
    #(itch.override {electron_11 = electron_22;})

    fzf
    # yeah
    audacity
    ffmpeg
    libjxl
    exiftool
    gnupg

    akku
    ripgrep
    tldr
    htop
    pv
    helix
    numbat
    hyperfine

    libnotify

    hunspell
    aspell

    yt-dlp
    qbittorrent

    obsidian

    jetbrains-mono
    lmmath
    julia-mono
  ] ++ more-packages
    ++ (if darwin then [
         m-cli
         libiconvReal
         # (racket-minimal.overrideAttrs (finalAttrs: previousAttrs: {
         # configureFlags = [
         # "--enable-${previousAttrs.shared}"
         # "--enable-lt=${pkgs.libtool}/bin/libtool"
         # "--enable-macprefix"
         # ];
         # }))
         pkg-config
         rustup
         podman
        ] else [
         racket
         mpv
         gcc
         julia
         godot_4
         blender
         firefox
         chromium
         steam
         steam-run
         gamemode
         rare
         minigalaxy
         openrct2
         obs-studio
         kolourpaint
         audacious
         lm_sensors
         libsForQt5.krunner-symbols
         libsForQt5.khotkeys
         libsForQt5.kio
         helm
         cargo
         clippy
         rustc
         rustfmt
       ]);

  home.file = {
    ".config/kitty/kitty.app.png".source = pkgs.fetchurl {
      url = "https://raw.githubusercontent.com/samholmes/whiskers/main/whiskers.png";
      hash = "sha256-By6sRGNyK5Myk608crIO2vrnixZ0dJjoW26Y1I23Dto=";
    };
  };

  programs.fish = {
    enable = true;

    shellInit = import ./fish.conf.nix;
  };

  programs.zsh.enable = true;

  programs.vscode = {
    enable = true;
    enableUpdateCheck = false;
    # i prefer to let vscode manage stuff
    mutableExtensionsDir = true;
    userSettings = (import ./vscode-settings.nix) { inherit pkgs; };
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

      vim-suda

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
      vim-elixir

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
      core.autocrlf = false;
      init.defaultBranch = "main";
      user.signingkey = "8CD6E1438A00F55363157881E333EC1335FFCCDB";
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

  # services.emacs = {
  #   enable = true;
  #   client.enable = true;
  #   startWithUserSession = true;
  # };

  programs.emacs = {
    enable = true;
    package = pkgs.emacs30-pgtk;
    extraPackages = epkgs: with epkgs; [
      lsp-mode
      markdown-mode
      yaml-mode
      json-mode
      clojure-mode
      haskell-mode
      zig-mode
      python-mode

      treesit-grammars.with-all-grammars

      quack

      which-key
      all-the-icons-ivy
      bind-key
      counsel
      doom-themes
      paren-face
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
      org
      org-roam
      paredit
      rainbow-delimiters
      geiser-chez
      geiser-guile
      geiser-gambit
      geiser-racket
      macrostep-geiser
      evil
      evil-leader
      evil-goggles
      evil-surround
      evil-commentary
      evil-org
      erc-hl-nicks
      gcmh

      sly
      general
      lispyville

      cider

      direnv

      esup

      maxima
    ];
    # apparently errors in the config matter? nvm?
    extraConfig = (import ./init.el.nix) pkgs;
  };

  programs.direnv.enable = true;
  programs.direnv.nix-direnv.enable = true;

  programs.home-manager.enable = true;

  services.syncthing = {
    enable = true;
  };
}
