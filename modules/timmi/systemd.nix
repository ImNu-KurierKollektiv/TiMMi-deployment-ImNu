{config, pkgs, ...}:
{
  ## TODO: separate services for client/server

  systemd.services = {

    "timmi-client" = {
      path = with pkgs; [ nix git ];
      script = ''
        nix run
      '';
      serviceConfig = rec {
        Type = "forking";
        TimeoutStartSec = 600;
        WorkingDirectory = "${config.users.users."timmi-client".home}/pro";
        User = "timmi-client";
        Group = config.users.users."timmi-client".group;
      };
      wantedBy = [ "multi-user.target" ];
    };

    "timmi-invoice" = {
      path = with pkgs; [ nix git ];
      script = ''
        nix run
      '';
      serviceConfig = rec {
        Type = "simple";
        WorkingDirectory = "${config.users.users."timmi-invoice".home}/invoice";
        User = "timmi-invoice";
        Group = config.users.users."timmi-invoice".group;
      };
      wantedBy = [ "multi-user.target" ];
    };

  };
}
