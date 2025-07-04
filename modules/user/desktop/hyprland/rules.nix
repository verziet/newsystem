{
  lib,
  config,
  ...
}:
lib.mkIf config.hyprland.enableModule {
  wayland.windowManager.hyprland.settings = let
    inherit (lib) mkDefault;
  in {
    # Quickshell
    layerrule = [
      "blurpopups, quickshell:.*"
      "blur, quickshell:.*"
      "ignorealpha 0.79, quickshell:.*"
      "animation slide, quickshell:bar"
      "animation fade, acheron:screenCorners"
      "animation slide right, quickshell:sidebarRight"
      "animation slide left, quickshell:sidebarLeft"
      "animation slide bottom, quickshell:osk"
      "animation slide bottom, quickshell:dock"
      "blur, quickshell:session"
      "noanim, quickshell:session"
      "ignorealpha 0, quickshell:session"
      "animation fade, quickshell:notificationPopup"
      "blur, quickshell:backgroundWidgets"
      "ignorealpha 0.05, quickshell:backgroundWidgets"
      "noanim, quickshell:screenshot"
			"animation fade, quickshell:overview"
			"blur, shell:bar"
			"ignorezero, shell:bar"
			"blur, shell:notifications"
			"ignorealpha 0.1, shell:notifications"
    ];
  };
}
