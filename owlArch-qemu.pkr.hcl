build {

  sources = ["source.qemu.archlinux"]

provisioner "shell" {
    only            = ["qemu.archlinux"]
    environment_vars =[
        "PACKER_BUILDER_TYPE=${var.packer_build_type}",
        "IS_UEFI=${var.is_uefi}",
        "COUNTRIES=${var.countries}",
        "ADDITIONAL_PKGS=${var.arch_add_pkgs}",
        "HOSTNAME=${var.hostname}",
        "KEYMAP=${var.keymap}",
        "LANGUAGE=${var.language}",
        "PACKER_PASSWORD=${var.packer_password}",
    ]
    execute_command   = "{{ .Vars }} sudo -E -S bash '{{ .Path }}'"
    expect_disconnect = true
    script            = "scripts/setup.sh"
  }

#  provisioner "shell" {
#    execute_command = "{{ .Vars }} sudo -E -S bash '{{ .Path }}'"
#    only            = ["qemu.archlinux"]
#    script          = "scripts/qemu.sh"
#  }

 
  provisioner "shell" {
    environment_vars =[
        "WRITE_ZEROS=${var.write_zeros}"
    ]
    execute_command = "{{ .Vars }} sudo -E -S bash '{{ .Path }}'"
    script          = "scripts/cleanup.sh"
  }

#  provisioner "shell" {
#    execute_command = "{{ .Vars }} sudo -E -S bash '{{ .Path }}'"
#    script          = "scripts/gnome.sh"
#  }
}
