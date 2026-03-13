{
  description = "Nixos Config";

  inputs = {
    nixpkgs-unstable.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-25.11";
    home-manager.url = "github:nix-community/home-manager/release-25.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    dotfiles.url = "path:./dotfiles";
    dotfiles.flake = false;
  };

  outputs = {self, nixpkgs, home-manager, dotfiles, ... }@attrs: {
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
              home-manager.extraSpecialArgs = { inherit dotfiles; };
            }
          ];
        };
      };
      homeConfigurations = {
        default = home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages.x86_64-linux;  # auto-detect?
          modules = [
            ./home/default.nix
            { _module.args.dotfiles = dotfiles; }
          ];
        };
      };
    };
}
