{modules, ...}: {
  imports =
    [
      "${modules}/bootloader/grub"
      "${modules}/hardware/networkmanager"
    ]
    ++ [
      ./hardware.nix
    ];

  users.users.verz.extraGroups = ["wheel"];
}
