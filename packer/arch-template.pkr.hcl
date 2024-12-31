# Definición del builder QEMU
source "qemu" "archlinux" {
  iso_url           = "https://geo.mirror.pkgbuild.com/iso/2024.12.01/archlinux-2024.12.01-x86_64.iso"
  iso_checksum      = "56b246d1a569f1670c0f98198f5c9a32558d54d010cd3434356cc1e20ad97945"
  output_directory  = "output"
  vm_name           = "owlArch"
  disk_size         = 20000
  headless          = false
  format            = "qcow2"
  ssh_username      = "owlArch"
  ssh_password      = "owlArch"
  ssh_timeout       = "30m"

  qemuargs = [
    ["-netdev", "user,id=net0,hostfwd=tcp::2222-:22"],
    ["-device", "virtio-net-pci,netdev=net0"],
  ]

  boot_command = [
    "<esc><wait>",
    "/arch/boot/x86_64/vmlinuz-linux initrd=/arch/boot/x86_64/initramfs-linux.img root=/dev/vda1 rw edd=off console=ttyS0<enter><wait>",
    "<wait>",
    "<enter><wait>",
    "setfont ter-116n<enter>",
    "root<enter><wait>",
    "loadkeys us<enter>",
    "curl -O http://{{ .HTTPIP }}:{{ .HTTPPort }}/setup.sh<enter>",
    "chmod +x setup.sh<enter>",
    "./setup.sh<enter>"
  ]
}

# Definición de los provisioners
build {
  sources = ["source.qemu.archlinux"]

  provisioner "shell" {
    # Para local
    script = "/home/osArch/Desktop/owlArch/OwlArch/scripts/postinstall.sh"
    # Para git
    #script = "./scripts/postinstall.sh"
  }
}
