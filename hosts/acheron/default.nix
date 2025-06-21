{modules, ...}: {
  imports =
    [
      "${modules}/bootloader/grub"
      "${modules}/hardware/networkmanager"
      "${modules}/hardware/pipewire"

      "${modules}/services/kanata"

      "${modules}/desktop/hyprland"
    ]
    ++ [
      ./hardware.nix
    ];

  users.users.verz.extraGroups = ["wheel"];
}
