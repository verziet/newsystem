{
  lib,
  config,
  ...
}: let
  moduleName = "starship";

  inherit (lib) mkDefault mkForce mkIf;
in {
  config = lib.mkIf config.${moduleName}.enableModule {
    programs.starship = {
      enable = true |> mkForce;

      enableZshIntegration = true |> mkDefault |> mkIf config.programs.zsh.enable;
    };
  };

  options.${moduleName}.enableModule = lib.mkOption {
    description = "Enable the ${moduleName} module";
    default = true;
    type = lib.types.bool;
  };
}
