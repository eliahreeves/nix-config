# My Multi-Host Modular Nix Config
Flake based with both NixOS and non-NixOS Home Manager configs. README for my own reference, and to provide an example to anyone struggling to get started. Structure is based on the teachings of [Vimjoyer](https://www.youtube.com/@vimjoyer). 
## Activation

1. First, clone the repo to `~/.`

2. Choose a host, or [create one](#Adding a New Host). The existing host are the names of the directories in the root of the repo. Currently the available hosts are [computer](./computer) (my NixOS daily), [nimh](./nimh) (sort of a server/home-lab, and [wsl](./wsl) (a non-NixOS config). If using an existing host config on a new machine/fresh install with NixOS you need to replace the `hardware-configuration.nix` file with a correctly generated one from `/etc/nixos`.

3. Rebuild

On NixOS run `sudo nixos-rebuild switch --flake ~/nix-config#NAME_OF_HOST`.

On a non-NixOS system you will first need to install Nix packages and Home Manager. Home Manager can be installed with the following:

```bash
# enable flakes
echo "experimental-features = nix-command flakes" | sudo tee -a /etc/nix/nix.conf >/dev/null

# install home manager from a flake
nix run github:nix-community/home-manager -- switch --flake ~/nix-config#wsl
```

After Home Manager is installed you can rebuild using `home-manager --flake "$HOME/nix-config#NAME_OF_HOST" switch`

After the first build the command aliased in my zsh module `rebuild-nix` should work for either system. Note that if you are on Mac OS you will probably need to change things a bit to use the darwin command.

A lot of the application config in the repo is dependent on my [dotfiles repo](https://github.com/eliahreeves/.dotfiles/tree/main).

## Updating the System

To update everything run: 

 1. `cd ~/nix-config`

 Go to config.

 2. `nix flake update` 

 Update the lock file.

 3. `rebuild-nix`

 Alias to rebuild current host if using [my zsh module](./homeManagerModules/zsh.nix). Equivalent to `sudo nixos-rebuild switch --flake ~/nix-config#NAME_OF_HOST` on NixOS or `home-manager --flake ~/nix-config#NAME_OF_HOST` on a non-NixOS system.
