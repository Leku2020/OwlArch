# #################
# DISK INFO
# #################
variable "is_uefi" {
  type    = string
  default = "false"
}

variable "packer_build_type" {
  type    = string
  default = "qemu"
}

variable "write_zeros" {
  type    = string
  default = "false"
}

# #################
# TEMPLATE VARS
# #################
variable "arch_add_pkgs" {
  type    = string
  default = ""
}

variable "countries" {
  type    = string
  default = "Spain"
}

variable "hostname" {
  type    = string
  default = "OwlArch"
}

variable "keymap" {
  type    = string
  default = "es"
}

variable "language" {
  type    = string
  default = "es_ES.UTF-8"
}

variable "template_name" {
  type    = string
  default = "owlArch"
}

variable "packer_password" {
  type      = string
  default   = "packer"
  sensitive = true
}
# #################
#  VM VARS
# #################

variable "cpu" {
  type    = string
  default = "2"
}

variable "ram" {
  type    = string
  default = "4096"
}

variable "disk_size" {
  type    = string
  default = "20480"
}

# #################
#  BUILD VARS
# #################

variable "headless" {
  type    = string
  default = "true"
}
variable "shutdown_command" {
  type    = string
  default = "sudo shutdown now"
}

variable "ssh_timeout" {
  type    = string
  default = "20m"
}

variable "qemu_out_dir" {
  type    = string
}


# #################
#  ISO VARS
# #################

locals {
  version          = "${legacy_isotime("2006.01")}"
  iso_base_url     = "https://mirrors.kernel.org/archlinux/iso/{{isotime \"2006.01\"}}.01"
  iso_checksum_url = "${local.iso_base_url}/sha256sums.txt"
  iso_url          = "${local.iso_base_url}/archlinux-{{isotime \"2006.01\"}}.01-x86_64.iso"
  vm_name          = "${var.template_name}-archlinux-${local.version}"
}

