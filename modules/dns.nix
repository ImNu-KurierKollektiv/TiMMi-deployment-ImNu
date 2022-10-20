{config, pkgs, dns, ...}:
let
   util = dns.util.${config.nixpkgs.system};
in
{
  services.bind = {
    enable = true;
    zones = {
      "${config.networking.domain}" = {
        master = true;
        file = util.writeZone "${config.networking.domain}" (import (./dns + "/${config.networking.domain}.nix") {inherit dns config;});
      };
    };
  };
  networking.firewall.allowedTCPPorts = [ 53 ];
  networking.firewall.allowedUDPPorts = [ 53 ];
}
