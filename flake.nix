{
  description = "Nixos Config";

  inputs = {
    nixpkgs-unstable.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-25.05";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = {self, nixpkgs, home-manager, ... }@attrs: {
      nixosConfigurations = {
        chocolatecarrot = nixpkgs.lib.nixosSystem {
          specialArgs = {inherit attrs;};
          pkgs = import nixpkgs {
            system = "x86_64-linux";
            config = {
              allowUnfree = true;
              allowUnfreePredicate = (_: true);
            };
          };
          modules = [
            ./hosts/chocolatecarrot/configuration.nix
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs= true;
              home-manager.useUserPackages = true;
              home-manager.users.seabert = import ./hosts/chocolatecarrot/home.nix;
            }
          ];
        };
      };
      homeConfigurations = {
        default = home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages.x86_64-linux;  # auto-detect?
          modules = [
            ./home/default.nix
          ];
        };
      };
    };
}
