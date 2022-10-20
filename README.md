## Deployment

* configure `/etc/timmi`and `/etc/timmi-invoice` (or use sops)

## Updates

```bash
cd /etc/nixos
nix flake update
nixos-rebuild switch
```
