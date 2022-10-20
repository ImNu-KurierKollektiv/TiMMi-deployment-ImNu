{ config, pkgs, nixpkgs, ... }:
{
  imports = [
    ./common.nix
  ];

  security.acme.certs."${config.networking.domain}".extraDomainNames = [
    "client.${config.networking.domain}"
    "server.${config.networking.domain}"
    "invoice.${config.networking.domain}"
  ];

  services.nginx.virtualHosts = {
    "${config.networking.domain}" = {
      forceSSL = true;
      locations."/" = {
        proxyPass = "http://localhost:3000";
        proxyWebsockets = true;
        extraConfig = "proxy_pass_header Authorization;";
      };
    };
    "client.${config.networking.domain}" = {
      #default = true;  ## we would need cors settings supporting multiple hosts
      forceSSL = true;
      useACMEHost = config.networking.domain;
      locations."/" = {
        proxyPass = "http://localhost:3000";
        proxyWebsockets = true;
        extraConfig = "proxy_pass_header Authorization;";
      };
    };
    "server.${config.networking.domain}" = {
      forceSSL = true;
      useACMEHost = config.networking.domain;
      locations."/" = {
        proxyPass = "http://localhost:4000";
        extraConfig = "proxy_pass_header Authorization;";
      };
    };
    "invoice.${config.networking.domain}" = {
      forceSSL = true;
      useACMEHost = config.networking.domain;
      locations."/" = {
        proxyPass = "http://localhost:2300";
      };
    };
  };
}
