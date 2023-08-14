{ config, pkgs, ... }:
{
  /* The home.stateVersion option does not have a default and must be set */
  home.stateVersion = "22.05";

  home.packages = with pkgs; [
    firefox
    clojure
    deno
    kitty
    # bsdgames
    fortune
    cowsay
    git
    sbcl
    lispPackages.trivia
    # lutris
    # mono5
    nethack
    chezmoi
    # wineWowPackages.stable
    # winetricks
    # foliate
  #  thunderbird
    starship
    exa
  ];

  programs.fish = {
    enable = true;

    shellInit = import ./fish.conf.nix;
  };

  # programs.vscode = {
  #   enable = true;
  #   # i prefer to let vscode manage stuff
  #   mutableExtensionsDir = true;
  # };

  programs.neovim = {
    enable = true;
    coc.enable = true;
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
}
