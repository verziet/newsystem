{
  lib,
  config,
  ...
}: let
  moduleName = "kitty";

  inherit (lib) mkDefault mkForce;
in {
  config = lib.mkIf config.${moduleName}.enableModule {
    programs.kitty = {
      enable = true |> mkForce;

      settings = {
        cursor_trail = 1 |> mkDefault;
      };
    };
  };

  options.${moduleName}.enableModule = lib.mkOption {
    description = "Enable the ${moduleName} module";
    default = true;
    type = lib.types.bool;
  };
}
