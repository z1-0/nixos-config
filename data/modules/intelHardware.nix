{
  boot.kernelModules = [ "kvm-intel" ];

  services.thermald.enable = true;
}
