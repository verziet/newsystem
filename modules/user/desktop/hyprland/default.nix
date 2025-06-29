{
  lib,
  config,
  inputs,
  pkgs,
  host,
  modules,
  ...
}: let
  moduleName = "hyprland";

  inherit (lib) mkDefault mkForce;
in {
  imports = [
    ./general.nix
    ./binds.nix
    ./execs.nix
    ./style.nix
  ];

  config = lib.mkIf config.${moduleName}.enableModule {
    wayland.windowManager.hyprland = {
      enable = true |> mkForce;
      systemd.enable = false |> mkForce; # avoid conflicts with UWSM

      # Inherit system packages
      package = null |> mkDefault;
      portalPackage = null |> mkDefault;
    };
  };

  options.${moduleName}.enableModule = lib.mkOption {
    description = "Enable the ${moduleName} module";
    default = true;
    type = lib.types.bool;
  };
}
