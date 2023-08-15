{ config, pkgs, ... }:
let
  conf = import ./build.conf.nix;
  wm = conf.wm;
in
{
  /* The home.stateVersion option does not have a default and must be set */
  home.stateVersion = "22.05";

  home.packages = with pkgs; [
    firefox
    clojure
    deno
    # bsdgames
    fortune
    cowsay
    git
    sbcl
    lispPackages.trivia
    # lutris
    # mono5
    nethack
    # chezmoi
    # wineWowPackages.stable
    # winetricks
    # foliate
  #  thunderbird
    starship
    exa
    ghc
    dmenu
  ];

  programs.fish = {
    enable = true;

    shellInit = import ./fish.conf.nix;
  };

  programs.vscode = {
    enable = true;
    enableUpdateCheck = false;
    # i prefer to let vscode manage stuff
    mutableExtensionsDir = true;
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

      vim-rooter
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
  } else {};

  # xsession.windowManager.i3 = if wm == "i3"
  # then {
  #   enable = true;

  # } else {};
}
