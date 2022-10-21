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
    timmi-invoice = {
      url = "path:/etc/nixos/timmi~/invoice";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, sops-nix, nix-deploy-git, dns, timmi-deployment, timmi-invoice }:
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
          timmi-deployment.nixosModules.default
          timmi-deployment.nixosModules.binarycache-client
          ./modules/dns.nix { _module.args = { inherit dns; }; }
          ./modules/nginx/common.nix
          ./modules/nginx/timmi.nix
          ./modules/timmi/users.nix
          ./modules/timmi/systemd.nix { _module.args = { inherit timmi-invoice; }; }
        ];
      });

    };
  };
}
