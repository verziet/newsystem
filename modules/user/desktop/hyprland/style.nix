{
  lib,
  config,
  ...
}:
lib.mkIf config.hyprland.enableModule {
  wayland.windowManager.hyprland.settings = let
    inherit (lib) mkDefault;
  in {
    general = {
      no_border_on_floating = false |> mkDefault;

      gaps_in = 5 |> mkDefault;
      gaps_out = 10 |> mkDefault;
      gaps_workspaces = 0 |> mkDefault;

      border_size = 0 |> mkDefault;

      "col.active_border" = "rgba(ffffffff)" |> mkDefault;
      "col.inactive_border" = "rgba(ffffffff)" |> mkDefault;

      "col.nogroup_border_active" = "rgba(ffffffff)" |> mkDefault;
      "col.nogroup_border" = "rgba(ffffffff)" |> mkDefault;
    };

    decoration = {
      blur = {
        enabled = false |> mkDefault;
      };

      rounding = 15 |> mkDefault;
      rounding_power = 2 |> mkDefault;

      active_opacity = 0.9 |> mkDefault;
      inactive_opacity = 0.9 |> mkDefault;
      fullscreen_opacity = 1.0 |> mkDefault;
    };

    animations = {
      enabled = true |> mkDefault;

      bezier = mkDefault [
        "expressiveFastSpatial, 0.42, 1.67, 0.21, 0.90"
        "expressiveSlowSpatial, 0.39, 1.29, 0.35, 0.98"
        "expressiveDefaultSpatial, 0.38, 1.21, 0.22, 1.00"
        "emphasizedDecel, 0.05, 0.7, 0.1, 1"
        "emphasizedAccel, 0.3, 0, 0.8, 0.15"
        "standardDecel, 0, 0, 0, 1"
        "menu_decel, 0.1, 1, 0, 1"
        "menu_accel, 0.52, 0.03, 0.72, 0.08"
      ];

      animation = mkDefault [
        "windowsIn, 1, 3, emphasizedDecel, popin 80%"
        "windowsOut, 1, 2, emphasizedDecel, popin 90%"
        "windowsMove, 1, 3, emphasizedDecel, slide"
        "border, 1, 10, emphasizedDecel"
        "layersIn, 1, 2.7, emphasizedDecel, popin 93%"
        "layersOut, 1, 2, menu_accel, popin 94%"
        "fadeLayersIn, 1, 0.5, menu_decel"
        "fadeLayersOut, 1, 2.2, menu_accel"
        "workspaces, 1, 7, menu_decel, slide"
        "specialWorkspaceIn, 1, 2.8, emphasizedDecel, slidevert"
        "specialWorkspaceOut, 1, 1.2, emphasizedAccel, slidevert"
      ];
    };
  };
}
