{ pkgs, inputs, ... }:
{
  system.stateVersion = 4;
  nixpkgs.hostPlatform = "aarch64-darwin";
  nixpkgs.config.allowUnfree = true;

  users.users.clark = {
    name = "clark";
    home = "/Users/clark";
  };

  home-manager.useUserPackages = true;
  home-manager.useGlobalPkgs = true;

  nix = {
    package = pkgs.nixVersions.stable;
    optimise.automatic = true;
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
    settings = {
        substituters = [
          "https://nix-community.cachix.org"
          "https://lean4.cachix.org"
        ];
        trusted-public-keys = [
          "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
          "lean4.cachix.org-1:mawtxSxcaiWE24xCXXgh3qnvlTkyU7evRRnGeAhD4Wk="
        ];
    };
  };

  environment.variables.EDITOR = "nvim";
  environment.variables.SHELL  = "fish";
  environment.variables.TERM   = "kitty";
  # BAD IDEA! I DON'T HAVE A CONCRETE REASON, MAINLY JUST VIBES
  # STILL MILES BETTER THAN NIX_AUTO_INSTALL THOUGH
  environment.variables.NIX_AUTO_RUN = "1";
}
