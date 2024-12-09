# Definición del builder QEMU
source "qemu" "archlinux" {
  iso_url           = "https://geo.mirror.pkgbuild.com/iso/2024.12.01/archlinux-2024.12.01-x86_64.iso"
  iso_checksum      = "56b246d1a569f1670c0f98198f5c9a32558d54d010cd3434356cc1e20ad97945"
  output_directory  = "output"
  vm_name           = "owlArch"
  disk_size         = 20000
  headless          = true
  format            = "qcow2"
  ssh_username      = "owlarch"
  ssh_password      = "password"
  ssh_timeout       = "30m"

  qemuargs = [
    "-netdev", "user,id=net0,hostfwd=tcp::2222-:22",  # Redirección de puertos
    "-device", "virtio-net-pci,netdev=net0"           # Interfaz de red virtio
  ]

  boot_command = [
    "<esc><wait>",
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
    script = "./scripts/postinstall.sh"
  }
}
