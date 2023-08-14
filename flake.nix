{
    inputs.nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    inputs.home-manager.url = "github:nix-community/home-manager";
    inputs.home-manager.inputs.nixpkgs.follows = "nixpkgs";

    outputs = {self, nixpkgs, home-manager }: {
        nixosConfigurations = nixpkgs.lib.nixosSystem {
            system = "x86_64-linux";
            modules = [
                ./configuration.nix
            ];
        }
    };
}
