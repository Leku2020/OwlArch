#!/bin/bash

packer plugins install github.com/hashicorp/qemu
packer validate packer/arch-template.pkr.hcl

packer init packer/arch-template.pkr.hcl
packer build packer/arch-template.pkr.hcl
