#!/bin/bash
set -e

# Configuración básica de Arch
echo "Configuring OwlArch..."
timedatectl set-ntp true
ln -sf /usr/share/zoneinfo/UTC /etc/localtime
hwclock --systohc

# Idioma y teclado
echo "LANG=en_US.UTF-8" > /etc/locale.conf
echo "KEYMAP=us" > /etc/vconsole.conf
locale-gen

# Nombre del host
echo "owlArch" > /etc/hostname
cat <<EOF > /etc/hosts
127.0.0.1   localhost
::1         localhost
127.0.1.1   arch-vm.localdomain arch-vm
EOF

# Instalación mínima
pacstrap /mnt base linux linux-firmware
genfstab -U /mnt >> /mnt/etc/fstab
arch-chroot /mnt <<EOFCHROOT
pacman -Syu --noconfirm
EOFCHROOT
