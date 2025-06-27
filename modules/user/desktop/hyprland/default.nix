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
  config = lib.mkIf config.${moduleName}.enableModule {
    wayland.windowManager.hyprland = {
      enable = true |> mkForce;
      package = inputs.hyprland.packages.${host.system}.hyprland |> mkDefault;

      settings = mkDefault {
        exec = lib.mkIf ((lib.elem pkgs.kanata-with-cmd config.home.packages) || (lib.elem pkgs.kanata config.home.packages)) [
          "uwsm app -- kanata -c ${modules}/desktop/kanata/kanata.kbd"
        ];

        monitor =
          [
            # TODO
            "desc:Chimei Innolux Corporation 0x1521, 1920x1080@144, 0x0, 1.2"
            "desc:Microstep MSI G27CQ4 0x000008D3,2560x1440@120,-320x-1440,1"
            "desc:Vestel Elektronik Sanayi ve Ticaret A. S. 24W_LCD_TV,1920x1080@60,-1400x-1440,1,transform,1"
          ]
          |> mkDefault;

        general =
          {
            gaps_in = 5 |> mkDefault;
            gaps_out = 10 |> mkDefault;

            border_size = 1 |> mkDefault;

            "col.active_border" = "rgba(ffffffff)" |> mkDefault;
            "col.inactive_border" = "rgba(ffffffff)" |> mkDefault;

            resize_on_border = true |> mkDefault;

            layout = "dwindle" |> mkDefault;
          }
          |> mkDefault;

        decoration =
          {
            rounding = 5 |> mkDefault;

            active_opacity = 1.0 |> mkDefault;
            inactive_opacity = 1.0 |> mkDefault;
          }
          |> mkDefault;

        animations = {
          enabled = true |> mkDefault;

          # Animation curves TODO
          bezier = [
            "linear, 0, 0, 1, 1"
            "md3_standard, 0.2, 0, 0, 1"
            "md3_decel, 0.05, 0.7, 0.1, 1"
            "md3_accel, 0.3, 0, 0.8, 0.15"
            "overshot, 0.05, 0.9, 0.1, 1.1"
            "crazyshot, 0.1, 1.5, 0.76, 0.92 "
            "hyprnostretch, 0.05, 0.9, 0.1, 1.0"
            "menu_decel, 0.1, 1, 0, 1"
            "menu_accel, 0.38, 0.04, 1, 0.07"
            "easeInOutCirc, 0.85, 0, 0.15, 1"
            "easeOutCirc, 0, 0.55, 0.45, 1"
            "easeOutExpo, 0.16, 1, 0.3, 1"
            "softAcDecel, 0.26, 0.26, 0.15, 1"
            "md2, 0.4, 0, 0.2, 1ion"
          ];

          # Animation configs
          animation = [
            "windows, 1, 3, md3_decel, popin 60%"
            "windowsIn, 1, 3, md3_decel, popin 60%"
            "windowsOut, 1, 3, md3_accel, popin 60%"
            "border, 1, 10, default"
            "fade, 1, 3, md3_decel"
            "layersIn, 1, 3, menu_decel, slide"
            "layersOut, 1, 1.6, menu_accel"
            "fadeLayersIn, 1, 2, menu_decel"
            "fadeLayersOut, 1, 0.5, menu_accel"
            "workspaces, 1, 7, menu_decel, slide"
            "specialWorkspace, 1, 3, md3_decel, slidevert"
          ];

          #layers, 1, 2, md3_decel, slide
          #workspaces, 1, 2.5, softAcDecel, slide
          #workspaces, 1, 7, menu_decel, slidefade 15%
          #specialWorkspace, 1, 3, md3_decel, slidefadevert 15%
        };

        dwindle =
          {
            pseudotile = true |> mkDefault;
            preserve_split = true |> mkDefault;
          }
          |> mkDefault;

        misc =
          {
            force_default_wallpaper = 0 |> mkDefault;
            disable_hyprland_logo = true |> mkDefault;
          }
          |> mkDefault;

        input =
          {
            kb_layout = "us" |> mkDefault;

            follow_mouse = 1 |> mkDefault;

            sensitivity = 0 |> mkDefault;
            repeat_delay = 250 |> mkDefault;

            touchpad =
              {
                natural_scroll = true |> mkDefault;
                tap-to-click = true |> mkDefault;
              }
              |> mkDefault;
          }
          |> mkDefault;

        gestures =
          {
            #TODO
            workspace_swipe = true |> mkDefault;
            workspace_swipe_fingers = 3 |> mkDefault;
            workspace_swipe_invert = true |> mkDefault;
            workspace_swipe_forever = true |> mkDefault;
            workspace_swipe_cancel_ratio = 0.25 |> mkDefault;
          }
          |> mkDefault;

        bind = pkgs |> import ./binds.nix |> mkDefault;
      };
    };
  };

  options.${moduleName}.enableModule = lib.mkOption {
    description = "Enable the ${moduleName} module";
    default = true;
    type = lib.types.bool;
  };
}
