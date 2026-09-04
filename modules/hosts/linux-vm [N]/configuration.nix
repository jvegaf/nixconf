{
  inputs,
  ...
}:
{
  flake.modules.nixos.linux-vm = {
    imports = with inputs.self.modules.nixos; [
      system-desktop
      systemd-boot
      bluetooth
    ];
  };
}
