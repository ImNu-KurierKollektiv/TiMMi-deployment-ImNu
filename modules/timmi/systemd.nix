{config, pkgs, ...}:
{
  ## TODO: separate services for client/server + add service for invoice

  systemd.services = {
    "timmi-client" = {
      path = with pkgs; [ nix git ];
      script = ''
        nix run
      '';
      serviceConfig = rec {
        WorkingDirectory = "${config.users.users."timmi-client".home}/pro";
        User = "timmi-client";
        Group = config.users.users."timmi-client".group;
      };
      wantedBy = [ "multi-user.target" ];
    };
  };
}
