{pkgs, ...}: [
  # Launching apps
  "SUPER, RETURN, exec, uwsm app -- ${pkgs.kitty}/bin/kitty"

  # Desktop binds
  "SUPER, X, killactive,"

  # Moving focus between windows
  "SUPER, H, movefocus, l"
  "SUPER, L, movefocus, r"
  "SUPER, K, movefocus, u"
  "SUPER, J, movefocus, d"

  # Swapping windows
  "SUPER ALT, H, swapwindow, l"
  "SUPER ALT, L, swapwindow, r"
  "SUPER ALT, K, swapwindow, u"
  "SUPER ALT, J, swapwindow, d"

  # Switching to a workspace
  "SUPER, 1, workspace, 1"
  "SUPER, 2, workspace, 2"
  "SUPER, 3, workspace, 3"
  "SUPER, 4, workspace, 4"
  "SUPER, 5, workspace, 5"
  "SUPER, 6, workspace, 6"
  "SUPER, 7, workspace, 7"
  "SUPER, 8, workspace, 8"
  "SUPER, 9, workspace, 9"
  "SUPER, 0, workspace, 10"

  # Moving window to a workspace
  "SUPER ALT, 1, movetoworkspace, 1"
  "SUPER ALT, 2, movetoworkspace, 2"
  "SUPER ALT, 3, movetoworkspace, 3"
  "SUPER ALT, 4, movetoworkspace, 4"
  "SUPER ALT, 5, movetoworkspace, 5"
  "SUPER ALT, 6, movetoworkspace, 6"
  "SUPER ALT, 7, movetoworkspace, 7"
  "SUPER ALT, 8, movetoworkspace, 8"
  "SUPER ALT, 9, movetoworkspace, 9"
  "SUPER ALT, 0, movetoworkspace, 10"

  # Moving window to a workspace (silent)
  "SUPER ALT SHIFT, 1, movetoworkspacesilent, 1"
  "SUPER ALT SHIFT, 2, movetoworkspacesilent, 2"
  "SUPER ALT SHIFT, 3, movetoworkspacesilent, 3"
  "SUPER ALT SHIFT, 4, movetoworkspacesilent, 4"
  "SUPER ALT SHIFT, 5, movetoworkspacesilent, 5"
  "SUPER ALT SHIFT, 6, movetoworkspacesilent, 6"
  "SUPER ALT SHIFT, 7, movetoworkspacesilent, 7"
  "SUPER ALT SHIFT, 8, movetoworkspacesilent, 8"
  "SUPER ALT SHIFT, 9, movetoworkspacesilent, 9"
  "SUPER ALT SHIFT, 0, movetoworkspacesilent, 10"
]
