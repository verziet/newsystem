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
    bind = mkDefault (
      [
        # --- Launching Apps ---
        "SUPER, RETURN, exec, uwsm app -- ${pkgs.kitty}/bin/kitty"

        # --- Desktop Binds ---
        "SUPER, X, killactive,"

        # --- Moving focus between windows ---
        "SUPER, H, movefocus, l"
        "SUPER, L, movefocus, r"
        "SUPER, K, movefocus, u"
        "SUPER, J, movefocus, d"

        # --- Swapping windows ---
        "SUPER ALT, H, swapwindow, l"
        "SUPER ALT, L, swapwindow, r"
        "SUPER ALT, K, swapwindow, u"
        "SUPER ALT, J, swapwindow, d"
      ]
      ++ (
        lib.concatLists (10
          |> lib.genList (
            i: let
              wsNumber = toString (i + 1);
              key =
                if i == 9
                then "0"
                else wsNumber;
            in [
              # --- Switching to a workspace ---
              "SUPER, ${key}, workspace, ${wsNumber}"

              # --- Moving a window to a workspace ---
              "SUPER ALT, ${key}, movetoworkspace, ${wsNumber}"

              # --- Moving a window to a workspace (will not switch to the workspace afterwards) ---
              "SUPER ALT SHIFT, ${key}, movetoworkspacesilent, ${wsNumber}"
            ]
          ))
      )
    );
  };
}
