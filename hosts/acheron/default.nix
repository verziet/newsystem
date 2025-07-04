{modules, ...}: {
  imports =
    [
      "${modules}/bootloader/grub"
      "${modules}/hardware/networkmanager"
      "${modules}/hardware/pipewire"
      "${modules}/hardware/bluetooth"

      "${modules}/desktop/hyprland"
    ]
    ++ [
      ./hardware.nix
    ];

  time.timeZone = "Europe/Prague";

  boot.kernelModules = ["uinput"];
  hardware.uinput.enable = true;

  services.udev.extraRules = ''
    KERNEL=="uinput", MODE="0660", GROUP="uinput", OPTIONS+="static_node=uinput"
  '';

  users.users.verz.extraGroups = ["wheel" "uinput" "input"];
}
