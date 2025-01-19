VARFILE = "vars/vars.pkr.hcl"

init:
	packer init packer

validate:
	packer validate -var-file $(VARFILE) packer

build:
	packer build -on-error=ask -timestamp-ui -var-file $(VARFILE) pakcer

