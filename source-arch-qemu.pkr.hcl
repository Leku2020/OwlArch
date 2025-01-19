source "qemu" "archlinux" {
  accelerator      = "kvm"
  boot_command     = [
        "<enter><wait10><wait10><wait10>",
        "/usr/bin/curl -O http://{{ .HTTPIP }}:{{ .HTTPPort }}/ssh.sh<enter><wait2>",
        "/usr/bin/bash ./ssh.sh ${var.packer_password}<enter>"
    ]
  boot_wait        = "5s"
  cpus             = "${var.cpu}"
  disk_interface   = "virtio"
  disk_size        = "${var.disk_size}"
  format           = "qcow2"
  headless         = "${var.headless}"
  http_content     = {
    "/ssh.sh" = file("scripts/ssh.sh")
  }
  iso_checksum     = "file:${local.iso_checksum_url}"
  iso_url          = "${local.iso_url}"

  machine_type     = "q35"
  memory           = "${var.ram}"
  net_device       = "virtio-net"
  qemu_binary      = "qemu-system-x86_64"
  #qemuargs         = [
    #["-drive", "file={{.DiskImage}},if=virtio,format=qcow2"],
    #["-bios", "/usr/share/ovmf/OVMF.fd"],
    #["-boot", "uefi"]
  #]
  shutdown_command = "${var.shutdown_command}"
  ssh_password     = "${var.packer_password}"
  ssh_timeout      = "${var.ssh_timeout}"
  ssh_username     = "packer"
  vm_name          = "${local.vm_name}.qcow2"
  output_directory = "${var.qemu_out_dir}/${local.vm_name}"
}
