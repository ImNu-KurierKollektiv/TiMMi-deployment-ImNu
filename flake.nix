{
  description = "TiMMi setup of ImNu";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-deploy-git = {
      url = "github:johannesloetzsch/nix-deploy-git/main";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    dns = {
      url = "github:kirelagin/dns.nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    timmi-deployment = {
      url = "path:/etc/nixos/timmi~/deployment";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, sops-nix, nix-deploy-git, dns, timmi-deployment }:
  let
    system = "x86_64-linux";
    pkgs = import nixpkgs { inherit system; };
    inherit (pkgs) lib;

    commonAttrs = { inherit system; };
  in rec {

    nixosConfigurations = {

      timmi-imnu = nixpkgs.lib.nixosSystem (lib.mergeAttrs commonAttrs {
        modules = [
          ./hosts/timmi-imnu/configuration.nix
          ./hosts/timmi-imnu/hardware-configuration.nix
          timmi-deployment.nixosModules.default
          ./modules/dns.nix { _module.args = { inherit dns; }; }
        ];
      });

    };
  };
}
