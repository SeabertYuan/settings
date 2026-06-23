let
  chocolatecarrot = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOcKqt+/kugD4C/VQKTkkC9CcHTPGvreYP1NmErhyoAB root@chocolatecarrot";
  caramelapple = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEI6uHkTas/JiM7YNAGBfXbUSpiVZEM5N7qXv2WSQVMc seabert@Seaberts-MacBook-Pro.local";
in {
  "wg-key-chocolatecarrot.age".publicKeys = [
    chocolatecarrot
    caramelapple
  ];
}
