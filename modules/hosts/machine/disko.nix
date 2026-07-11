{inputs, ...}: {
  flake.modules.nixos.machine-disko = {...}: {
    imports = [
      inputs.disko.nixosModules.default
    ];

    fileSystems."/nix".neededForBoot = true;
    fileSystems."/persistent".neededForBoot = true;

    disko.devices.nodev = {
      "/" = {
        fsType = "tmpfs";
        mountOptions = [
          "size=25%"
          "mode=755"
        ];
      };
    };

    disko.devices.disk.main = {
      device = "/dev/disk/by-id/ata-OEM_Genuine_500GB_DW19102110059E5F6";
      type = "disk";

      content.type = "gpt";

      content.partitions.boot = {
        name = "boot";
        size = "1M";
        type = "EF02";
      };

      content.partitions.esp = {
        name = "ESP";
        size = "1G";
        type = "EF00";

        content = {
          type = "filesystem";
          format = "vfat";
          mountpoint = "/boot";
          mountOptions = ["fmask=0077" "dmask=0077"];
        };
      };

      content.partitions.luks = {
        size = "100%";
        content = {
          type = "luks";
          name = "crypted";
          askPassword = true;
          content = {
            type = "btrfs";
            extraArgs = ["-f"];

            subvolumes = {
              "@persistent" = {
                mountOptions = ["compress=zstd" "noatime"];
                mountpoint = "/persistent";
              };

              "@nix" = {
                mountOptions = ["compress=zstd" "noatime"];
                mountpoint = "/nix";
              };
              "@swap" = {
                mountpoint = "/swap";
                swap.swapfile.size = "20G";
              };
            };
          };
        };
      };
    };
  };
}
