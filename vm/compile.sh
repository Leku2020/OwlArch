#!/usr/bin/env bash
sudo rm -r work/
sudo rm -r out/
mkdir work
mkdir out
ln -s /usr/lib/systemd/system/vboxservice.service /home/edu/blank/archiso/owlArch/airootfs/etc/systemd/system/multi-user.target.wants/vboxservice.service
ln -sf /usr/lib/systemd/system/gdm.service /home/edu/blank/archiso/owlArch/airootfs/etc/systemd/system/display-manager.service
ln -sf /usr/lib/systemd/system/NetworkManager.service /home/edu/blank/archiso/owlArch/airootfs/etc/systemd/system/multi-user.target.wants/NetworkManager.service
ln -sf /usr/lib/systemd/system/dhcpcd.service /home/edu/blank/archiso/owlArch/airootfs/etc/systemd/system/multi-user.target.wants/dhcpcd.service
sudo mkarchiso -v -w work -o out "/home/edu/blank/archiso/owlArch"
