{
  description = "One flake to rule them all!";
  inputs = {
    nixpkgs = {
      url = "nixpkgs/nixos-unstable";
      # url = "github:NixOS/nixpkgs/2d0720da19a2";
    };

    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    noctalia = {
      url = "github:noctalia-dev/noctalia-shell";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    rust-overlay = {
      url = "github:oxalica/rust-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs = inputs @ {
    self,
    nixpkgs,
    home-manager,
    noctalia,
    rust-overlay,
    ...
  }: let
    lib = nixpkgs.lib;
    system = "x86_64-linux";
  in {
    nixosConfigurations = {
      machine = lib.nixosSystem {
        inherit system;
        specialArgs = {inherit inputs;};
        modules = [
          ./configuration.nix
          home-manager.nixosModules.home-manager
          {nixpkgs.overlays = [rust-overlay.overlays.default];}
          {
            home-manager.extraSpecialArgs = {inherit inputs;};

            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.sharedModules = [noctalia.homeModules.default];
          }
        ];
      };
    };
  };
}
