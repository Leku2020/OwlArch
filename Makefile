VARFILE = "vars/vars.pkrvars.hcl"

init:
	packer init packer

validate:
	packer validate -var-file $(VARFILE)  .

build:
	packer build -on-error=ask -timestamp-ui -var-file $(VARFILE) .

