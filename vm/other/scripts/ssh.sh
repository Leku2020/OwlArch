#!/usr/bin/env bash

if [ $# -lt 1 ]
then
    echo "Error command line : $0 <password> "
    exit 1
fi


/usr/bin/useradd --comment 'packer' --create-home --user-group packer
echo "packer:$1" | /usr/bin/chpasswd 
echo 'Defaults env_keep += "SSH_AUTH_SOCK"' > /etc/sudoers.d/packer
echo 'packer ALL=(ALL) NOPASSWD: ALL' >> /etc/sudoers.d/packer
/usr/bin/chmod 0440 /etc/sudoers.d/packer
/usr/bin/systemctl start sshd.service
