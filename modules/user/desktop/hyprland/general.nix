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
    monitor = mkDefault [
      ",preferred,auto,1.25,transform, 0"
    ];

    general = {
      layout = "dwindle" |> mkDefault;

      allow_tearing = false |> mkDefault;

      snap = {
        enabled = true |> mkDefault;

        window_gap = 10 |> mkDefault;
        monitor_gap = 10 |> mkDefault;
        border_overlap = true |> mkDefault;
      };

      resize_on_border = true |> mkDefault;
      extend_border_grab_area = 15 |> mkDefault;
    };

    dwindle = {
      pseudotile = true |> mkDefault;
      preserve_split = true |> mkDefault;
    };

    misc = {
      force_default_wallpaper = 0 |> mkDefault;
      disable_hyprland_logo = true |> mkDefault;
    };

    input = {
      kb_layout = "us" |> mkDefault;

      follow_mouse = 1 |> mkDefault;

      sensitivity = 0 |> mkDefault;
      repeat_delay = 250 |> mkDefault;

      touchpad = {
        natural_scroll = true |> mkDefault;
        tap-to-click = true |> mkDefault;
				drag_lock = 0 |> mkDefault;
      };
    };

    gestures = {
      workspace_swipe = true |> mkDefault;
      workspace_swipe_fingers = 3 |> mkDefault;
      workspace_swipe_invert = true |> mkDefault;
      workspace_swipe_forever = true |> mkDefault;
      workspace_swipe_cancel_ratio = 0.25 |> mkDefault;
    };
  };
}
