{
  inputs,
  lib,
  config,
  host,
  ...
}: let
  moduleName = "hyprland";

  inherit (lib) mkDefault mkForce;
in {
  config = lib.mkIf config.${moduleName}.enableModule {
    nix.settings = {
      substituters = ["https://hyprland.cachix.org"];
      trusted-public-keys = ["hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="];
    };

    programs.uwsm.enable = true |> mkForce;

    programs.hyprland = let
      hyprPackages = inputs.hyprland.packages.${host.system};
    in {
      enable = true |> mkForce;
      withUWSM = true |> mkForce;

      xwayland.enable = true |> mkDefault;

      package = hyprPackages.hyprland |> mkDefault;
      portalPackage = hyprPackages.xdg-desktop-portal-hyprland |> mkDefault;
    };

    environment.sessionVariables.NIXOS_OZONE_WL = "1" |> mkDefault;
  };

  options.${moduleName}.enableModule = lib.mkOption {
    description = "Enable the ${moduleName} module";
    default = true;
    type = lib.types.bool;
  };
}
