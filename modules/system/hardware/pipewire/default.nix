{
  lib,
  config,
  ...
}: let
  moduleName = "pipewire";

	inherit (lib) mkDefault mkForce;
in {
  config = lib.mkIf config.${moduleName}.enableModule {
    services.pipewire = {
      enable = true |> mkForce;

      pulse.enable = true |> mkDefault;

			alsa = {
				enable = true |> mkDefault;
				support32Bit = true |> mkDefault;
			};
    };

    security.rtkit.enable = true |> mkDefault;
  };

  options.${moduleName}.enableModule = lib.mkOption {
    description = "Enable the ${moduleName} module";
    default = true;
    type = lib.types.bool;
  };
}
