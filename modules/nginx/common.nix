{ config, pkgs, nixpkgs, ... }:
{
  security.acme = {
    acceptTerms = true;
    #defaults.email = "";
    preliminarySelfsigned = true;
    #server = "https://acme-staging-v02.api.letsencrypt.org/directory";
  };

  services.nginx = {
    enable = true;
    recommendedTlsSettings = true;
    recommendedOptimisation = true;
    recommendedGzipSettings = true;
    commonHttpConfig = ''
      #types_hash_max_size 1024;
      server_names_hash_bucket_size 128;
    '';

    virtualHosts = {
      "${config.networking.domain}" = {
        forceSSL = true;
        enableACME = true;
      };
    };
  };

  networking.firewall.allowedTCPPorts = [ 80 443 ];
}
