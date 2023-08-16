{
  description = "mehbark's NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    flake-utils.url = "github:numtide/flake-utils";

    nixos-generators.url = "github:nix-community/nixos-generators";
    nixos-generators.inputs.nixpkgs.follows = "nixpkgs";

    hyprland.url = "github:hyprwm/Hyprland";
  };

  outputs = inputs@{ self, nixpkgs, home-manager, flake-utils, nixos-generators, hyprland, ... }:
  let
    # :(
    # could do like nix-i3, nix-hyprland but that would be LAME
    conf = (import ./build.conf.nix) { wm = "plasma"; };
    modules = [
      ((import ./configuration.nix) conf)
      home-manager.nixosModules.home-manager
      {
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        home-manager.users.mbk = (import ./home.nix) conf;
      }
    ];
  in
  {
    nixosConfigurations =
    {
      nix = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = modules;
        specialArgs = { inherit inputs; };
      };
    };

    homeConfigurations."mbk@nix" = home-manager.lib.homeManagerConfiguration {
      pkgs = nixpkgs.legacyPackages.x86_64-linux;

      modules = if conf.wm == "hyprland" then modules ++ [
        hyprland.homeManagerModules.default
        {wayland.windowManager.hyprland.enable = true;}
      ] else modules;
    };

    # meh, doesn't rly work
    packages.x86_64-linux = {
      iso = nixos-generators.nixosGenerate {
        system = "x86_64-linux";
        modules = modules;
        format = "iso";
      };
    };
  };
}
