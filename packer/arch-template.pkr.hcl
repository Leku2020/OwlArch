# Definición del builder QEMU
source "qemu" "archlinux" {
  iso_url           = "https://geo.mirror.pkgbuild.com/iso/2024.04.01/archlinux-2024.04.01-x86_64.iso"
  iso_checksum      = "1c92d4a3d6e8e4663f4212a7d9bc5ecf8e1045acfed4768492f0d3bb2e4039f9"
  iso_checksum_type = "sha256"
  output_directory  = "output"
  vm_name           = "arch-linux"
  disk_size         = 20000
  headless          = true
  format            = "qcow2"
  ssh_username      = "archuser"
  ssh_password      = "password"
  ssh_timeout       = "30m"

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
