{
  lib,
  config,
  pkgs,
  ...
}:
lib.mkIf config.hyprland.enableModule {
  wayland.windowManager.hyprland.settings = let
    inherit (lib) mkDefault;
  in {
    exec-once = lib.mkIf ((lib.elem pkgs.kanata-with-cmd config.home.packages) || (lib.elem pkgs.kanata config.home.packages)) (
      mkDefault [
				"uwsm app -- qs &"
        "uwsm app -- kanata"
      ]
    );
  };
}
