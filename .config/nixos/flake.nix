{
  description = "Nixos Config";

  inputs = {
    nixpkgs-unstable.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-24.11";
  };

  outputs = { self, nixpkgs, ... }@attrs: {
      nixosConfigurations.default = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit attrs;};
        modules = [
          ./hosts/chocolatecarrot/configuration.nix
          ];
      };
    };
}
