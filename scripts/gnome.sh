#!/usr/bin/bash -x

whoami
pacman -Syu --noconfirm
pacman -S --noconfirm xorg xorg-server gnome gdm

echo ">>>> gnome.sh: Adding gdm to the OS startup..."
systemctl enable gdm
systemctl start gdm
