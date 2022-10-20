{ dns, config, ... }:

with dns.lib.combinators; rec {
  SOA = {
    nameServer = "ns1";
    adminEmail = "${config.security.acme.defaults.email}";
    serial = 2022101900;
  };

  NS = [
    "ns1"
  ];

  A = [ "116.202.14.128" ];
  AAAA = [ "2a01:4f8:c012:f1e6::1" ];

  subdomains = rec {
    server1 = { inherit A AAAA; };

    ns1 = server1;

    grafana = server1;
    prometheus = server1;
    loki = server1;

    client = server1;
    server = server1;
    mongo = server1;
    smtp = server1;
    invoice = server1;
  };
}
