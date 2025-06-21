{
  lib,
  pkgs,
  config,
  ...
}: let
  moduleName = "kanata";

	inherit (lib) mkDefault mkForce;
in {
  config = lib.mkIf config.${moduleName}.enableModule {
		# using these packages within kanata.kbd config
    environment.systemPackages = with pkgs; [
      playerctl
      brightnessctl
      wireplumber
    ];

    services.kanata = {
      enable = true |> mkForce;
      package = pkgs.kanata-with-cmd |> mkDefault;

      keyboards.internalKeyboard = {
        devices = [];

        extraDefCfg = ''
          danger-enable-cmd yes ;; enable commands
          process-unmapped-keys yes ;; keys undefined in defsrc will be processed
          block-unmapped-keys yes ;; keys undefined in defsrc will be blocked
        '' |> mkDefault;

        config = lib.readFile ./kanata.kbd |> mkDefault;
      };
    };
  };

  options.${moduleName}.enableModule = lib.mkOption {
    description = "Enable the ${moduleName} module";
    default = true;
    type = lib.types.bool;
  };
}
