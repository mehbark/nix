{
  description = "mehbark's NixOS configuration";

  inputs.nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
  inputs.home-manager.url = "github:nix-community/home-manager";
  inputs.home-manager.inputs.nixpkgs.follows = "nixpkgs";
  inputs.flake-utils.url = "github:numtide/flake-utils";
  inputs.nixos-generators.url = "github:nix-community/nixos-generators";
  inputs.nixos-generators.inputs.nixpkgs.follows = "nixpkgs";

  outputs = inputs@{ self, nixpkgs, home-manager, flake-utils, nixos-generators, ... }:
  let
    # :(
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
      };
    };

    packages.x86_64-linux = {
      iso = nixos-generators.nixosGenerate {
        system = "x86_64-linux";
        modules = modules;
        format = "iso";
      };
    };
  };
}
