#!/bin/bash

packer plugins install github.com/hashicorp/qemu
packer validate source-arch-qemu.pkr.hcl

packer init source-arch-qemu.pkr.hcl 
packer build source-arch-qemu.pkr.hcl
