{modules, ...}: {
  imports =
    [
      "${modules}/bootloader/grub"
      "${modules}/hardware/networkmanager"

      "${modules}/desktop/hyprland"
    ]
    ++ [
      ./hardware.nix
    ];

  users.users.verz.extraGroups = ["wheel"];
}
