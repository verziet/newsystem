{
  lib,
  config,
  ...
}: let
  moduleName = "bluetooth";

  inherit (lib) mkForce;
in {
  config = lib.mkIf config.${moduleName}.enableModule {
    hardware.bluetooth.enable = true |> mkForce;
  };

  options.${moduleName}.enableModule = lib.mkOption {
    description = "Enable the ${moduleName} module";
    default = true;
    type = lib.types.bool;
  };
}
