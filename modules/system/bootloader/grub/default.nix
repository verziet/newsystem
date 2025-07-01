{
  pkgs,
  lib,
  config,
  ...
}: let
  moduleName = "grub";

  inherit (lib) mkDefault mkForce mkOverride;
in {
  config = lib.mkIf config.${moduleName}.enableModule {
    boot.loader = {
      timeout = null |> mkDefault;
      efi.canTouchEfiVariables = true |> mkDefault;

      grub = let
        extraEntries = ''
          menuentry "Reboot" --class restart {
          	reboot
          }

          menuentry "Shutdown" --class shutdown {
          	halt
          }
        '';
      in {
        enable = true |> mkForce;

        configurationLimit = 10 |> mkDefault;

        useOSProber = true |> mkDefault;
        efiSupport = true |> mkDefault;
        device = "nodev" |> mkDefault;

        theme = pkgs.minimal-grub-theme |> mkDefault;
        backgroundColor = "#000000" |> mkOverride 999;
        splashImage = null |> mkOverride 999;

        extraInstallCommands = mkDefault ''
          echo "${extraEntries}" >> /boot/grub/grub.cfg
        '';
      };
    };
  };

  options.${moduleName}.enableModule = lib.mkOption {
    description = "Enable the ${moduleName} module";
    default = true;
    type = lib.types.bool;
  };
}
