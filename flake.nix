{
  description = "TiMMi setup of ImNu";

  outputs = { self, nixpkgs }: {
    nixosConfigurations = {

      timmi-imnu = {
        modules = [
          ./hosts/timmi-imnu/configuration.nix
          ./hosts/timmi-imnu/hardware-configuration.nix
        ];
      };

    };
  };
}
