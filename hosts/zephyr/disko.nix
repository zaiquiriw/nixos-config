# Used this example: https://github.com/nix-community/disko/commit/01ec6024d655430f252263969a46a64c2833eeb4
# But I added a swap partition, a persistance subvolume, and a secure partition with an interactive password
{
  disko.devices = {
    disk = {
      main = {
        type = "disk";
        device = "/dev/nvme0n1";
        content = {
          type = "gpt";
          partitions = {
            ESP = {
              size = "512M";
              type = "EF00";
              content = {
                type = "filesystem";
                format = "vfat";
                mountpoint = "/boot";
                mountOptions = [
                  "defaults"
                ];
              };
            };
	    encryptedSwap = {
              size = "32G";
              content = {
                type = "swap";
                randomEncryption = true;
                priority = 100; # prefer to encrypt as long as we have space for it
              };
            };
	    secure = {
              size = "8G";
	      content = {
	        type = "luks";
		      name = "crypted";
		passwordFile = "/tmp/secret.key";
		settings = {
                  allowDiscards = true;
		};
	      };
	    };
            nixos = {
              end = "725G";
              content = {
                type = "btrfs";
                extraArgs = [ "-f" ];
                subvolumes = {
                  "/root" = {
                    mountpoint = "/";
                    mountOptions = [ "compress=zstd" "noatime" ];
                  };
                  "/home" = {
                    mountpoint = "/home";
                    mountOptions = [ "compress=zstd" "noatime" ];
                  };
                  "/nix" = {
                    mountpoint = "/nix";
                    mountOptions = [ "compress=zstd" "noatime" ];
                  };
		  "/log" = {
                    mountpoint = "/var/log";
	            mountOptions = [ "compress=zstd" "noatime" ];
		  };
		  "/persist" = {
		    mountpoint = "/persist";
		    mountOptions = [ "compress=zstd" "noatime" ];
		  };
                  "/swap" = {
                    mountpoint = "/.swapvol";
                    swap.swapfile.size = "20M";
                  };
                };
              };
            };
	  };
        };
      };
    };
  };
}
