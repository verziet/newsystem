{
  lib,
  config,
  pkgs,
  username,
  ...
}: let
  moduleName = "kanata";

  inherit (lib) mkDefault mkForce;
in {
  config = lib.mkIf config.${moduleName}.enableModule {
    home = {
      packages = with pkgs; [
        kanata-with-cmd
        brightnessctl
        playerctl
        wireplumber
      ];

      file."${config.xdg.configHome}/kanata/kanata.kbd".source = ./kanata.kbd |> mkDefault;
    };
  };

  options.${moduleName}.enableModule = lib.mkOption {
    description = "Enable the ${moduleName} module";
    default = true;
    type = lib.types.bool;
  };
}
