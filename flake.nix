{
  description = "mehbark's NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";

    fh.url = "https://flakehub.com/f/DeterminateSystems/fh/*.tar.gz";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    flake-utils.url = "github:numtide/flake-utils";

    nixos-generators.url = "github:nix-community/nixos-generators";
    nixos-generators.inputs.nixpkgs.follows = "nixpkgs";

    hyprland.url = "github:hyprwm/Hyprland";

    pesterchum.url = "git+https://g.pyrope.net/pesterchum";
    pesterchum.inputs.nixpkgs.follows = "nixpkgs";

    # for l8r :::;)
    #homeage.url = "github:jordanisaacs/homeage";
    #homeage.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs@{
    self,
    nixpkgs,
    home-manager,
    flake-utils,
    nixos-generators,
    hyprland,
    fh,
    pesterchum,
    ...
  }:
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
        home-manager.users.mbk = (import ./home.nix) {
          inherit conf;
          more-packages = [
            pesterchum.packages.x86_64-linux.default
          ];
        };
      }
      {
        environment.systemPackages = [ fh.packages.x86_64-linux.default ];
      }
      # V evil V
      # (nixpkgs + "/nixos/modules/installer/cd-dvd/installation-cd-minimal.nix")
    ];
  in
  {
    nixosConfigurations =
    {
      nix = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        inherit modules;
        specialArgs = { inherit inputs; };
      };
    };

    homeConfigurations.mbk = home-manager.lib.homeManagerConfiguration {
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
