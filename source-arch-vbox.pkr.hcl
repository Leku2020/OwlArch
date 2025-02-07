source "virtualbox-iso" "archlinux" {
  boot_command         = [
  "<enter><wait10><wait10>",
  "/usr/bin/curl -O http://{{ .HTTPIP }}:{{ .HTTPPort }}/enable-ssh.sh<enter><wait2>",
  "/usr/bin/curl -O http://{{ .HTTPIP }}:{{ .HTTPPort }}/poweroff.timer<enter><wait2>",
  "/usr/bin/curl -O http://{{ .HTTPIP }}:{{ .HTTPPort }}/ansible.pub<enter><wait2>",
  "/usr/bin/curl -O http://{{ .HTTPIP }}:{{ .HTTPPort }}/init-vm.service<enter><wait2>",
  "/usr/bin/bash ./enable-ssh.sh ${var.packer_password}<enter>"
  ]
  boot_wait            = "5s"
  cpus                 = "${var.cpu}"
  disk_size            = "${var.disk_size}"
  guest_additions_mode = "disable"
  guest_os_type        = "ArchLinux_64"
  hard_drive_interface = "sata"
  headless             = "${var.headless}"
  http_directory       = "srv"
  iso_checksum         = "file:${local.iso_checksum_url}"
  iso_url              = "${local.iso_url}"
  memory               = "${var.ram}"
  shutdown_command     = "${var.shutdown_command}"
  ssh_password         = "${var.packer_password}"
  ssh_timeout          = "${var.ssh_timeout}"
  ssh_username         = "packer"
  vm_name              = "${local.vm_name}"
}

