{
  description = "Nixos Config";

  inputs = {
    nixpkgs-unstable.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-26.05";
    home-manager.url = "github:nix-community/home-manager/release-26.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    nix-darwin.url = "github:LnL7/nix-darwin/nix-darwin-26.05";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";

    dotfiles.url = "path:./dotfiles";
    dotfiles.flake = false;

    vim_seoul256.url = "github:junegunn/seoul256.vim?rev=d9a91d8d4e153274e1ecc0ceb05c37f0d0de84d7";
    vim_seoul256.flake = false;
    vim_fzf_vim.url = "github:junegunn/fzf.vim?rev=ddc14a6a5471147e2a38e6b32a7268282f669b0a";
    vim_fzf_vim.flake = false;
    vim_fzf.url = "github:junegunn/fzf?rev=2ab923f3ae04d5e915e5ff4a9cd3bd515bfd1ea5";
    vim_fzf.flake = false;
    vim_fugitive.url = "github:tpope/vim-fugitive?rev=61b51c09b7c9ce04e821f6cf76ea4f6f903e3cf4";
    vim_fugitive.flake = false;
    vim_vimtex.url = "github:lervag/vimtex?rev=2e1bbabeb2c34bb17d7bc8cfdf8f95b16dd0db0c";
    vim_vimtex.flake = false;
    vim_sleuth.url = "github:tpope/vim-sleuth?rev=be69bff86754b1aa5adcbb527d7fcd1635a84080";
    vim_sleuth.flake = false;

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
