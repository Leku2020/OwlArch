#!/usr/bin/env bash

# Creation of groups
groupadd admin
groupadd basicuser
groupadd techuser

# User creation with the generated groups assigned
useradd -m -g basicuser analyst
useradd -m -g admin owl
useradd -m -g techuser binexp
useradd -m -g techuser forensic
useradd -m -g techuser netsec
useradd -m -g techuser osint

# Configuration of ACL's
setfacl -m g:basicuser:r-- /usr/bin/tech
setfacl -m g:techuser:rx /usr/bin/tech