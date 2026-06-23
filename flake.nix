{
  description = "Nixos Config";

  inputs = {
    nixpkgs-unstable.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-25.11";
    home-manager.url = "github:nix-community/home-manager/release-25.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    nix-darwin.url = "github:LnL7/nix-darwin/nix-darwin-25.11";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";

    dotfiles.url = "path:./dotfiles";
    dotfiles.flake = false;

    wezterm.url = "github:wezterm/wezterm?dir=nix";

    agenix.url = "github:ryantm/agenix";
    agenix.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs @ {self, nixpkgs, home-manager, nix-darwin, ... }:{
      nixosConfigurations = {
        chocolatecarrot = nixpkgs.lib.nixosSystem {
          specialArgs = {inherit inputs;};
          pkgs = import nixpkgs {
            system = "x86_64-linux";
            config = {
              allowUnfree = true;
              allowUnfreePredicate = (_: true);
            };
          };
          modules = [
            inputs.agenix.nixosModules.default
            ./hosts/chocolatecarrot/configuration.nix
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs= true;
              home-manager.useUserPackages = true;
              home-manager.users.seabert = import ./hosts/chocolatecarrot/home.nix;
              home-manager.extraSpecialArgs = { inherit inputs; };
            }
          ];
        };
      };
      darwinConfigurations = {
        caramelapple = nix-darwin.lib.darwinSystem {
          modules = [
            home-manager.darwinModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.seabert = import ./hosts/caramelapple/home.nix;
              home-manager.extraSpecialArgs = { inherit inputs; };
            }
            ./hosts/caramelapple/configuration.nix
          ];
        };
      };
      homeConfigurations = {
        default = home-manager.lib.homeManagerConfiguration {
          pkgs = import nixpkgs {
            system = "x86_64-linux";
            config = {
              allowUnfree = true;
              allowUnfreePredicate = (_: true);
            };
          };
          modules = [
            ./home/default.nix
          ];
          extraSpecialArgs = { inherit inputs; };
        };
        gui = home-manager.lib.homeManagerConfiguration {
          pkgs = import nixpkgs {
            system = "x86_64-linux";
            config = {
              allowUnfree = true;
              allowUnfreePredicate = (_: true);
            };
          };
          modules = [
            ./home/gui.nix
            ./home/default.nix
          ];
          extraSpecialArgs = { inherit inputs; };
        };
      };
    };
}
