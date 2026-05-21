# Multi-Host Nix Config
### Hosts
- [Computer](./modules/hosts/computer/) - Main machine
- [nimh](./modules/hosts/nimh/) - Home server
### Try My Neovim
```bash
nix run github:eliah-reeves/nix-config#neovim
```
### Issues
Some features import other features for convenience. This can cause duplicate import errors. This is a [bug](https://github.com/hercules-ci/flake-parts/pull/251). Workaround is to add the `key` parameter.
