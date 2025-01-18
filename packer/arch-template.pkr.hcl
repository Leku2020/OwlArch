# Definición del builder QEMU
source "qemu" "archlinux" {
  iso_url           = "https://geo.mirror.pkgbuild.com/iso/2024.12.01/archlinux-2024.12.01-x86_64.iso"
  iso_checksum      = "56b246d1a569f1670c0f98198f5c9a32558d54d010cd3434356cc1e20ad97945"
  output_directory  = "output"
  vm_name           = "owlArch"
  disk_size         = 10000
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
    "<enter><wait>",  # Espera para que el sistema esté listo para recibir el comando
    "/arch/boot/x86_64/vmlinuz-linux initrd=/arch/boot/x86_64/initramfs-linux.img root=/dev/vda1 rw edd=off rootdelay=10 nomodeset<enter><wait><wait><wait>",  # Espera suficiente después de iniciar el arranque
    "<wait><wait><wait>",  # Espera más tiempo para asegurarse de que el sistema ha arrancado
    "lsblk<enter><wait>",  # Verificar las particiones disponibles
    "<wait><wait><wait>",  # Espera adicional para asegurar que lsblk termine
    "ping -c 4 8.8.8.8<enter><wait><wait>",  # Verificar la conectividad de red
    "curl -O http://{{ .HTTPIP }}:{{ .HTTPPort }}/setup.sh<enter><wait><wait>",  # Descargar el script
    "chmod +x setup.sh<enter><wait>",  # Hacer el script ejecutable
    "sleep 15<enter>",  # Espera adicional si es necesario
    "./setup.sh<enter>"  # Ejecutar el script setup.sh
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
