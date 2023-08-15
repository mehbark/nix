{
  description = "mehbark's NixOS configuration";

  inputs.nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
  inputs.home-manager.url = "github:nix-community/home-manager";
  inputs.home-manager.inputs.nixpkgs.follows = "nixpkgs";
  inputs.hyprland.url = "github:hyprwm/Hyprland";

  outputs = inputs@{ self, nixpkgs, home-manager, hyprland, ... }: {
    nixosConfigurations = {
      nix = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./configuration.nix
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.mbk = import ./home.nix;
          }
        ];
      };
    };
    homeConfigurations."mbk@nix" = home-manager.lib.homeManagerConfiguration {
      pkgs = nixpkgs.legacyPackages.x86_64-linux;

      modules = [
        hyprland.homeManagerModules.default
        {wayland.windowManager.hyprland.enable = true;}
      ];
    };
  };
}
