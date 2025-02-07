#!/usr/bin/bash -x

echo ">>>> qemu.sh: Installing Qemu Guest Additions and NFS utilities.."
/usr/bin/pacman -Sy --noconfirm qemu-guest-agent nfs-utils

echo ">>>> qemu.sh: Enabling RPC Bind service.."
/usr/bin/systemctl enable rpcbind.service

echo ">>>> qemu.sh: Enabling Qemu Guest service.."
/usr/bin/systemctl enable qemu-guest-agent.service


