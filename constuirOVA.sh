#!/bin/bash

packer plugins install github.com/hashicorp/qemu
packer validate -var-file vars.pkr.pkrvars.hcl . 

packer init -var-file vars.pkr.pkrvars.hcl . 
packer build -var-file vars.pkr.pkrvars.hcl .
