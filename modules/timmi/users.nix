{config, pkgs, ...}:
{
  users.users = {
    "timmi-client" = {
      group = "timmi-client";
      home = "/var/lib/timmi-client";
      isSystemUser = true;
      createHome = true;
    };
    "timmi-server" = {
      group = "timmi-server";
      home = "/var/lib/timmi-server";
      isSystemUser = true;
      createHome = true;
    };
    "timmi-invoice" = {
      group = "timmi-invoice";
      home = "/var/lib/timmi-invoice";
      isSystemUser = true;
      createHome = true;
    };
  };

  users.groups = {
    "timmi-client" = {};
    "timmi-server" = {};
    "timmi-invoice" = {};
  };
}
